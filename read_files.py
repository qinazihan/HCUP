import pandas as pd
import os
import time

n_rows = None

keep = [
    'APRDRG','APRDRG_Risk_Mortality','APRDRG_Severity',
    'DRG','DRG_NoPOA','HOSP_NIS','HOSPID',
    'I10_DXn',
    'I10_NDX',
    'I10_PRn',
    'KEY_NIS',
    'PAY1','PAY1_N','PAY1_X','PAY2','PAY2_N','PAY2_X',
    'PCLASS_ORPROC','PRCCSR_aaannn',
    'TOTCHG','TOTCHG_X'
]
keep = keep + [f'I10_PR{i}' for i in range(1, 26)]
keep_type = 'Sarah_'

# keep = None
# keep_type = ''
filetypes   = ['Core', 'Severity', 'DX_PR_GRPS', 'Hospital']
base_pattern = 'NIS_2022_{}'
prefix = f'samples_{n_rows}_' if n_rows is not None else ''

found = set()

for ft in filetypes:
    spec_path = os.path.join('data', f'FileSpecifications_NIS_2022_{ft}.txt')
    asc_path  = os.path.join('data', f'NIS_2022_{ft}.ASC')

    out_base   = keep_type + prefix + ft
    csv_path   = out_base + '.csv'

    colspecs_spec = []
    names_spec    = []
    with open(spec_path, 'r') as spec_file:
        for line in spec_file:
            parts = line.strip().split()
            if (len(parts) >= 7
                and parts[0] == 'NIS'
                and parts[2] == base_pattern.format(ft)
                and parts[3].isdigit()):
                name  = parts[4]
                start = int(parts[5]) - 1
                end   = int(parts[6])
                colspecs_spec.append((start, end))
                names_spec.append(name)

    if keep is None:
        colspecs_sub, names_sub = colspecs_spec, names_spec
        found.update(names_sub)
    else:
        filtered = [
            (spec, name)
            for spec, name in zip(colspecs_spec, names_spec)
            if name in keep
        ]
        if not filtered:
            print(f"No matching columns found in {ft}")
            continue

        colspecs_sub, names_sub = zip(*filtered)
        found.update(names_sub)

    # read and write in chunk
    chunksize = 200_000
    reader = pd.read_fwf(
        asc_path,
        colspecs=colspecs_sub,
        names=names_sub,
        dtype=str,
        iterator=True,
        chunksize=chunksize,
        memory_map=True
    )
    start_time = time.perf_counter()
    first_chunk = True
    for i, chunk in enumerate(reader, start=1):
        chunk_start = time.perf_counter()
        chunk.to_csv(
            csv_path,
            mode='w' if first_chunk else 'a',
            header=first_chunk,
            index=False
        )
        chunk_time = time.perf_counter() - chunk_start
        total_time = time.perf_counter() - start_time
        print(f"  chunk {i}: {len(chunk)} rows written in {chunk_time:.2f}s (elapsed {total_time:.2f}s)")
        first_chunk = False
    overall = time.perf_counter() - start_time
    print(
        f"✔ Chunked loaded {ft}: {i} chunks, ~{i * chunksize if n_rows is None else len(chunk)} rows → {csv_path} in {overall:.2f}s")

if keep is not None:
    missing = set(keep) - found
    if missing:
        raise ValueError(f"The following keep columns were not found in any spec: {missing}")
    else:
        print("✔ All keep columns covered.")

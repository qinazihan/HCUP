import re
import pandas as pd

spec_path  = 'FileSpecifications_NIS_2022_Core.txt'
sas_path   = 'SASLoad_NIS_2022_Core.sas'
asc_path   = 'NIS_2022_Core.ASC'
n_rows     = 100

prefix = f'samples_{str(n_rows)}_' if n_rows is not None else ''
file_name =  prefix + 'Core'

excel_path = file_name + '.xlsx'
csv_path   = file_name + '.csv'

# TXT
colspecs_spec = []
names_spec    = []
with open(spec_path, 'r') as f:
    for line in f:
        parts = line.strip().split()
        if len(parts) >= 7 and parts[0] == 'NIS' and parts[2] == 'NIS_2022_Core' and parts[3].isdigit():
            name  = parts[4]
            start = int(parts[5])    # 1-based
            end   = int(parts[6])    # inclusive, 1-based
            colspecs_spec.append((start - 1, end))
            names_spec.append(name)

# SAS
with open(sas_path, 'r') as f:
    sas_lines = f.readlines()

input_lines = []
in_input     = False
for line in sas_lines:
    stripped = line.strip()
    if stripped.upper().startswith('INPUT'):
        in_input = True
        input_lines.append(stripped[len('INPUT'):].rstrip())
        continue
    if in_input:
        if ';' in stripped:
            input_lines.append(stripped.split(';', 1)[0])
            break
        input_lines.append(stripped)

input_block = ' '.join(input_lines)
pattern     = r'@(\d+)\s+([A-Za-z_][A-Za-z0-9_]*)\s+(\$?\w+\d+\.?)'
matches     = re.findall(pattern, input_block)

colspecs_sas = []
names_sas    = []
for pos_str, varname, fmt in matches:
    start = int(pos_str) - 1
    m     = re.search(r'(\d+)', fmt)
    width = int(m.group(1)) if m else 1
    colspecs_sas.append((start, start + width))
    names_sas.append(varname)

# READ FILE
df_spec = pd.read_fwf(
    asc_path,
    colspecs=colspecs_spec,
    names=names_spec,
    nrows=n_rows,
    dtype=str
)
df_sas = pd.read_fwf(
    asc_path,
    colspecs=colspecs_sas,
    names=names_sas,
    nrows=n_rows,
    dtype=str
)


if not df_spec.equals(df_sas):
    raise ValueError("DISCREPANCY")

df_spec.to_excel(excel_path, index=False, engine='xlsxwriter')
df_spec.to_csv(csv_path, index=False)
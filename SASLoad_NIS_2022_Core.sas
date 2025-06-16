/*****************************************************************************
* SASload_NIS_2022_Core.SAS
* This program will load the NIS_2022_Core ASCII File into SAS.
* Created on 10/15/2024.
*****************************************************************************/

Options Compress=Yes;

*** Create SAS informats for missing values ***;
PROC FORMAT;
  INVALUE N2PF
    '-9' = .
    '-8' = .A
    '-6' = .C
    '-5' = .N
    OTHER = (|2.|)
  ;
  INVALUE N3PF
    '-99' = .
    '-88' = .A
    '-66' = .C
    OTHER = (|3.|)
  ;
  INVALUE N4PF
    '-999' = .
    '-888' = .A
    '-666' = .C
    OTHER = (|4.|)
  ;
  INVALUE N4P1F
    '-9.9' = .
    '-8.8' = .A
    '-6.6' = .C
    OTHER = (|4.1|)
  ;
  INVALUE N5PF
    '-9999' = .
    '-8888' = .A
    '-6666' = .C
    OTHER = (|5.|)
  ;
  INVALUE N5P2F
    '-9.99' = .
    '-8.88' = .A
    '-6.66' = .C
    OTHER = (|5.2|)
  ;
  INVALUE N6PF
    '-99999' = .
    '-88888' = .A
    '-66666' = .C
    OTHER = (|6.|)
  ;
  INVALUE N6P2F
    '-99.99' = .
    '-88.88' = .A
    '-66.66' = .C
    OTHER = (|6.2|)
  ;
  INVALUE N7P2F
    '-999.99' = .
    '-888.88' = .A
    '-666.66' = .C
    OTHER = (|7.2|)
  ;
  INVALUE N8PF
    '-9999999' = .
    '-8888888' = .A
    '-6666666' = .C
    OTHER = (|8.|)
  ;
  INVALUE N8P2F
    '-9999.99' = .
    '-8888.88' = .A
    '-6666.66' = .C
    OTHER = (|8.2|)
  ;
  INVALUE N8P4F
    '-99.9999' = .
    '-88.8888' = .A
    '-66.6666' = .C
    OTHER = (|8.4|)
  ;
  INVALUE N10PF
    '-999999999' = .
    '-888888888' = .A
    '-666666666' = .C
    OTHER = (|10.|)
  ;
  INVALUE N10P4F
    '-9999.9999' = .
    '-8888.8888' = .A
    '-6666.6666' = .C
    OTHER = (|10.4|)
  ;
  INVALUE N10P5F
    '-999.99999' = .
    '-888.88888' = .A
    '-666.66666' = .C
    OTHER = (|10.5|)
  ;
  INVALUE DATE10F
    '-999999999' = .
    '-888888888' = .A
    '-666666666' = .C
    OTHER = (|MMDDYY10.|)
  ;
  INVALUE N11P7F
    '-99.9999999' = .
    '-88.8888888' = .A
    '-66.6666666' = .C
    OTHER = (|11.7|)
  ;
  INVALUE N12P2F
    '-99999999.99' = .
    '-88888888.88' = .A
    '-66666666.66' = .C
    OTHER = (|12.2|)
  ;
  INVALUE N12P5F
    '-99999.99999' = .
    '-88888.88888' = .A
    '-66666.66666' = .C
    OTHER = (|12.5|)
  ;
  INVALUE N13PF
    '-999999999999' = .
    '-888888888888' = .A
    '-666666666666' = .C
    OTHER = (|13.|)
  ;
  INVALUE N15P2F
    '-99999999999.99' = .
    '-88888888888.88' = .A
    '-66666666666.66' = .C
    OTHER = (|15.2|)
  ;
RUN;

*** Data Step to load the file ***;
DATA NIS_2022_Core; 
INFILE 'NIS_2022_Core.ASC' LRECL = 647;

*** Define data element attributes ***;
ATTRIB 
  AGE                        LENGTH=3
  LABEL="Age in years at admission"

  AGE_NEONATE                LENGTH=3
  LABEL="Neonatal age (first 28 days after birth) indicator"

  AMONTH                     LENGTH=3
  LABEL="Admission month"

  AWEEKEND                   LENGTH=3
  LABEL="Admission day is a weekend"

  DIED                       LENGTH=3
  LABEL="Died during hospitalization"

  DISCWT                     LENGTH=8
  LABEL="NIS discharge weight"

  DISPUNIFORM                LENGTH=3
  LABEL="Disposition of patient (uniform)"

  DQTR                       LENGTH=3
  LABEL="Discharge quarter"

  DRG                        LENGTH=3
  LABEL="DRG in effect on discharge date"

  DRGVER                     LENGTH=3
  LABEL="DRG grouper version used on discharge date"

  DRG_NoPOA                  LENGTH=3
  LABEL="DRG in use on discharge date, calculated without POA"

  ELECTIVE                   LENGTH=3
  LABEL="Elective versus non-elective admission"

  FEMALE                     LENGTH=3
  LABEL="Indicator of sex"

  HCUP_ED                    LENGTH=3
  LABEL="HCUP Emergency Department service indicator"

  HOSP_DIVISION              LENGTH=3            FORMAT=2.
  LABEL="Census Division of hospital (STRATA)"

  HOSP_NIS                   LENGTH=4            FORMAT=5.
  LABEL="NIS hospital number"

  I10_BIRTH                  LENGTH=3
  LABEL="ICD-10-CM Birth Indicator"

  I10_DELIVERY               LENGTH=3
  LABEL="ICD-10-CM Delivery Indicator"

  I10_DX1                    LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 1"

  I10_DX2                    LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 2"

  I10_DX3                    LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 3"

  I10_DX4                    LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 4"

  I10_DX5                    LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 5"

  I10_DX6                    LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 6"

  I10_DX7                    LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 7"

  I10_DX8                    LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 8"

  I10_DX9                    LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 9"

  I10_DX10                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 10"

  I10_DX11                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 11"

  I10_DX12                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 12"

  I10_DX13                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 13"

  I10_DX14                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 14"

  I10_DX15                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 15"

  I10_DX16                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 16"

  I10_DX17                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 17"

  I10_DX18                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 18"

  I10_DX19                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 19"

  I10_DX20                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 20"

  I10_DX21                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 21"

  I10_DX22                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 22"

  I10_DX23                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 23"

  I10_DX24                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 24"

  I10_DX25                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 25"

  I10_DX26                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 26"

  I10_DX27                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 27"

  I10_DX28                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 28"

  I10_DX29                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 29"

  I10_DX30                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 30"

  I10_DX31                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 31"

  I10_DX32                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 32"

  I10_DX33                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 33"

  I10_DX34                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 34"

  I10_DX35                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 35"

  I10_DX36                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 36"

  I10_DX37                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 37"

  I10_DX38                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 38"

  I10_DX39                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 39"

  I10_DX40                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 40"

  I10_INJURY                 LENGTH=3
  LABEL="Injury ICD-10-CM diagnosis reported on record (1: First-listed injury; 2: Other than first-listed injury; 0: No injury)"

  I10_MULTINJURY             LENGTH=3
  LABEL="Multiple ICD-10-CM injuries reported on record"

  I10_NDX                    LENGTH=3
  LABEL="ICD-10-CM Number of diagnoses on this record"

  I10_NPR                    LENGTH=3
  LABEL="ICD-10-PCS Number of procedures on this record"

  I10_PR1                    LENGTH=$7
  LABEL="ICD-10-PCS Procedure 1"

  I10_PR2                    LENGTH=$7
  LABEL="ICD-10-PCS Procedure 2"

  I10_PR3                    LENGTH=$7
  LABEL="ICD-10-PCS Procedure 3"

  I10_PR4                    LENGTH=$7
  LABEL="ICD-10-PCS Procedure 4"

  I10_PR5                    LENGTH=$7
  LABEL="ICD-10-PCS Procedure 5"

  I10_PR6                    LENGTH=$7
  LABEL="ICD-10-PCS Procedure 6"

  I10_PR7                    LENGTH=$7
  LABEL="ICD-10-PCS Procedure 7"

  I10_PR8                    LENGTH=$7
  LABEL="ICD-10-PCS Procedure 8"

  I10_PR9                    LENGTH=$7
  LABEL="ICD-10-PCS Procedure 9"

  I10_PR10                   LENGTH=$7
  LABEL="ICD-10-PCS Procedure 10"

  I10_PR11                   LENGTH=$7
  LABEL="ICD-10-PCS Procedure 11"

  I10_PR12                   LENGTH=$7
  LABEL="ICD-10-PCS Procedure 12"

  I10_PR13                   LENGTH=$7
  LABEL="ICD-10-PCS Procedure 13"

  I10_PR14                   LENGTH=$7
  LABEL="ICD-10-PCS Procedure 14"

  I10_PR15                   LENGTH=$7
  LABEL="ICD-10-PCS Procedure 15"

  I10_PR16                   LENGTH=$7
  LABEL="ICD-10-PCS Procedure 16"

  I10_PR17                   LENGTH=$7
  LABEL="ICD-10-PCS Procedure 17"

  I10_PR18                   LENGTH=$7
  LABEL="ICD-10-PCS Procedure 18"

  I10_PR19                   LENGTH=$7
  LABEL="ICD-10-PCS Procedure 19"

  I10_PR20                   LENGTH=$7
  LABEL="ICD-10-PCS Procedure 20"

  I10_PR21                   LENGTH=$7
  LABEL="ICD-10-PCS Procedure 21"

  I10_PR22                   LENGTH=$7
  LABEL="ICD-10-PCS Procedure 22"

  I10_PR23                   LENGTH=$7
  LABEL="ICD-10-PCS Procedure 23"

  I10_PR24                   LENGTH=$7
  LABEL="ICD-10-PCS Procedure 24"

  I10_PR25                   LENGTH=$7
  LABEL="ICD-10-PCS Procedure 25"

  I10_SERVICELINE            LENGTH=3
  LABEL="ICD-10-CM/PCS Hospital Service Line"

  KEY_NIS                    LENGTH=5            FORMAT=8.
  LABEL="NIS record number"

  LOS                        LENGTH=4
  LABEL="Length of stay (cleaned)"

  MDC                        LENGTH=3
  LABEL="MDC in effect on discharge date"

  MDC_NoPOA                  LENGTH=3
  LABEL="MDC in use on discharge date, calculated without POA"

  NIS_STRATUM                LENGTH=4            FORMAT=4.
  LABEL="NIS hospital stratum"

  PAY1                       LENGTH=3
  LABEL="Primary expected payer (uniform)"

  PCLASS_ORPROC              LENGTH=3
  LABEL="Indicates operating room (major diagnostic or therapeutic) procedure on the record"

  PL_NCHS                    LENGTH=3
  LABEL="Patient Location: NCHS Urban-Rural Code"

  PRDAY1                     LENGTH=4
  LABEL="Number of days from admission to I10_PR1"

  PRDAY2                     LENGTH=4
  LABEL="Number of days from admission to I10_PR2"

  PRDAY3                     LENGTH=4
  LABEL="Number of days from admission to I10_PR3"

  PRDAY4                     LENGTH=4
  LABEL="Number of days from admission to I10_PR4"

  PRDAY5                     LENGTH=4
  LABEL="Number of days from admission to I10_PR5"

  PRDAY6                     LENGTH=4
  LABEL="Number of days from admission to I10_PR6"

  PRDAY7                     LENGTH=4
  LABEL="Number of days from admission to I10_PR7"

  PRDAY8                     LENGTH=4
  LABEL="Number of days from admission to I10_PR8"

  PRDAY9                     LENGTH=4
  LABEL="Number of days from admission to I10_PR9"

  PRDAY10                    LENGTH=4
  LABEL="Number of days from admission to I10_PR10"

  PRDAY11                    LENGTH=4
  LABEL="Number of days from admission to I10_PR11"

  PRDAY12                    LENGTH=4
  LABEL="Number of days from admission to I10_PR12"

  PRDAY13                    LENGTH=4
  LABEL="Number of days from admission to I10_PR13"

  PRDAY14                    LENGTH=4
  LABEL="Number of days from admission to I10_PR14"

  PRDAY15                    LENGTH=4
  LABEL="Number of days from admission to I10_PR15"

  PRDAY16                    LENGTH=4
  LABEL="Number of days from admission to I10_PR16"

  PRDAY17                    LENGTH=4
  LABEL="Number of days from admission to I10_PR17"

  PRDAY18                    LENGTH=4
  LABEL="Number of days from admission to I10_PR18"

  PRDAY19                    LENGTH=4
  LABEL="Number of days from admission to I10_PR19"

  PRDAY20                    LENGTH=4
  LABEL="Number of days from admission to I10_PR20"

  PRDAY21                    LENGTH=4
  LABEL="Number of days from admission to I10_PR21"

  PRDAY22                    LENGTH=4
  LABEL="Number of days from admission to I10_PR22"

  PRDAY23                    LENGTH=4
  LABEL="Number of days from admission to I10_PR23"

  PRDAY24                    LENGTH=4
  LABEL="Number of days from admission to I10_PR24"

  PRDAY25                    LENGTH=4
  LABEL="Number of days from admission to I10_PR25"

  RACE                       LENGTH=3
  LABEL="Race (uniform)"

  TOTCHG                     LENGTH=6
  LABEL="Total charges (cleaned)"

  TRAN_IN                    LENGTH=3
  LABEL="Transfer in indicator"

  TRAN_OUT                   LENGTH=3
  LABEL="Transfer out indicator"

  YEAR                       LENGTH=3
  LABEL="Calendar year"

  ZIPINC_QRTL                LENGTH=3
  LABEL="Median household income national quartile for patient ZIP Code"
  ;

*** Read data elements from the ASCII file ***;
INPUT 
      @1      AGE                      N3PF.
      @4      AGE_NEONATE              N2PF.
      @6      AMONTH                   N2PF.
      @8      AWEEKEND                 N2PF.
      @10     DIED                     N2PF.
      @12     DISCWT                   N11P7F.
      @23     DISPUNIFORM              N2PF.
      @25     DQTR                     N2PF.
      @27     DRG                      N3PF.
      @30     DRGVER                   N2PF.
      @32     DRG_NoPOA                N3PF.
      @35     ELECTIVE                 N2PF.
      @37     FEMALE                   N2PF.
      @39     HCUP_ED                  N3PF.
      @42     HOSP_DIVISION            N2PF.
      @44     HOSP_NIS                 N5PF.
      @49     I10_BIRTH                N3PF.
      @52     I10_DELIVERY             N3PF.
      @55     I10_DX1                  $CHAR7.
      @62     I10_DX2                  $CHAR7.
      @69     I10_DX3                  $CHAR7.
      @76     I10_DX4                  $CHAR7.
      @83     I10_DX5                  $CHAR7.
      @90     I10_DX6                  $CHAR7.
      @97     I10_DX7                  $CHAR7.
      @104    I10_DX8                  $CHAR7.
      @111    I10_DX9                  $CHAR7.
      @118    I10_DX10                 $CHAR7.
      @125    I10_DX11                 $CHAR7.
      @132    I10_DX12                 $CHAR7.
      @139    I10_DX13                 $CHAR7.
      @146    I10_DX14                 $CHAR7.
      @153    I10_DX15                 $CHAR7.
      @160    I10_DX16                 $CHAR7.
      @167    I10_DX17                 $CHAR7.
      @174    I10_DX18                 $CHAR7.
      @181    I10_DX19                 $CHAR7.
      @188    I10_DX20                 $CHAR7.
      @195    I10_DX21                 $CHAR7.
      @202    I10_DX22                 $CHAR7.
      @209    I10_DX23                 $CHAR7.
      @216    I10_DX24                 $CHAR7.
      @223    I10_DX25                 $CHAR7.
      @230    I10_DX26                 $CHAR7.
      @237    I10_DX27                 $CHAR7.
      @244    I10_DX28                 $CHAR7.
      @251    I10_DX29                 $CHAR7.
      @258    I10_DX30                 $CHAR7.
      @265    I10_DX31                 $CHAR7.
      @272    I10_DX32                 $CHAR7.
      @279    I10_DX33                 $CHAR7.
      @286    I10_DX34                 $CHAR7.
      @293    I10_DX35                 $CHAR7.
      @300    I10_DX36                 $CHAR7.
      @307    I10_DX37                 $CHAR7.
      @314    I10_DX38                 $CHAR7.
      @321    I10_DX39                 $CHAR7.
      @328    I10_DX40                 $CHAR7.
      @335    I10_INJURY               N2PF.
      @337    I10_MULTINJURY           N2PF.
      @339    I10_NDX                  N2PF.
      @341    I10_NPR                  N2PF.
      @343    I10_PR1                  $CHAR7.
      @350    I10_PR2                  $CHAR7.
      @357    I10_PR3                  $CHAR7.
      @364    I10_PR4                  $CHAR7.
      @371    I10_PR5                  $CHAR7.
      @378    I10_PR6                  $CHAR7.
      @385    I10_PR7                  $CHAR7.
      @392    I10_PR8                  $CHAR7.
      @399    I10_PR9                  $CHAR7.
      @406    I10_PR10                 $CHAR7.
      @413    I10_PR11                 $CHAR7.
      @420    I10_PR12                 $CHAR7.
      @427    I10_PR13                 $CHAR7.
      @434    I10_PR14                 $CHAR7.
      @441    I10_PR15                 $CHAR7.
      @448    I10_PR16                 $CHAR7.
      @455    I10_PR17                 $CHAR7.
      @462    I10_PR18                 $CHAR7.
      @469    I10_PR19                 $CHAR7.
      @476    I10_PR20                 $CHAR7.
      @483    I10_PR21                 $CHAR7.
      @490    I10_PR22                 $CHAR7.
      @497    I10_PR23                 $CHAR7.
      @504    I10_PR24                 $CHAR7.
      @511    I10_PR25                 $CHAR7.
      @518    I10_SERVICELINE          N3PF.
      @521    KEY_NIS                  N10PF.
      @531    LOS                      N5PF.
      @536    MDC                      N2PF.
      @538    MDC_NoPOA                N2PF.
      @540    NIS_STRATUM              N4PF.
      @544    PAY1                     N2PF.
      @546    PCLASS_ORPROC            N2PF.
      @548    PL_NCHS                  N3PF.
      @551    PRDAY1                   N3PF.
      @554    PRDAY2                   N3PF.
      @557    PRDAY3                   N3PF.
      @560    PRDAY4                   N3PF.
      @563    PRDAY5                   N3PF.
      @566    PRDAY6                   N3PF.
      @569    PRDAY7                   N3PF.
      @572    PRDAY8                   N3PF.
      @575    PRDAY9                   N3PF.
      @578    PRDAY10                  N3PF.
      @581    PRDAY11                  N3PF.
      @584    PRDAY12                  N3PF.
      @587    PRDAY13                  N3PF.
      @590    PRDAY14                  N3PF.
      @593    PRDAY15                  N3PF.
      @596    PRDAY16                  N3PF.
      @599    PRDAY17                  N3PF.
      @602    PRDAY18                  N3PF.
      @605    PRDAY19                  N3PF.
      @608    PRDAY20                  N3PF.
      @611    PRDAY21                  N3PF.
      @614    PRDAY22                  N3PF.
      @617    PRDAY23                  N3PF.
      @620    PRDAY24                  N3PF.
      @623    PRDAY25                  N3PF.
      @626    RACE                     N2PF.
      @628    TOTCHG                   N10PF.
      @638    TRAN_IN                  N2PF.
      @640    TRAN_OUT                 N2PF.
      @642    YEAR                     N4PF.
      @646    ZIPINC_QRTL              N2PF.
      ;
RUN;

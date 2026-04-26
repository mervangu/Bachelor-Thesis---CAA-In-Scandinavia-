# extractdomains.sh

A Bash script for extracting Scandinavian and global domain lists from a Tranco CSV file. It separates Norwegian, Swedish, and Danish domains by TLD and builds a filtered global reference list excluding all Scandinavian domains.

## Pipeline

This script is the first step in a three-script pipeline:

```
extractdomains.sh  →  extractCAA.sh  →  CAAanalysis.sh
```

1. `extractdomains.sh` extracts domain lists from a Tranco CSV file
2. `extractCAA.sh` scans those domains for CAA records using ZDNS
3. `CAAanalysis.sh` analyses the ZDNS output and generates reports

## Usage

```bash
./extractdomains.sh <tranco_file>
```

**Example:**

```bash
./extractdomains.sh tranco_list.csv
```

## Input

The script expects a Tranco CSV file with the following format:
rank,domain
1,google.com
2,youtube.com

The header row is automatically skipped. The file must have at least two comma-separated columns where column 2 contains the domain name. Tranco lists can be downloaded from [tranco-list.eu](https://tranco-list.eu).

## Output

The script produces four CSV files in the current working directory:

| File | Description |
|---|---|
| `all_no.csv` | All Norwegian domains (`.no`) found in the input file |
| `all_se.csv` | All Swedish domains (`.se`) found in the input file |
| `all_dk.csv` | All Danish domains (`.dk`) found in the input file |
| `globally.csv` | Top 100,000 non-Scandinavian domains by Tranco rank |

All output files contain one domain per line with no header row. Duplicates are removed automatically. The global list preserves Tranco ranking order and stops at exactly 100,000 domains.

## Example Output

Extracting domains...
Extracting all .no domains...
Extracting all .se domains...
Extracting all .dk domains...
Building top 100,000 global domains (excluding Scandinavian)...
Results:
Scandinavian domains:
Norwegian (.no): 6326
Swedish (.se): 11415
Danish (.dk): 11711
Global domains:
Top 100k (excluding Scandinavian): 100000
Files created:

all_no.csv (all Norwegian domains)
all_se.csv (all Swedish domains)
all_dk.csv (all Danish domains)
globally.csv (top 100k global, excluding Scandinavian)

## Notes

- The script exits immediately if any command fails (`set -euo pipefail`)
- If the input file does not exist, the script exits with an error message
- The global list respects Tranco ranking order — lower-ranked domains are excluded if the 100,000 limit is reached before the end of the file
- Windows line endings (`\r\n`) are handled automatically

# CAAanalysis.sh

A Bash script for analysing ZDNS CAA scan output. It processes the JSON results produced by `extractCAA.sh` and generates a detailed breakdown of tag usage, CA distribution, configuration errors, and multi-CA authorisation across a set of domains.

## Pipeline

This script is the third step in a three-script pipeline:

```
extractdomains.sh  →  extractCAA.sh  →  CAAanalysis.sh
```

1. `extractdomains.sh` extracts domain lists from a Tranco CSV file
2. `extractCAA.sh` scans those domains for CAA records using ZDNS
3. `CAAanalysis.sh` analyses the ZDNS output and generates reports

## Requirements

- Bash 4.0 or later
- [jq](https://stedolan.github.io/jq/) installed and available in your PATH
- A ZDNS CAA JSON output file (produced by `extractCAA.sh`)

## Usage

```bash
./CAAanalysis.sh <caa_data.json> <output_prefix>
```

| Argument | Required | Description |
|---|---|---|
| `caa_data.json` | Yes | Path to the ZDNS JSON output file containing CAA scan results |
| `output_prefix` | Yes | Prefix used for all output filenames (e.g. `NORWAY`, `SWEDEN`) |

**Example:**

```bash
./CAAanalysis.sh norway_with_caa.json NORWAY
```

## Input

A ZDNS JSON output file where each line represents one domain and its CAA query result. This is the `_with_caa.json` file produced by `extractCAA.sh`.

## Output

The script produces five output files using the specified prefix:

| File | Description |
|---|---|
| `<prefix>_caa_analysis.txt` | Full analysis report including tag usage, CA distribution, and configuration issues |
| `<prefix>_caa_summary.csv` | Per-domain CSV summary with CAA status, tag counts, and CA list |
| `<prefix>_multiple_cas.txt` | Domains that authorise more than one Certificate Authority |
| `<prefix>_issue_and_issuewild.txt` | Domains that publish both `issue` and `issuewild` tags |
| `<prefix>_all_three_tags.txt` | Domains that publish all three tags: `issue`, `issuewild`, and `iodef` |

## Example Output

```
CAA DNS RECORD ANALYSIS
Analysis date: 1 November 2025
Input file: norway_with_caa.json
Total domains analyzed: 907

TAG USAGE:
  Domains with 'issue':         889 (98.01%)
  Domains with 'issuewild':     240 (26.46%)
  Domains with 'iodef':         159 (17.53%)

TAG COMBINATIONS:
  Domains with 'issue' AND 'issuewild': 240 (26.46%)
  Domains with all three tags (issue, issuewild, iodef): 88 (9.70%)

POTENTIAL ISSUES:
Unknown or misspelled tags:
  - contactemail
  - issuemail

MOST USED CERTIFICATE AUTHORITIES:
  letsencrypt.org: 903
  digicert.com: 309
  pki.goog: 222
  comodoca.com: 172
  globalsign.com: 153
  ssl.com: 152
  sectigo.com: 145
  buypass.no: 122
  amazon.com: 58
  harica.gr: 39

DOMAINS WITH MULTIPLE CAs: 316 (34.84%)

Results saved to:
  - NORWAY_caa_analysis.txt (detailed analysis)
  - NORWAY_caa_summary.csv (CSV summary)
  - NORWAY_multiple_cas.txt (domains with multiple CAs)
  - NORWAY_issue_and_issuewild.txt (domains with issue + issuewild)
  - NORWAY_all_three_tags.txt (domains with all three tags)
```

## Notes

- CA values are deduplicated per domain before counting multi-CA authorisation
- Parameters appended to CA values (e.g. `cansignhttpexchanges=yes`) are stripped before grouping, so `digicert.com` and `digicert.com; cansignhttpexchanges=yes` are counted as the same CA
- Unknown or misspelled tags are detected automatically by checking for any tag value other than `issue`, `issuewild`, and `iodef`
- The top 15 most used CAs are shown in the analysis report

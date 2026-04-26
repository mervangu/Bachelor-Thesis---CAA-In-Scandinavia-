# extractCAA.sh

A Bash script for scanning a list of domains for CAA DNS records using ZDNS. It separates domains with valid CAA records from those that returned no response or an error, and outputs both full JSON results and filtered CSV lists.

## Requirements

- Bash 4.0 or later
- [ZDNS](https://github.com/zmap/zdns) installed and available in your PATH
- [jq](https://stedolan.github.io/jq/) installed and available in your PATH

## Usage

```bash
./extractCAA.sh <input_file> [prefix]
```

| Argument | Required | Description |
|---|---|---|
| `input_file` | Yes | Path to a plain text file with one domain per line |
| `prefix` | No | Output filename prefix. Defaults to `output` if not provided |

**Example:**

```bash
./extractCAA.sh all_no.csv norway
```

## Input

A plain text file with one domain per line and no header row:

```
google.com
youtube.com
github.com
```

This is the format produced by `extractdomains.sh`.

## Output

The script produces three files using the specified prefix:

| File | Description |
|---|---|
| `<prefix>_with_caa.json` | Full ZDNS JSON output for domains that returned at least one CAA record |
| `<prefix>_with_caa.csv` | Plain list of domain names that have CAA records |
| `<prefix>_no_response.csv` | Plain list of domains that failed, timed out, or returned an error |

## Example Output

```
Scanning 6326 domains...
Processing results...

Summary:
  Total scanned:    6326
  With CAA:         907 (14.34%)
  No response:      312

Files created:
  norway_with_caa.json   -> full JSON for domains with CAA
  norway_with_caa.csv    -> CSV list of domains with CAA
  norway_no_response.csv -> CSV list of domains that failed or timed out
```

## Notes

- Domains returning a DNS status other than `NOERROR` are written to the no-response file, including timeouts, NXDOMAIN, and SERVFAIL responses
- If no prefix is provided, all output files will begin with `output_`

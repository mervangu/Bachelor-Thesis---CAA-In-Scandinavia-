#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <input_file> [prefix]"
    exit 1
fi

INPUT_FILE="$1"
PREFIX="${2:-output}"

if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: File '$INPUT_FILE' not found!"
    exit 1
fi

TEMP_JSON="${PREFIX}_temp.json"
WITH_CAA_JSON="${PREFIX}_with_caa.json"
WITH_CAA_CSV="${PREFIX}_with_caa.csv"
NO_RESPONSE_CSV="${PREFIX}_no_response.csv"

total=$(wc -l < "$INPUT_FILE")
echo "Scanning $total domains..."

zdns CAA --input-file "$INPUT_FILE" --output-file "$TEMP_JSON" --threads 10

echo "Processing results..."

# Extract JSON objects for domains with valid CAA answers
jq 'select(.results.CAA.data.answers != null)' "$TEMP_JSON" > "$WITH_CAA_JSON"

# Extract only domain names for domains WITH CAA (CSV format)
jq -r 'select(.results.CAA.data.answers != null) | .name' "$TEMP_JSON" > "$WITH_CAA_CSV"

# Extract only domain names for non-responsive or error domains
jq -r 'select(.results.CAA.status != "NOERROR") | .name' "$TEMP_JSON" > "$NO_RESPONSE_CSV"

# Clean up temporary file
rm "$TEMP_JSON"

with_caa=$(wc -l < "$WITH_CAA_CSV")
no_response=$(wc -l < "$NO_RESPONSE_CSV")
percentage=$(echo "scale=2; $with_caa * 100 / $total" | bc)

echo "Summary:"
echo "  Total scanned:    $total"
echo "  With CAA:         $with_caa ($percentage%)"
echo "  No response:      $no_response"
echo ""
echo "Files created:"
echo "  $WITH_CAA_JSON   -> full JSON for domains with CAA"
echo "  $WITH_CAA_CSV    -> CSV list of domains with CAA"
echo "  $NO_RESPONSE_CSV -> CSV list of domains that failed or timed out"

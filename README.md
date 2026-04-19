# CAA DNS Record Analysis - Bachelor Thesis Dataset

This repository contains datasets and analysis scripts for the bachelor thesis **"CAA DNS Record Adoption and Configuration Quality Across Scandinavian Domains"** by Mervan Gurbuz at Noroff University College.

## Overview

This research examines the adoption and configuration of DNS Certification Authority Authorization (CAA) records across Norwegian, Swedish, and Danish domains from November 2025 to April 2026.

## Repository Structure

```
├── Dataset 1 - November/          # Monthly Tranco Top 1M Scandinavian domains (Nov 2025)
├── Dataset 1.1 - December/        # Monthly scan (Dec 2025)
├── Dataset 1.2 - January/         # Monthly scan (Jan 2026)
├── Dataset 1.3 - February/        # Monthly scan (Feb 2026)
├── Dataset 1.4 - March/           # Monthly scan (Mar 2026)
├── Dataset 1.5 - April/           # Monthly scan (Apr 2026)
├── Dataset 2 - November/          # Frozen domain lists by sector (Nov 2025)
├── Dataset 2.1 - April/           # Frozen domain lists re-scan (Apr 2026)
├── Dataset 3/                     # Sector-based dataset
└── Scripts/                       # Analysis scripts
```

## Datasets

### Dataset 1: Monthly Tranco Top 1M Scans
Monthly snapshots of Scandinavian domains (.no, .se, .dk) from the Tranco Top 1M list, filtered for domains with CAA records.

- **Time period**: November 2025 - April 2026
- **Source**: Tranco Top 1M ranking list and Tranco Full list
- **Scan tool**: ZDNS and dig 

### Dataset 2: Frozen Sector-Specific Domains
Manually curated domain lists across five critical sectors, scanned in November 2025 and re-scanned in April 2026 to track configuration changes.

**Sectors**:
- Banking and financial institutions
- Public services and government
- News and media organizations
- Universities and educational institutions
- Telecommunications providers

**Countries**: Norway, Sweden, Denmark

### Dataset 3: Global Reference Dataset
Global Top 10K and Top 100K domains with CAA records, used as baseline for comparative analysis.

## Scripts

### `CAAanalysis.sh`
Primary analysis script for processing ZDNS JSON output.

**Usage**:
```bash
./CAAanalysis.sh <input_file.json> <output_prefix>
```

**Example**:
```bash
./CAAanalysis.sh NORWAY_with_caa.json NORWAY_APR
```

**Features**:
- Tag usage statistics (issue, issuewild, iodef)
- Tag combination analysis
- Certificate Authority rankings with parameter normalization
- Configuration error detection (misspelled tags)
- Multi-CA authorization analysis

**Output files**:
- `[PREFIX]_caa_analysis.txt` - Detailed statistical report
- `[PREFIX]_caa_summary.csv` - Per-domain CSV data
- `[PREFIX]_multiple_cas.txt` - Domains authorizing multiple CAs
- `[PREFIX]_issue_and_issuewild.txt` - Domains using both issue and issuewild tags
- `[PREFIX]_all_three_tags.txt` - Domains implementing all three CAA tags

## Key Findings

- **Let's Encrypt dominance**: 93-127% share across all datasets (>100% due to multi-tag usage)
- **iodef adoption**: 29-42% in Scandinavian datasets vs. 2-7% globally (5-6x higher)
- **Multi-CA authorization**: 64-70% of domains authorize multiple Certificate Authorities
- **Regional CAs**: Buypass (Norway), Telia (Sweden), HARICA (universities), Commfides (Norwegian public sector)

## Research Context

This work builds on prior CAA adoption studies:
- Ruohonen (2019) - Alexa Top 1M analysis
- Izhikevich et al. (2022) - ZDNS global scan
- Fotouhi Tehrani et al. (2024) - Tranco Top 4M analysis

## License

Research data collected for academic purposes. Scripts are provided for reproducibility.

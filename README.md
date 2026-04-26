# CAA DNS Record Analysis - Bachelor Thesis Dataset

This repository contains datasets and analysis scripts for the bachelor thesis **"CAA DNS Record Adoption and Configuration Quality Across Scandinavian Domains"** by Mervan Güler at Noroff University College.

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
Monthly snapshots of Scandinavian domains (.no, .se, .dk) along with Global Top 10K excluding Scandinavian domains from the Tranco Top 1M list.

- **Time period**: November 2025 - April 2026
- **Source**: Tranco Top 1M ranking list 

### Dataset 2: Frozen Domains
Top 100k domains from the the Tranco Full list, all domains from Norway, all domains from Sweden and all domains from Denmark. 

- **Time period**: Scanned in November 2025 and re-scanned in April 2026 to track configuration changes.
- **Source**: Tranco Full list

### Dataset 3: Sector-based 

Manually curated domain lists across five critical sectors in Norway, Sweden and Denmark: 

**Sectors**:
- Banking and financial institutions
- Public services and government
- News and media organizations
- Universities and educational institutions
- Telecommunications providers

- **Time period**: November 2025 - April 2026

## Scripts

### `extractdomains.sh`
Get all the domains from Norway, Sweden and Denmark, also get 100k excluding Scandinavian domains. 

### `extractCAA.sh`
Extract domains that publish CAA using ZDNS. 

### `CAAanalysis.sh`
Primary analysis script for processing JSON output.


## Key Findings

- **Let's Encrypt dominance**: 93-127% share across all datasets (>100% due to multi-tag usage)
- **iodef adoption**: 29-42% in Scandinavian datasets vs. 2-7% globally (5-6x higher)
- **Multi-CA authorization**: 64-70% of domains authorize multiple Certificate Authorities
- **Regional CAs**: Buypass (Norway), Telia (Sweden), HARICA (universities), Commfides (Norwegian public sector)

## License

Research data collected for academic purposes. Scripts are provided for reproducibility.

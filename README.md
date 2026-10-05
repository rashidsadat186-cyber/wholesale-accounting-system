# Enterprise Accounting + Inventory System

This project implements an enterprise-style accounting and inventory system for PostgreSQL based on a Khatabook-style dataset.

## Overview

The schema follows a double-entry accounting model:
- Accounts
- Parties (customers/suppliers)
- Journal entries / journal lines
- Inventory movements
- Audit logging

## Files

- `01_schema_enterprise.sql` – database schema
- `02_seed_enterprise.sql` – seed data based on the supplied sample JSON
- `03_views_reports.sql` – reporting views
- `run_enterprise.sh` – execution script

## Prerequisites

- PostgreSQL 14/16 installed
- `psql` available in PATH

## Run

```bash
chmod +x run_enterprise.sh
./run_enterprise.sh wholesale_enterprise
```

## Useful queries

```sql
SELECT * FROM v_party_summary;
SELECT * FROM v_account_balances;
SELECT * FROM v_inventory_status;
```

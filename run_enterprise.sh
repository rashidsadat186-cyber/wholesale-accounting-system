#!/usr/bin/env bash
set -euo pipefail

DB="${1:-wholesale_enterprise}"
cd "$(dirname "$0")"

FILES="
01_schema_enterprise.sql
02_seed_enterprise.sql
03_views_reports.sql
"

for f in $FILES; do
  echo ">> $f"
  psql -v ON_ERROR_STOP=1 -q -d "$DB" -f "$f"
done

echo "Database is ready."
echo "Examples:"
echo "  psql -d $DB -c \"SELECT * FROM v_party_summary;\""
echo "  psql -d $DB -c \"SELECT * FROM v_inventory_status;\""

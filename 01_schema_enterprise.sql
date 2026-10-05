-- 01_schema_enterprise.sql
-- Enterprise accounting + inventory schema

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE organizations (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    code TEXT UNIQUE,
    base_currency CHAR(3) NOT NULL DEFAULT 'AFN',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE currencies (
    code CHAR(3) PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    org_id INTEGER NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    code TEXT NOT NULL,
    name TEXT NOT NULL,
    parent_id INTEGER REFERENCES accounts(id),
    account_type TEXT NOT NULL CHECK (
        account_type IN ('ASSET','LIABILITY','EQUITY','REVENUE','EXPENSE')
    ),
    normal_balance TEXT NOT NULL CHECK (normal_balance IN ('DEBIT','CREDIT')),
    currency CHAR(3) NOT NULL DEFAULT 'AFN',
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    UNIQUE (org_id, code)
);

CREATE TABLE parties (
    id SERIAL PRIMARY KEY,
    org_id INTEGER NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    party_type TEXT NOT NULL CHECK (
        party_type IN ('customer','supplier','employee','bank','other')
    ),
    phone TEXT,
    address TEXT,
    khata_number TEXT,
    is_active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE items (
    id SERIAL PRIMARY KEY,
    org_id INTEGER NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    unit TEXT,
    stock_qty NUMERIC(18,3) NOT NULL DEFAULT 0,
    buy_price NUMERIC(18,2) NOT NULL DEFAULT 0,
    buy_currency CHAR(3) NOT NULL DEFAULT 'AFN',
    sell_price NUMERIC(18,2) NOT NULL DEFAULT 0,
    sell_currency CHAR(3) NOT NULL DEFAULT 'AFN',
    is_active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE journal_entries (
    id SERIAL PRIMARY KEY,
    org_id INTEGER NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    entry_no TEXT NOT NULL,
    entry_date DATE NOT NULL,
    description TEXT,
    reference_no TEXT,
    source_type TEXT NOT NULL DEFAULT 'manual',
    source_id INTEGER,
    status TEXT NOT NULL DEFAULT 'posted' CHECK (status IN ('draft','posted','reversed')),
    created_by TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (org_id, entry_no)
);

CREATE TABLE journal_lines (
    id SERIAL PRIMARY KEY,
    org_id INTEGER NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    journal_id INTEGER NOT NULL REFERENCES journal_entries(id) ON DELETE CASCADE,
    account_id INTEGER NOT NULL REFERENCES accounts(id),
    party_id INTEGER REFERENCES parties(id),
    item_id INTEGER REFERENCES items(id),
    description TEXT,
    debit NUMERIC(18,2) NOT NULL DEFAULT 0,
    credit NUMERIC(18,2) NOT NULL DEFAULT 0,
    currency CHAR(3) NOT NULL DEFAULT 'AFN',
    exchange_rate NUMERIC(18,6) NOT NULL DEFAULT 1,
    amount_base NUMERIC(18,2) NOT NULL DEFAULT 0
);

CREATE TABLE inventory_movements (
    id SERIAL PRIMARY KEY,
    org_id INTEGER NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    item_id INTEGER NOT NULL REFERENCES items(id),
    movement_type TEXT NOT NULL CHECK (movement_type IN ('IN','OUT','ADJUSTMENT','OPENING')),
    qty NUMERIC(18,3) NOT NULL,
    unit_price NUMERIC(18,2) NOT NULL DEFAULT 0,
    currency CHAR(3) NOT NULL DEFAULT 'AFN',
    journal_id INTEGER REFERENCES journal_entries(id),
    notes TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE audit_log (
    id SERIAL PRIMARY KEY,
    org_id INTEGER NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    table_name TEXT NOT NULL,
    record_id INTEGER,
    action TEXT NOT NULL CHECK (action IN ('INSERT','UPDATE','DELETE')),
    changes JSONB,
    actor TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_accounts_org_code ON accounts(org_id, code);
CREATE INDEX idx_parties_org_name ON parties(org_id, name);
CREATE INDEX idx_items_org_name ON items(org_id, name);
CREATE INDEX idx_journal_entries_org_date ON journal_entries(org_id, entry_date);
CREATE INDEX idx_journal_lines_journal ON journal_lines(journal_id);
CREATE INDEX idx_journal_lines_account ON journal_lines(account_id);
CREATE INDEX idx_inventory_movements_item ON inventory_movements(item_id);
CREATE INDEX idx_audit_log_org ON audit_log(org_id, created_at DESC);

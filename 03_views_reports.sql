-- 03_views_reports.sql
-- Reporting views

CREATE VIEW v_party_summary AS
SELECT
    p.id,
    p.name,
    p.party_type,
    p.phone,
    p.khata_number,
    p.address,
    COALESCE(SUM(CASE WHEN jl.currency='AFN' THEN jl.debit ELSE 0 END),0) AS afn_debit,
    COALESCE(SUM(CASE WHEN jl.currency='AFN' THEN jl.credit ELSE 0 END),0) AS afn_credit,
    COALESCE(SUM(CASE WHEN jl.currency='AFN' THEN jl.debit ELSE 0 END),0)
    - COALESCE(SUM(CASE WHEN jl.currency='AFN' THEN jl.credit ELSE 0 END),0) AS afn_balance
FROM parties p
LEFT JOIN journal_lines jl ON jl.party_id = p.id
GROUP BY p.id, p.name, p.party_type, p.phone, p.khata_number, p.address
ORDER BY p.id;

CREATE VIEW v_account_balances AS
SELECT
    a.id AS account_id,
    a.code,
    a.name,
    a.account_type,
    a.normal_balance,
    COALESCE(SUM(CASE WHEN jl.currency=a.currency THEN jl.debit ELSE 0 END),0) AS total_debit,
    COALESCE(SUM(CASE WHEN jl.currency=a.currency THEN jl.credit ELSE 0 END),0) AS total_credit,
    COALESCE(SUM(CASE WHEN jl.currency=a.currency THEN jl.debit ELSE 0 END),0)
    - COALESCE(SUM(CASE WHEN jl.currency=a.currency THEN jl.credit ELSE 0 END),0) AS balance
FROM accounts a
LEFT JOIN journal_lines jl ON jl.account_id = a.id
GROUP BY a.id, a.code, a.name, a.account_type, a.normal_balance, a.currency
ORDER BY a.code;

CREATE VIEW v_inventory_status AS
SELECT
    i.id,
    i.name,
    i.unit,
    i.stock_qty,
    i.buy_price,
    i.buy_currency,
    i.sell_price,
    i.sell_currency,
    i.stock_qty * i.sell_price AS inventory_value
FROM items i
WHERE i.is_active = TRUE
ORDER BY i.name;

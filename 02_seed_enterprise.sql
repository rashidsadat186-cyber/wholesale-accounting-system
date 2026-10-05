-- 02_seed_enterprise.sql
-- Seed data based on sample_khatabook.json

INSERT INTO currencies (code, name) VALUES
('AFN', 'Afghani'),
('USD', 'US Dollar');

INSERT INTO organizations (id, name, code, base_currency) VALUES
(1, 'Wholesale Enterprise', 'WHL-001', 'AFN');

INSERT INTO accounts (org_id, code, name, parent_id, account_type, normal_balance, currency) VALUES
-- Assets
(1, '1000', 'Assets', NULL, 'ASSET', 'DEBIT', 'AFN'),
(1, '1010', 'Cash', 1, 'ASSET', 'DEBIT', 'AFN'),
(1, '1020', 'Accounts Receivable', 1, 'ASSET', 'DEBIT', 'AFN'),
(1, '1030', 'Inventory', 1, 'ASSET', 'DEBIT', 'AFN'),
(1, '1040', 'Office Equipment', 1, 'ASSET', 'DEBIT', 'AFN'),

-- Liabilities
(1, '2000', 'Liabilities', NULL, 'LIABILITY', 'CREDIT', 'AFN'),
(1, '2010', 'Accounts Payable', 6, 'LIABILITY', 'CREDIT', 'AFN'),
(1, '2020', 'Loan Payable', 6, 'LIABILITY', 'CREDIT', 'AFN'),

-- Equity
(1, '3000', 'Equity', NULL, 'EQUITY', 'CREDIT', 'AFN'),
(1, '3010', 'Owner Capital', 9, 'EQUITY', 'CREDIT', 'AFN'),
(1, '3020', 'Retained Earnings', 9, 'EQUITY', 'CREDIT', 'AFN'),

-- Revenue
(1, '4000', 'Revenue', NULL, 'REVENUE', 'CREDIT', 'AFN'),
(1, '4010', 'Sales Revenue', 12, 'REVENUE', 'CREDIT', 'AFN'),
(1, '4020', 'Other Income', 12, 'REVENUE', 'CREDIT', 'AFN'),

-- Expenses
(1, '5000', 'Expenses', NULL, 'EXPENSE', 'DEBIT', 'AFN'),
(1, '5010', 'Purchases', 15, 'EXPENSE', 'DEBIT', 'AFN'),
(1, '5020', 'Cost of Goods Sold', 15, 'EXPENSE', 'DEBIT', 'AFN'),
(1, '5030', 'Operating Expense', 15, 'EXPENSE', 'DEBIT', 'AFN');

INSERT INTO parties (org_id, name, party_type, phone, address, khata_number) VALUES
(1, 'حاجی کریم', 'customer', '0700123456', 'سرای شهزاده، کابل', '5'),
(1, 'شرکت تجارتی نور', 'supplier', '0799000111', NULL, NULL);

INSERT INTO items (org_id, name, unit, stock_qty, buy_price, buy_currency, sell_price, sell_currency) VALUES
(1, 'برنج سیلا', 'بوجی', 120, 3000, 'AFN', 3400, 'AFN'),
(1, 'شکر', 'بوجی', 80, 50, 'USD', 4200, 'AFN');

INSERT INTO journal_entries (org_id, entry_no, entry_date, description, reference_no, source_type)
VALUES
(1, 'JE-001', '2026-10-01', 'فروش برنج به حاجی کریم', 'INV-001', 'sale'),
(1, 'JE-002', '2026-10-02', 'دریافت نقد از حاجی کریم', 'RCV-001', 'receipt'),
(1, 'JE-003', '2026-10-03', 'خرید شکر از شرکت تجارتی نور', 'PO-001', 'purchase'),
(1, 'JE-004', '2026-10-04', 'پرداخت به شرکت تجارتی نور', 'PAY-001', 'payment');

INSERT INTO journal_lines (org_id, journal_id, account_id, party_id, item_id, description, debit, credit, currency, exchange_rate, amount_base)
VALUES
(
  1,
  (SELECT id FROM journal_entries WHERE entry_no='JE-001'),
  (SELECT id FROM accounts WHERE org_id=1 AND code='1020'),
  (SELECT id FROM parties WHERE name='حاجی کریم'),
  NULL,
  'حساب مطالبات از مشتری',
  150000,
  0,
  'AFN',
  1,
  150000
),
(
  1,
  (SELECT id FROM journal_entries WHERE entry_no='JE-001'),
  (SELECT id FROM accounts WHERE org_id=1 AND code='4010'),
  (SELECT id FROM parties WHERE name='حاجی کریم'),
  NULL,
  'فروش برنج',
  0,
  150000,
  'AFN',
  1,
  150000
),
(
  1,
  (SELECT id FROM journal_entries WHERE entry_no='JE-002'),
  (SELECT id FROM accounts WHERE org_id=1 AND code='1010'),
  (SELECT id FROM parties WHERE name='حاجی کریم'),
  NULL,
  'دریافت نقد',
  50000,
  0,
  'AFN',
  1,
  50000
),
(
  1,
  (SELECT id FROM journal_entries WHERE entry_no='JE-002'),
  (SELECT id FROM accounts WHERE org_id=1 AND code='1020'),
  (SELECT id FROM parties WHERE name='حاجی کریم'),
  NULL,
  'کاهش مطالبات',
  0,
  50000,
  'AFN',
  1,
  50000
),
(
  1,
  (SELECT id FROM journal_entries WHERE entry_no='JE-003'),
  (SELECT id FROM accounts WHERE org_id=1 AND code='1030'),
  (SELECT id FROM parties WHERE name='شرکت تجارتی نور'),
  (SELECT id FROM items WHERE name='شکر'),
  'خرید شکر',
  400000,
  0,
  'AFN',
  1,
  400000
),
(
  1,
  (SELECT id FROM journal_entries WHERE entry_no='JE-003'),
  (SELECT id FROM accounts WHERE org_id=1 AND code='2010'),
  (SELECT id FROM parties WHERE name='شرکت تجارتی نور'),
  NULL,
  'حساب پرداختنی',
  0,
  400000,
  'AFN',
  1,
  400000
),
(
  1,
  (SELECT id FROM journal_entries WHERE entry_no='JE-004'),
  (SELECT id FROM accounts WHERE org_id=1 AND code='2010'),
  (SELECT id FROM parties WHERE name='شرکت تجارتی نور'),
  NULL,
  'کاهش حساب پرداختنی',
  100000,
  0,
  'AFN',
  1,
  100000
),
(
  1,
  (SELECT id FROM journal_entries WHERE entry_no='JE-004'),
  (SELECT id FROM accounts WHERE org_id=1 AND code='1010'),
  (SELECT id FROM parties WHERE name='شرکت تجارتی نور'),
  NULL,
  'پرداخت نقد',
  0,
  100000,
  'AFN',
  1,
  100000
);

INSERT INTO inventory_movements (org_id, item_id, movement_type, qty, unit_price, currency, journal_id, notes)
VALUES
(1, 1, 'OPENING', 120, 3000, 'AFN', (SELECT id FROM journal_entries WHERE entry_no='JE-001'), 'موجودی اولیه برنج'),
(1, 2, 'OPENING', 80, 50, 'USD', (SELECT id FROM journal_entries WHERE entry_no='JE-003'), 'موجودی اولیه شکر');

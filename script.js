:root {
  --bg: #020d18;
  --bg-2: #061825;
  --panel: rgba(18, 28, 39, 0.94);
  --panel-2: rgba(17, 29, 42, 0.92);
  --panel-3: rgba(27, 39, 49, 0.98);
  --border: rgba(149, 178, 210, 0.18);
  --text: #eaf2ff;
  --muted: #8ea0b6;
  --primary: #f4b938;
  --primary-soft: #f7d77d;
  --danger: #ea5b63;
  --danger-soft: rgba(234, 91, 99, 0.18);
  --success: #50d390;
  --success-soft: rgba(80, 211, 144, 0.18);
  --warning: #f0b74d;
  --warning-soft: rgba(240, 183, 77, 0.18);
  --blue: #4d9fff;
  --shadow: rgba(0, 0, 0, 0.38);
}

* {
  box-sizing: border-box;
}

html, body {
  margin: 0;
  min-height: 100%;
  font-family: "Inter", sans-serif;
  background: #01070d;
  color: var(--text);
}

body {
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
  background: #01070d;
}

button, input {
  font: inherit;
}

.app-shell {
  width: 1440px;
  height: 900px;
  display: flex;
  background: linear-gradient(180deg, rgba(2, 13, 24, 0.92), rgba(1, 12, 19, 0.96));
  box-shadow: 0 40px 80px rgba(0, 0, 0, 0.6);
  border: 1px solid rgba(110, 148, 191, 0.2);
  overflow: hidden;
}

.sidebar {
  width: 250px;
  background: rgba(4, 14, 21, 0.9);
  border-right: 1px solid var(--border);
  display: flex;
  flex-direction: column;
  padding: 18px 14px 12px;
}

.brand-wrap {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 6px 8px 18px;
  border-bottom: 1px solid rgba(255,255,255,0.04);
  margin-bottom: 18px;
}

.brand-badge {
  width: 32px;
  height: 32px;
  border-radius: 10px;
  display: grid;
  place-items: center;
  background: linear-gradient(135deg, #f4b938, #d88a18);
  color: #111;
  font-weight: 800;
  box-shadow: 0 8px 20px rgba(244, 185, 56, 0.42);
}

.brand-text h1 {
  margin: 0;
  font-size: 14px;
  line-height: 1.2;
  font-weight: 700;
}

.brand-text span {
  color: var(--muted);
  font-size: 10px;
}

.nav {
  display: flex;
  flex-direction: column;
  gap: 10px;
  margin-top: 8px;
}

.nav-item {
  appearance: none;
  border: none;
  background: transparent;
  color: rgba(234, 242, 255, 0.92);
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 14px;
  padding: 10px 12px;
  border-radius: 12px;
  text-align: left;
  transition: all 0.2s ease;
  cursor: pointer;
}

.nav-item:hover,
.nav-item.active {
  background: rgba(244, 185, 56, 0.18);
  color: #ffffff;
  box-shadow: inset 0 0 0 1px rgba(244, 185, 56, 0.25);
}

.nav-item .icon {
  width: 18px;
  display: inline-flex;
  justify-content: center;
  color: rgba(255,255,255,0.8);
}

.version-row {
  margin-top: auto;
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-size: 10px;
  color: var(--muted);
  padding: 12px 8px 4px;
  border-top: 1px solid rgba(255,255,255,0.04);
}

.status-dot {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  border: 2px solid rgba(255,255,255,0.55);
  position: relative;
}

.status-dot::after {
  content: "";
  position: absolute;
  inset: 2px;
  border-radius: 50%;
  background: var(--success);
}

.content {
  flex: 1;
  background: linear-gradient(180deg, rgba(6, 18, 28, 0.9), rgba(5, 16, 24, 0.96));
  padding: 18px 24px 20px;
  position: relative;
}

.topbar {
  height: 52px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 20px;
  margin-bottom: 22px;
}

.search-box {
  flex: 1;
  max-width: 440px;
  display: flex;
  align-items: center;
  gap: 10px;
  height: 42px;
  padding: 0 14px;
  border-radius: 12px;
  background: rgba(27, 42, 56, 0.8);
  border: 1px solid rgba(134, 160, 193, 0.15);
  color: var(--muted);
}

.search-box input {
  flex: 1;
  height: 100%;
  background: transparent;
  border: none;
  outline: none;
  color: var(--text);
  font-size: 14px;
}

.search-box input::placeholder {
  color: var(--muted);
}

.search-icon {
  font-weight: 700;
  color: var(--muted);
}

.top-actions {
  display: flex;
  align-items: center;
  gap: 18px;
}

.mini-title {
  color: var(--muted);
  font-size: 12px;
  letter-spacing: 0.04em;
  display: flex;
  align-items: center;
  gap: 8px;
}

.mini-title::before {
  content: "";
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: var(--success);
  box-shadow: 0 0 12px rgba(80, 211, 144, 0.8);
}

.action-group {
  display: flex;
  align-items: center;
  gap: 8px;
}

.action-btn {
  width: 28px;
  height: 28px;
  border-radius: 8px;
  border: 1px solid rgba(255,255,255,0.08);
  background: rgba(20, 36, 48, 0.8);
  color: var(--muted);
  cursor: pointer;
}

.user-pill {
  width: 28px;
  height: 28px;
  border-radius: 50%;
  background: linear-gradient(135deg, #f4b938, #e28a16);
  display: grid;
  place-items: center;
  color: #111;
  font-weight: 800;
  font-size: 12px;
}

.stats-row {
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
  gap: 16px;
  margin-bottom: 18px;
}

.stat-card,
.metric-box {
  background: linear-gradient(180deg, rgba(17, 31, 42, 0.9), rgba(12, 24, 33, 0.94));
  border: 1px solid rgba(181, 200, 221, 0.12);
  border-radius: 14px;
  padding: 14px 16px 10px;
  box-shadow: inset 0 1px 0 rgba(255,255,255,0.04);
}

.stat-card {
  min-height: 116px;
}

.stat-card.highlighted {
  border-color: rgba(244, 185, 56, 0.48);
  box-shadow: inset 0 0 0 1px rgba(244, 185, 56, 0.12);
}

.card-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  color: var(--muted);
  font-size: 13px;
  margin-bottom: 18px;
}

.card-icon {
  width: 26px;
  height: 26px;
  display: grid;
  place-items: center;
  border-radius: 8px;
  font-size: 13px;
  background: rgba(255,255,255,0.05);
  color: var(--primary-soft);
}

.card-icon.warning {
  background: rgba(240, 183, 77, 0.12);
  color: var(--warning);
}

.card-icon.danger {
  background: rgba(234, 91, 99, 0.12);
  color: var(--danger);
}

.card-icon.box {
  background: rgba(77, 159, 255, 0.12);
  color: var(--blue);
}

.value {
  font-weight: 700;
  font-size: clamp(21px, 2vw, 34px);
  letter-spacing: -0.04em;
  color: var(--text);
}

.one-third {
  display: flex;
  justify-content: flex-start;
  margin-bottom: 12px;
}

.full-width {
  width: 25%;
}

.panel-block {
  margin-top: 20px;
}

.panel-block h2 {
  margin: 0 0 18px;
  font-size: 15px;
  font-weight: 700;
  color: rgba(255,255,255,0.95);
}

.mini-grid {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 16px;
}

.metric-top {
  display: flex;
  align-items: center;
  justify-content: space-between;
  color: var(--muted);
  font-size: 12px;
  margin-bottom: 16px;
}

.metric-box {
  min-height: 120px;
}

.metric-value {
  font-weight: 700;
  font-size: clamp(18px, 2vw, 28px);
  letter-spacing: -0.04em;
}

.mini-icon {
  width: 26px;
  height: 26px;
  border-radius: 8px;
  display: grid;
  place-items: center;
  font-size: 12px;
  font-weight: 700;
}

.mini-icon.success {
  background: rgba(80, 211, 144, 0.12);
  color: var(--success);
}

.mini-icon.primary {
  background: rgba(77, 159, 255, 0.12);
  color: var(--blue);
}

.mini-icon.warning {
  background: rgba(240, 183, 77, 0.12);
  color: var(--warning);
}

.mini-icon.danger {
  background: rgba(234, 91, 99, 0.12);
  color: var(--danger);
}

.mini-icon.neutral {
  background: rgba(255,255,255,0.06);
  color: var(--text);
}

@media (max-width: 1200px) {
  .app-shell {
    width: 100vw;
    height: 100vh;
  }
}

@media (max-width: 960px) {
  .app-shell {
    flex-direction: column;
  }

  .sidebar {
    width: 100%;
    min-height: auto;
    border-right: none;
    border-bottom: 1px solid var(--border);
  }

  .stats-row,
  .mini-grid {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }
}

@media (max-width: 640px) {
  .stats-row,
  .mini-grid {
    grid-template-columns: 1fr;
  }

  .topbar {
    flex-direction: column;
    align-items: stretch;
    height: auto;
  }

  .content {
    padding: 16px;
  }

  .full-width {
    width: 100%;
  }
}

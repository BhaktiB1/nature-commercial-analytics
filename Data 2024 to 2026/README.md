# Nature V2 — synthetic environmental-services Power BI portfolio data

**Entirely fictional data.** This dataset was generated for portfolio demonstration; it is not data from Nurture Group or any actual business. The simulation deliberately includes seasonal demand, contract-specific pricing and cost differences, weather/resource disruption, labour overruns, and service-level variation. These are simulated assumptions, not discovered real-world causes.

## Snapshot and grains
- Period: 2024-01-01 to 2026-12-31; snapshot/as-of: 2026-12-31.
- Dimensions: `dim_clients`, `dim_regions`, `dim_services`, `dim_contracts`. Original IDs and names preserved to simplify migration; contract dates and annual values regenerated.
- `fact_jobs`: one row per scheduled job, including status, dates, complexity, priority, weather/resource flags, planned/actual labour, and **job_earned_revenue_gbp** (an operational accrual proxy for completed jobs).
- `fact_job_costs`: one row per completed job; the five components reconcile exactly to total actual cost.
- `fact_jobs_enriched`: convenient alternative to loading `fact_jobs` and `fact_job_costs` separately. **Choose one approach, not both.**
- `fact_invoices`: one row per invoiced completed job; `invoice_date` may differ from `completed_date`; some completed jobs are uninvoiced as of the snapshot. No drafts, voids or credits in this version.
- `fact_monthly_budgets`: one row per contract x month, first-of-month date, except a small documented share of contract-months with activity but no budget.
- `fact_contract_events`: contract review events, not actual renewal outcomes.
- `qa_contract_month_reconciliation`: optional audit table at contract-month grain, not intended as a reporting fact.

## Recommended Power BI model
Use `dim_services/regions/clients` (1) -> `dim_contracts` (many), then `dim_contracts` (1) -> `fact_jobs_enriched`, `fact_invoices`, `fact_monthly_budgets`, `fact_contract_events` (many), single-direction filtering. **Do not connect fact_invoices to fact_jobs_enriched** in addition to the contract path. Calendar[Date] active to `fact_jobs_enriched[completed_date]`, `fact_invoices[invoice_date]`, `fact_monthly_budgets[month]`; inactive to scheduled_date and due_date. Be aware blank completed dates create a blank date member; exclude open jobs in P&L measures.

**P&L:** `SUM(fact_jobs_enriched[job_earned_revenue_gbp]) - SUM(fact_jobs_enriched[total_actual_cost_gbp])`, both by job completion date. The job earned revenue is a synthetic operational proxy, not a GAAP/IFRS revenue recognition determination. **Billing:** `SUM(fact_invoices[invoice_amount_gbp])`, by invoice date. Never subtract completion-date costs from invoice-date billed revenue and call it matched profit.

**Budgets:** `fact_monthly_budgets[month]` is first of month; compare at contract-month or higher and limit to the same completed months. `budgeted_jobs` models expected completed jobs, not scheduled jobs. Missing budget contract-months must be identified as unbudgeted activity; do not treat as missing actuals. A monthly P&L comparison must use the completion-date cohort.

**On-time:** completion-cohort rate = completed on/before due / completed. Due-cohort rate = jobs due on/before as-of that completed on/before due / all jobs due on/before as-of (includes overdue open jobs). Due cohort requires due_date relationship; completion cohort uses completed_date. The simulation makes due_date >= scheduled_date.

## Reconciliation and QA
`qa_contract_month_reconciliation.csv` contains actual/budget revenue, cost, completed jobs and the exact volume/rate/unbudgeted GP bridge. `bridge_check_gbp` must be zero (allow <= £0.01 rounding). The contract-month decomposition is a mathematical attribution, **not proof of causal drivers**. `VALIDATION_SUMMARY.json` has overall counts and KPI diagnostics.

## Migration
1. Save a copy of your existing PBIX/PBIP before replacing sources.
2. Load V2 files into a separate Power BI copy. Preserve dimensions but refresh contract attributes.
3. Use `fact_jobs_enriched` for job-grain P&L and operations, `fact_invoices` for billing, budgets for targets.
4. Recreate date relationships; revise old DAX that used invoice-date Total Revenue or scheduled-date costs.
5. Validate grand totals, service/region totals, both on-time definitions and bridge checks against QA tables.
6. Update the README and report footer to say **Synthetic Nature V2 data, snapshot 31 Dec 2026**.

## Caveats
No real clients, market data, weather feeds, contract losses or accounting ledger. Contract events are simulated administrative records; do not estimate churn probabilities from them. Cost differences and seasonal patterns were programmed into the simulation. Some job fields are blank on open jobs by design. All monetary amounts are GBP. Fixed RNG seed 20261115 for reproducibility.

## 2026 extension
Synthetic full-year scenario, including dates beyond today. Existing completed 2024–2025 P&L and budgets are unchanged. 277 previously open jobs are completed in January 2026; prior uninvoiced completed jobs may be billed in 2026. Existing invoices and events retained. Contract dates/values unchanged; status updated to year-end 2026 (use date-based measures for historical reporting). No renewals or new contracts assumed; activity ends at expiry. 2026 jobs resampled from contract/month 2025 patterns with modest volume and price/cost variation; budgets scaled from 2025 and prorated for expiry. Existing missing budgets retained as a pattern. Historical invoice statuses are not aged forward. Seed 20261117 for extension.

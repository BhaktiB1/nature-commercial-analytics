# Nature | Technical documentation

## Model and implementation
Contract-centred snowflake/multi-fact model. Jobs (one per job), invoices, events, monthly budgets and QA reconciliation connect to contracts; client, service and region dimensions filter via contracts. Calendar filters completed date and budget month; scheduled, due and invoice dates are inactive relationships. Jobs Scheduled activates scheduled date using USERELATIONSHIP. Power Query imports enriched jobs, promotes headers and sets types. Avoid adding raw costs to enriched totals again. Disconnected metric and series selectors, heatmap and ranking tables drive SWITCH calculations. Operational risk scores timeliness, repeat rate and labour variance (0–6); contract risk separately uses margin and timeliness with minimum 20 eligible jobs. Six measure groups organise calculation logic. Expiry bands use TODAY() at refresh, whereas active/renewal measures use selected calendar end. Risk distribution is not explicitly active-only. Validate these before publication.

## Pages
Overview, Operations, Financials, Contracts, Contract Details (saved model also contains Dashboard page).

## Reproduce
Open PBIX or complete PBIP in Power BI Desktop, repoint CSV sources to local Data folder, refresh and validate. Exported DAX and M collections are reference definitions, not a single executable script. See data dictionary and relationship export. Model inspected, not executed in Desktop.

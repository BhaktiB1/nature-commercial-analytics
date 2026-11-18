# Nature | Commercial & Operational Intelligence

**Business Intelligence · Commercial Analytics · Financial Performance · Operational Efficiency**

![Power BI](https://img.shields.io/badge/Power_BI-F2C811?logo=powerbi&logoColor=black) ![DAX](https://img.shields.io/badge/DAX-45636C) ![Power Query](https://img.shields.io/badge/Power_Query-M-45636C) ![Data](https://img.shields.io/badge/Data-Synthetic-lightgrey)

## Project overview

Nature is an independently developed Power BI solution for a fictional UK environmental services business. It integrates financial, operational and contractual information to help decision-makers monitor profitability, service delivery and commercial risk within a single reporting environment.

![Nature executive overview](Screenshots/01.%20Overview.png)

## Business objectives

- Monitor revenue, costs, profitability and budget performance.
- Identify service and regional delivery challenges, labour overruns and repeat visits.
- Assess client and contract profitability, risk and renewal exposure.
- Translate performance indicators into actionable executive insights.

## Key findings | 2025 illustrative results

| KPI | Result |
|---|---:|
| Earned revenue | £19.28M |
| Total costs | £12.34M |
| Gross profit | £6.94M |
| Gross margin | 36.01% |
| Revenue variance vs budget | +3.68% |
| Cost variance vs budget | +6.05% |
| Completed jobs | 23,856 |
| On-time completion | 82.97% |
| Repeat visit rate | 7.04% |
| Average delay among late jobs | 2.17 days |

Revenue exceeds budget, but expenditure is increasing faster relative to its budget. Delivery performance and repeat visits provide further opportunities to review operational efficiency.

## Dashboard walkthrough

### 1. Executive overview

Consolidated financial and operational KPIs, selectable performance trends, client and contract rankings, service-region risk and dynamic executive commentary.

### 2. Operations

Workload, delivery timeliness and labour efficiency trends, regional performance comparisons, dynamic service-region heatmaps and delay severity analysis.

![Operations dashboard](Screenshots/02.%20Operations.png)

### 3. Financials

Year-on-year profitability, budget variance, service-level financial performance and cost efficiency analysis.

![Financials dashboard](Screenshots/03.%20Financials.png)

### 4. Contracts

Contract profitability, risk distribution, upcoming expiry and renewal exposure, with highest- and lowest-margin client rankings.

![Contracts dashboard](Screenshots/04.%20Contracts.png)

### 5. Contract details

Contract-level register bringing together financial and delivery performance with risk classification.

![Contract details](Screenshots/05.%20Contract%20details.png)

## Technical implementation

| Component | Approach |
|---|---|
| Data preparation | CSV ingestion and Power Query M transformations |
| Semantic model | Contract-centred dimensional model with multiple fact tables |
| Business logic | DAX measures for financial, operational and contractual KPIs |
| Time intelligence | Calendar-based reporting and prior-year comparisons; alternate date relationships for scheduled jobs |
| Dynamic reporting | Disconnected metric/series selectors, conditional formatting and dynamic rankings |
| Risk analysis | Separate operational and contract risk rules |
| Executive reporting | Filter-responsive narrative measures |

### Data model

The model combines enriched job records, invoices, contract events and monthly budgets with contract, client, region, service and calendar dimensions. Shared dimensions support consistent filtering across reporting areas. Enriched job costs must not be counted again from raw cost records.

![Nature data model](Screenshots/06.%20Data%20model.png)

## Business recommendations

| Priority | Recommended action |
|---|---|
| Protect profitability | Investigate labour and service cost drivers where expenditure exceeds plan. |
| Improve service delivery | Review delay severity and repeat visits by region; test scheduling buffers and resource allocation. |
| Protect renewals | Prioritise upcoming renewals and high-risk contracts, assigning ownership and monitoring outcomes. |

## Project files

- [Power BI report (PBIX)](Operational%20%26%20Financial%20Performance%20V2.pbix)
- [Full dashboard report (PDF)](Operational%20%26%20Financial%20Performance%20V2.pdf)
- [Source datasets](Data%202024%20to%202026/)
- [Implementation scripts](Scripts/)

## Supporting documentation

- [Business insights and recommendations](Documentation/Business_Insights.md)
- [Technical documentation](Documentation/Technical_Documentation.md)
- [KPI dictionary](Documentation/KPI_Dictionary.md)
- [Data dictionary](Documentation/Data_Dictionary.csv)
- [Table inventory](Documentation/Table_Inventory.csv)

## Scope and limitations

This repository presents the reporting solution and supporting documentation. The repository includes the Power BI report, synthetic source data and implementation scripts. The figures above refer to 2025, the period supported by the available source data used for the documented results; they should not be interpreted as verified 2026 figures. Contract expiry bands and selected-date KPIs may use different date anchors, and risk distribution is not necessarily restricted to active contracts. Annual contract value at risk is exposure, not a forecast loss.

## Data disclaimer

Independent professional portfolio project using synthetic data. No real organisation, achieved savings or production deployment is represented.

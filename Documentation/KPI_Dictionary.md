# Nature | KPI dictionary

Definitions and exact formulas from saved model. All calculations respect filter context unless specified.

## Total Revenue

Home table: 01. Financial measures  
Earned job revenue, not cash receipts.

```dax
Total Revenue =
SUM(fact_jobs[job_earned_revenue_gbp])
```

## Total Costs

Home table: 01. Financial measures  
Actual job costs.

```dax
Total Costs =
SUM(fact_jobs[total_actual_cost_gbp])
```

## Gross Profit

Home table: 01. Financial measures  
Revenue less actual job costs.

```dax
Gross Profit =
[Total Revenue] - [Total Costs]
```

## Gross Margin %

Home table: 01. Financial measures  
Gross profit / revenue.

```dax
Gross Margin % =
DIVIDE([Gross Profit], [Total Revenue])
```

## Budget Revenue

Home table: 01. Financial measures  
Supporting measure; calculation and dependencies shown below.

```dax
Budget Revenue =
SUM(fact_monthly_budgets[budgeted_revenue_gbp])
```

## Budget Cost

Home table: 01. Financial measures  
Supporting measure; calculation and dependencies shown below.

```dax
Budget Cost =
SUM(fact_monthly_budgets[budgeted_cost_gbp])
```

## Revenue Variance

Home table: 01. Financial measures  
Revenue less budget.

```dax
Revenue Variance =
[Total Revenue] - [Budget Revenue]
```

## Revenue Variance %

Home table: 01. Financial measures  
Revenue variance / budget.

```dax
Revenue Variance % =
DIVIDE(
    [Total Revenue] - [Budget Revenue],
    [Budget Revenue]
)
```

## Cost Variance

Home table: 01. Financial measures  
Actual cost less budget; positive means overspend.

```dax
Cost Variance =
[Total Costs] - [Budget Cost]
```

## Revenue PY

Home table: 01. Financial measures  
Supporting measure; calculation and dependencies shown below.

```dax
Revenue PY =
CALCULATE(
    [Total Revenue],
    SAMEPERIODLASTYEAR(Calendar[Date])
)
```

## Gross Profit PY

Home table: 01. Financial measures  
Supporting measure; calculation and dependencies shown below.

```dax
Gross Profit PY =
CALCULATE(
    [Gross Profit],
    SAMEPERIODLASTYEAR('Calendar'[Date])
)
```

## Gross Margin PY

Home table: 01. Financial measures  
Supporting measure; calculation and dependencies shown below.

```dax
Gross Margin PY =
CALCULATE(
    [Gross Margin %],
    SAMEPERIODLASTYEAR('Calendar'[Date])
)
```

## Budget Gross Profit

Home table: 01. Financial measures  
Supporting measure; calculation and dependencies shown below.

```dax
Budget Gross Profit =
[Budget Revenue] - [Budget Cost]
```

## Budget Gross Margin %

Home table: 01. Financial measures  
Supporting measure; calculation and dependencies shown below.

```dax
Budget Gross Margin % =
DIVIDE(
    [Budget Gross Profit],
    [Budget Revenue]
)
```

## vs Budget Display

Home table: 01. Financial measures  
Supporting measure; calculation and dependencies shown below.

```dax
vs Budget Display =
VAR Pct = [Revenue Variance %]
RETURN
IF(
    ISBLANK(Pct),
    BLANK(),
    SWITCH(
        TRUE(),
        Pct > 0, "▲ ",
        Pct < 0, "▼ ",
        "● "
    )
    & FORMAT(Pct, "+0.0%;-0.0%;0.0%")
)
```

## vs PY Display

Home table: 01. Financial measures  
Supporting measure; calculation and dependencies shown below.

```dax
vs PY Display =
VAR Pct = [Revenue YoY %]
RETURN
IF(
    ISBLANK(Pct),
    BLANK(),
    SWITCH(
        TRUE(),
        Pct > 0, "▲ ",
        Pct < 0, "▼ ",
        "● "
    )
    & FORMAT(Pct, "+0.0%;-0.0%;0.0%")
)
```

## Cost to Revenue %

Home table: 01. Financial measures  
Supporting measure; calculation and dependencies shown below.

```dax
Cost to Revenue % =
DIVIDE(
    [Total Costs],
    [Total Revenue]
)
```

## Margin Colour

Home table: 01. Financial measures  
Presentation helper for conditional formatting.

```dax
Margin Colour =
VAR Margin = [Gross Margin %]
RETURN
    SWITCH(
        TRUE(),
        ISBLANK(Margin), BLANK(),
        Margin < 0.30, "#F4CCCC",
        Margin <= 0.35, "#FCE5CD",
        "#D9EAD3"
    )
```

## Revenue Variance % Colour

Home table: 01. Financial measures  
Presentation helper for conditional formatting.

```dax
Revenue Variance % Colour =
VAR Variances = [Revenue Variance %]
RETURN
    SWITCH(
        TRUE(),
        ISBLANK(Variances), BLANK(),
        Variances < 0, "#F4CCCC",
        Variances < 0.03, "#FCE5CD",
        "#D9EAD3"
    )
```

## Revenue YoY %

Home table: 01. Financial measures  
Supporting measure; calculation and dependencies shown below.

```dax
Revenue YoY % =
DIVIDE(
    [Total Revenue] - [Revenue PY],
    [Revenue PY]
)
```

## Labour Cost

Home table: 01. Financial measures  
Supporting measure; calculation and dependencies shown below.

```dax
Labour Cost =
SUM(fact_jobs[labour_cost_gbp])
```

## Overtime Cost

Home table: 01. Financial measures  
Supporting measure; calculation and dependencies shown below.

```dax
Overtime Cost =
SUM(fact_jobs[overtime_cost_gbp])
```

## Materials Cost

Home table: 01. Financial measures  
Supporting measure; calculation and dependencies shown below.

```dax
Materials Cost =
SUM(fact_jobs[materials_cost_gbp])
```

## Travel Cost

Home table: 01. Financial measures  
Supporting measure; calculation and dependencies shown below.

```dax
Travel Cost =
SUM(fact_jobs[travel_cost_gbp])
```

## Subcontractor Cost

Home table: 01. Financial measures  
Supporting measure; calculation and dependencies shown below.

```dax
Subcontractor Cost =
SUM(fact_jobs[subcontractor_cost_gbp])
```

## Total Jobs

Home table: 02. Operational measures  
Supporting measure; calculation and dependencies shown below.

```dax
Total Jobs =
DISTINCTCOUNT(fact_jobs[job_id])
```

## Jobs Completed

Home table: 02. Operational measures  
Distinct completed jobs.

```dax
Jobs Completed =
CALCULATE(
    DISTINCTCOUNT(fact_jobs[job_id]),
    fact_jobs[is_completed] = 1
)
```

## On-Time Jobs

Home table: 02. Operational measures  
Supporting measure; calculation and dependencies shown below.

```dax
On-Time Jobs =
CALCULATE(
    [Jobs Completed],
    fact_jobs[is_on_time] = 1
)
```

## On-Time Completion %

Home table: 02. Operational measures  
On-time jobs / completed jobs with due date.

```dax
On-Time Completion % =
DIVIDE(
    [On-Time Jobs],
    [Completed Jobs with Due Date]
)
```

## Repeat Visits

Home table: 02. Operational measures  
Supporting measure; calculation and dependencies shown below.

```dax
Repeat Visits =
CALCULATE(
    [Jobs Completed],
    fact_jobs[repeat_visit_flag] = 1
)
```

## Repeat Visit Rate %

Home table: 02. Operational measures  
Repeat completed jobs / completed jobs.

```dax
Repeat Visit Rate % =
DIVIDE([Repeat Visits], [Jobs Completed])
```

## Planned Labour Hours

Home table: 02. Operational measures  
Supporting measure; calculation and dependencies shown below.

```dax
Planned Labour Hours =
SUM(fact_jobs[planned_labour_hours])
```

## Actual Labour Hours

Home table: 02. Operational measures  
Supporting measure; calculation and dependencies shown below.

```dax
Actual Labour Hours =
SUM(fact_jobs[actual_labour_hours])
```

## Labour Hours Variance

Home table: 02. Operational measures  
Supporting measure; calculation and dependencies shown below.

```dax
Labour Hours Variance =
[Actual Labour Hours] - [Planned Labour Hours]
```

## Completed Jobs with Due Date

Home table: 02. Operational measures  
Supporting measure; calculation and dependencies shown below.

```dax
Completed Jobs with Due Date =
CALCULATE(
    [Jobs Completed],
    NOT ISBLANK(fact_jobs[due_date])
)
```

## Jobs Scheduled

Home table: 02. Operational measures  
Distinct jobs by scheduled date.

```dax
Jobs Scheduled =
CALCULATE(
    DISTINCTCOUNT(fact_jobs[job_id]),
    USERELATIONSHIP(
        'Calendar'[Date],
        fact_jobs[scheduled_date]
    )
)
```

## Labour Hours Variance %

Home table: 02. Operational measures  
(Actual less planned hours) / planned hours.

```dax
Labour Hours Variance % =
DIVIDE(
    [Labour Hours Variance],
    [Planned Labour Hours]
)
```

## Jobs Completed PY

Home table: 02. Operational measures  
Supporting measure; calculation and dependencies shown below.

```dax
Jobs Completed PY =
CALCULATE(
    [Jobs Completed],
    SAMEPERIODLASTYEAR('Calendar'[Date])
)
```

## Average Days Late

Home table: 02. Operational measures  
Mean delay of late completed jobs only.

```dax
Average Days Late =
CALCULATE(
    AVERAGE(fact_jobs[days_late]),
    fact_jobs[is_completed] = 1,
    fact_jobs[days_late] > 0
)
```

## Late Jobs

Home table: 02. Operational measures  
Supporting measure; calculation and dependencies shown below.

```dax
Late Jobs =
CALCULATE(
    COUNTROWS(fact_jobs),
    fact_jobs[is_completed] = 1,
    fact_jobs[days_late] > 0
)
```

## Late Jobs Weather Disruption %

Home table: 02. Operational measures  
Supporting measure; calculation and dependencies shown below.

```dax
Late Jobs Weather Disruption % =
DIVIDE(
    CALCULATE(
        [Late Jobs],
        fact_jobs[weather_disruption_flag] = 1
    ),
    [Late Jobs]
)
```

## Late Jobs Resource Shortage %

Home table: 02. Operational measures  
Supporting measure; calculation and dependencies shown below.

```dax
Late Jobs Resource Shortage % =
DIVIDE(
    CALCULATE(
        [Late Jobs],
        fact_jobs[resource_shortage_flag] = 1
    ),
    [Late Jobs]
)
```

## Jobs Remaining

Home table: 02. Operational measures  
Jobs scheduled in selected period not completed by period end.

```dax
Jobs Remaining =
VAR PeriodEnd =
    MAX('Calendar'[Date])

RETURN
CALCULATE(
    COUNTROWS(fact_jobs),
    USERELATIONSHIP(
        'Calendar'[Date],
        fact_jobs[scheduled_date]
    ),
    FILTER(
        ALL(fact_jobs[completed_date]),
        ISBLANK(fact_jobs[completed_date])
            || fact_jobs[completed_date] > PeriodEnd
    )
)
```

## Active Contracts

Home table: 03. Contract measures  
Start <= selected calendar end <= contract end.

```dax
Active Contracts =
VAR AsOfDate = [Reporting Date]
RETURN
CALCULATE(
    DISTINCTCOUNT(dim_contracts[contract_id]),
    REMOVEFILTERS('Calendar'),
    KEEPFILTERS(
        FILTER(
            dim_contracts,
            dim_contracts[contract_start] <= AsOfDate
                && dim_contracts[contract_end] >= AsOfDate
        )
    )
)
```

## Expired Contracts

Home table: 03. Contract measures  
End before selected calendar end.

```dax
Expired Contracts =
VAR AsOfDate = [Reporting Date]
RETURN
CALCULATE(
    DISTINCTCOUNT(dim_contracts[contract_id]),
    REMOVEFILTERS('Calendar'),
    KEEPFILTERS(
        FILTER(
            dim_contracts,
            dim_contracts[contract_end] < AsOfDate
        )
    )
)
```

## Contracts Expiring in 90 Days

Home table: 03. Contract measures  
Active contracts ending within 90 days inclusive.

```dax
Contracts Expiring in 90 Days =
VAR AsOfDate = [Reporting Date]
RETURN
CALCULATE(
    DISTINCTCOUNT(dim_contracts[contract_id]),
    REMOVEFILTERS('Calendar'),
    KEEPFILTERS(
        FILTER(
            dim_contracts,
            dim_contracts[contract_start] <= AsOfDate
                && dim_contracts[contract_end] >= AsOfDate
                && dim_contracts[contract_end] <= AsOfDate + 90
        )
    )
)
```

## Annual Contract Value

Home table: 03. Contract measures  
Sum of annual contractual values.

```dax
Annual Contract Value =
SUM(dim_contracts[annual_contract_value_gbp])
```

## Average Contract Margin %

Home table: 03. Contract measures  
Unweighted mean margin of positive-revenue contracts.

```dax
Average Contract Margin % =
AVERAGEX(
    FILTER(
        VALUES(dim_contracts[contract_id]),
        [Total Revenue] > 0
    ),
    [Gross Margin %]
)
```

## Low Margin Contracts

Home table: 03. Contract measures  
Positive-revenue contracts with margin below 25%.

```dax
Low Margin Contracts =
COUNTROWS(
    FILTER(
        VALUES(dim_contracts[contract_id]),
        [Total Revenue] > 0
            && [Gross Margin %] < 0.25
    )
)
```

## Contract Profit Rank

Home table: 03. Contract measures  
Supporting measure; calculation and dependencies shown below.

```dax
Contract Profit Rank =
IF(
    ISINSCOPE(dim_contracts[contract_id]),
    RANKX(
        ALLSELECTED(dim_contracts[contract_id]),
        [Gross Profit],
        ,
        DESC,
        DENSE
    )
)
```

## Renewal Value 90 Days

Home table: 03. Contract measures  
Annual value of active contracts expiring within 90 days.

```dax
Renewal Value 90 Days =
VAR AsOfDate = [Reporting Date]
RETURN
CALCULATE(
    [Annual Contract Value],
    REMOVEFILTERS('Calendar'),
    KEEPFILTERS(
        FILTER(
            dim_contracts,
            dim_contracts[contract_start] <= AsOfDate
                && dim_contracts[contract_end] >= AsOfDate
                && dim_contracts[contract_end] <= AsOfDate + 90
        )
    )
)
```

## Revenue at Risk

Home table: 03. Contract measures  
Annual value of active High risk contracts; not expected loss.

```dax
Revenue at Risk =
VAR AsOfDate = [Reporting Date]
RETURN
SUMX(
    FILTER(
        VALUES(dim_contracts[contract_id]),
        CALCULATE(MIN(dim_contracts[contract_start])) <= AsOfDate
            && CALCULATE(MAX(dim_contracts[contract_end])) >= AsOfDate
            && [Contract Risk Level] = "High"
    ),
    [Annual Contract Value]
)
```

## Reporting Date

Home table: 03. Contract measures  
Supporting measure; calculation and dependencies shown below.

```dax
Reporting Date =
MAX('Calendar'[Date])
```

## Upcoming Contracts

Home table: 03. Contract measures  
Start after selected calendar end.

```dax
Upcoming Contracts =
VAR AsOfDate = [Reporting Date]
RETURN
CALCULATE(
    DISTINCTCOUNT(dim_contracts[contract_id]),
    REMOVEFILTERS('Calendar'),
    KEEPFILTERS(
        FILTER(
            dim_contracts,
            dim_contracts[contract_start] > AsOfDate
        )
    )
)
```

## Risk Score

Home table: 04. Risk measures  
Operational score from timeliness, repeats and labour variance (0–6).

```dax
Risk Score =
VAR OnTime = [On-Time Completion %]
VAR RepeatRate = [Repeat Visit Rate %]
VAR LabourVar = [Labour Hours Variance %]

VAR OnTimeScore =
    SWITCH(
        TRUE(),
        ISBLANK(OnTime), BLANK(),
        OnTime < 0.80, 2,
        OnTime < 0.85, 1,
        0
    )

VAR RepeatScore =
    SWITCH(
        TRUE(),
        ISBLANK(RepeatRate), BLANK(),
        RepeatRate > 0.10, 2,
        RepeatRate > 0.07, 1,
        0
    )

VAR LabourScore =
    SWITCH(
        TRUE(),
        ISBLANK(LabourVar), BLANK(),
        LabourVar > 0.07, 2,
        LabourVar > 0.03, 1,
        0
    )

RETURN
IF(
    ISBLANK(OnTimeScore)
        || ISBLANK(RepeatScore)
        || ISBLANK(LabourScore),
    BLANK(),
    OnTimeScore + RepeatScore + LabourScore
)
```

## Risk Level

Home table: 04. Risk measures  
Supporting measure; calculation and dependencies shown below.

```dax
Risk Level =
VAR Score = [Risk Score]
RETURN
SWITCH(
    TRUE(),
    ISBLANK(Score), "Insufficient data",
    Score >= 4, "High",
    Score >= 2, "Medium",
    "Low"
)
```

## Risk Colour

Home table: 04. Risk measures  
Presentation helper for conditional formatting.

```dax
Risk Colour =
SWITCH(
    [Risk Level],
    "High", "#F4CCCC",
    "Medium", "#FCE5CD",
    "Low", "#D9EAD3",
    "#7C8D99"
)
```

## High Risk Contracts

Home table: 04. Risk measures  
Supporting measure; calculation and dependencies shown below.

```dax
High Risk Contracts =
VAR AsOfDate = [Reporting Date]
RETURN
COALESCE(
    COUNTROWS(
        FILTER(
            VALUES(dim_contracts[contract_id]),
            CALCULATE(MIN(dim_contracts[contract_start])) <= AsOfDate
                && CALCULATE(MAX(dim_contracts[contract_end])) >= AsOfDate
                && [Contract Risk Level] = "High"
        )
    ),
    0
)
```

## Contract Risk Level

Home table: 04. Risk measures  
Insufficient if missing margin/timeliness or fewer than 20 eligible jobs; High if margin <20% or on-time <80%; otherwise Medium if margin <30% or on-time <85%; otherwise Low.

```dax
Contract Risk Level =
VAR Margin = [Gross Margin %]
VAR OnTime = [On-Time Completion %]
VAR Jobs = [Completed Jobs with Due Date]

RETURN
SWITCH(
    TRUE(),
    ISBLANK(Margin)
        || ISBLANK(OnTime)
        || Jobs < 20,
        "Insufficient Data",

    Margin < 0.20 || OnTime < 0.80,
        "High",

    Margin < 0.30 || OnTime < 0.85,
        "Medium",

    "Low"
)
```

## Contracts by Risk

Home table: 04. Risk measures  
Count by classification, not explicitly active-only.

```dax
Contracts by Risk =
VAR SelectedRisk =
    SELECTEDVALUE(
        'Contract Risk Categories'[Risk]
    )
RETURN
IF(
    ISBLANK(SelectedRisk),
    BLANK(),
    COUNTROWS(
        FILTER(
            VALUES(dim_contracts[contract_id]),
            CALCULATE([Contract Risk Level]) = SelectedRisk
        )
    )
)
```

## Highest Risk Service Region

Home table: 04. Risk measures  
Supporting measure; calculation and dependencies shown below.

```dax
Highest Risk Service Region =
VAR Candidates =
    ADDCOLUMNS(
        CROSSJOIN(
            ALLSELECTED(dim_services[service_name]),
            ALLSELECTED(dim_regions[region_name])
        ),
        "@Risk", [Risk Score],
        "@Jobs", [Jobs Completed]
    )

VAR EligibleCandidates =
    FILTER(
        Candidates,
        [@Jobs] >= 100
            && NOT ISBLANK([@Risk])
    )

VAR HighestRisk =
    TOPN(
        1,
        EligibleCandidates,
        [@Risk], DESC,
        [@Jobs], DESC,
        dim_services[service_name], ASC,
        dim_regions[region_name], ASC
    )

RETURN
IF(
    ISEMPTY(HighestRisk),
    BLANK(),
    CONCATENATEX(
        HighestRisk,
        dim_services[service_name]
            & " - "
            & dim_regions[region_name]
    )
)
```

## High Risk Contracts %

Home table: 04. Risk measures  
Supporting measure; calculation and dependencies shown below.

```dax
High Risk Contracts % =
DIVIDE(
    [High Risk Contracts],
    [Active Contracts],
    0
)
```

## Contract Risk Colour

Home table: 04. Risk measures  
Presentation helper for conditional formatting.

```dax
Contract Risk Colour =
SWITCH(
    [Contract Risk Level],
    "High", "#F4CCCC",
    "Medium", "#FCE5CD",
    "Low", "#D9EAD3",
    "Insufficient Data", "#E7E6E6",
    BLANK()
)
```

## Dynamic Actual

Home table: 05. Dynamic measures  
Supporting measure; calculation and dependencies shown below.

```dax
Dynamic Actual =
VAR SelectedMetric =
    SELECTEDVALUE(
        'Performance Metric Selector'[Metric],
        "Revenue"
    )
RETURN
SWITCH(
    SelectedMetric,
    "Revenue", [Total Revenue],
    "Gross Profit", [Gross Profit],
    "Gross Margin %", [Gross Margin %],
    "Jobs Completed", [Jobs Completed],
    BLANK()
)
```

## Dynamic Budget / Scheduled

Home table: 05. Dynamic measures  
Supporting measure; calculation and dependencies shown below.

```dax
Dynamic Budget / Scheduled =
VAR SelectedMetric =
    SELECTEDVALUE(
        'Performance Metric Selector'[Metric],
        "Revenue"
    )
RETURN
SWITCH(
    SelectedMetric,
    "Revenue", [Budget Revenue],
    "Gross Profit", [Budget Gross Profit],
    "Gross Margin %", [Budget Gross Margin %],
    "Jobs Completed", [Jobs Scheduled],
    BLANK()
)
```

## Dynamic Previous Year

Home table: 05. Dynamic measures  
Supporting measure; calculation and dependencies shown below.

```dax
Dynamic Previous Year =
VAR SelectedMetric =
    SELECTEDVALUE(
        'Performance Metric Selector'[Metric],
        "Revenue"
    )
RETURN
SWITCH(
    SelectedMetric,
    "Revenue", [Revenue PY],
    "Gross Profit", [Gross Profit PY],
    "Gross Margin %", [Gross Margin PY],
    "Jobs Completed", [Jobs Completed PY],
    BLANK()
)
```

## Performance Trend Title

Home table: 05. Dynamic measures  
Supporting measure; calculation and dependencies shown below.

```dax
Performance Trend Title =
VAR Metric =
    SELECTEDVALUE(
        'Performance Metric Selector'[Metric],
        "Revenue"
    )
RETURN
Metric
    & ": Current Year vs "
    & IF(
        Metric = "Jobs Completed",
        "Scheduled",
        "Budget"
    )
    & " vs Previous Year"
```

## Profitability Rank

Home table: 05. Dynamic measures  
Supporting measure; calculation and dependencies shown below.

```dax
Profitability Rank =
VAR RankingChoice =
    SELECTEDVALUE(
        'Profit Ranking Selector'[Ranking],
        "Top 10"
    )

RETURN
SWITCH(
    TRUE(),

    ISINSCOPE(dim_contracts[Contract]),
        IF(
            RankingChoice = "Top 10",
            RANKX(
                ALLSELECTED(dim_contracts[Contract]),
                [Gross Profit],
                ,
                DESC,
                DENSE
            ),
            RANKX(
                ALLSELECTED(dim_contracts[Contract]),
                [Gross Profit],
                ,
                ASC,
                DENSE
            )
        ),

    ISINSCOPE(dim_clients[Client]),
        IF(
            RankingChoice = "Top 10",
            RANKX(
                ALLSELECTED(dim_clients[Client]),
                [Gross Profit],
                ,
                DESC,
                DENSE
            ),
            RANKX(
                ALLSELECTED(dim_clients[Client]),
                [Gross Profit],
                ,
                ASC,
                DENSE
            )
        ),

    BLANK()
)
```

## Operations Trend Actual

Home table: 05. Dynamic measures  
Supporting measure; calculation and dependencies shown below.

```dax
Operations Trend Actual =
SWITCH(
    SELECTEDVALUE(
        'Operations Trend Selector'[Metric],
        "Workload"
    ),
    "Workload", [Jobs Completed],
    "Delivery Timeliness", [On-Time Jobs],
    "Labour Efficiency", [Actual Labour Hours],
    BLANK()
)
```

## Operations Trend Comparison

Home table: 05. Dynamic measures  
Supporting measure; calculation and dependencies shown below.

```dax
Operations Trend Comparison =
VAR Metric =
    SELECTEDVALUE(
        'Operations Trend Selector'[Metric],
        "Workload"
    )
RETURN
SWITCH(
    Metric,
    "Workload", [Jobs Scheduled],
    "Delivery Timeliness",
        [Jobs Completed] - [On-Time Jobs],
    "Labour Efficiency", [Planned Labour Hours],
    BLANK()
)
```

## Operations Trend Title

Home table: 05. Dynamic measures  
Supporting measure; calculation and dependencies shown below.

```dax
Operations Trend Title =
SWITCH(
    SELECTEDVALUE(
        'Operations Trend Selector'[Metric],
        "Workload"
    ),
    "Workload", "Jobs Completed vs Scheduled",
    "Delivery Timeliness", "On-Time vs Late Jobs",
    "Labour Efficiency", "Actual vs Planned Labour Hours"
)
```

## Overview Trend Value

Home table: 05. Dynamic measures  
Supporting measure; calculation and dependencies shown below.

```dax
Overview Trend Value =
VAR SelectedMetric =
    SELECTEDVALUE(
        'Performance Metric Selector'[Metric],
        "Revenue"
    )

VAR SeriesMetric =
    SELECTEDVALUE('Overview Trend Series'[Metric])

VAR SeriesOrder =
    SELECTEDVALUE('Overview Trend Series'[Sort Order])

RETURN
IF(
    SelectedMetric = SeriesMetric,
    SWITCH(
        SeriesOrder,
        1, [Dynamic Actual],
        2, [Dynamic Budget / Scheduled],
        3, [Dynamic Previous Year],
        BLANK()
    )
)
```

## Operations Heatmap Value

Home table: 05. Dynamic measures  
Supporting measure; calculation and dependencies shown below.

```dax
Operations Heatmap Value =
VAR SelectedMetric =
    SELECTEDVALUE(
        'Operations Heatmap Selector'[Metric],
        "On-Time Completion %"
    )
RETURN
SWITCH(
    SelectedMetric,
    "On-Time Completion %", [On-Time Completion %],
    "Repeat Visit Rate %", [Repeat Visit Rate %],
    "Labour Hours Variance %", [Labour Hours Variance %],
    "Operational Risk Score", [Risk Score],
    BLANK()
)
```

## Operations Heatmap Colour

Home table: 05. Dynamic measures  
Presentation helper for conditional formatting.

```dax
Operations Heatmap Colour =
VAR Metric =
    SELECTEDVALUE(
        'Operations Heatmap Selector'[Metric],
        "On-Time Completion %"
    )
VAR ValueToCheck = [Operations Heatmap Value]

RETURN
SWITCH(
    TRUE(),

    ISBLANK(ValueToCheck), "#FAF7F0",

    Metric = "On-Time Completion %" &&
        ValueToCheck < 0.80, "#F3D6CF",

    Metric = "On-Time Completion %" &&
        ValueToCheck < 0.85, "#F5E9C8",

    Metric = "On-Time Completion %", "#DCEFE3",

    Metric = "Repeat Visit Rate %" &&
        ValueToCheck > 0.10, "#F3D6CF",

    Metric = "Repeat Visit Rate %" &&
        ValueToCheck > 0.07, "#F5E9C8",

    Metric = "Repeat Visit Rate %", "#DCEFE3",

    Metric = "Labour Hours Variance %" &&
        ValueToCheck > 0.07, "#F3D6CF",

    Metric = "Labour Hours Variance %" &&
        ValueToCheck > 0.03, "#F5E9C8",

    Metric = "Labour Hours Variance %", "#DCEFE3",

    Metric = "Operational Risk Score" &&
        ValueToCheck >= 4, "#F3D6CF",

    Metric = "Operational Risk Score" &&
        ValueToCheck >= 2, "#F5E9C8",

    "#DCEFE3"
)
```

## Operations Trend Value

Home table: 05. Dynamic measures  
Supporting measure; calculation and dependencies shown below.

```dax
Operations Trend Value =
VAR SelectedMetric =
    SELECTEDVALUE(
        'Operations Trend Selector'[Metric],
        "Workload"
    )

VAR SelectedSeries =
    SELECTEDVALUE('Operations Trend Series'[Series])

RETURN
SWITCH(
    TRUE(),

    SelectedMetric = "Workload"
        && SelectedSeries = "Jobs Completed",
        [Jobs Completed],

    SelectedMetric = "Workload"
        && SelectedSeries = "Jobs Scheduled",
        [Jobs Scheduled],

    SelectedMetric = "Delivery Timeliness"
        && SelectedSeries = "On-Time Jobs",
        [On-Time Jobs],

    SelectedMetric = "Delivery Timeliness"
        && SelectedSeries = "Late Jobs",
        [Late Jobs],

    SelectedMetric = "Labour Efficiency"
        && SelectedSeries = "Actual Labour Hours",
        [Actual Labour Hours],

    SelectedMetric = "Labour Efficiency"
        && SelectedSeries = "Planned Labour Hours",
        [Planned Labour Hours],

    BLANK()
)
```

## Executive Financial Insight

Home table: 06. Executive Insights  
Filter-responsive narrative.

```dax
Executive Financial Insight =
VAR Revenue = [Total Revenue]
VAR Budget = [Budget Revenue]
VAR Vari = [Revenue Variance]
VAR VariancePct = [Revenue Variance %]
VAR Profit = [Gross Profit]
VAR Margin = [Gross Margin %]

VAR BudgetMessage =
    SWITCH(
        TRUE(),
        ISBLANK(Budget) || Budget = 0,
            "Budget comparison unavailable.",
        Vari >= 0,
            "Revenue is "
                & FORMAT(ABS(Vari), "£#,##0,.0K")
                & " (" & FORMAT(ABS(VariancePct), "0.0%")
                & ") above budget.",
        "Revenue is "
            & FORMAT(ABS(Vari), "£#,##0,.0K")
            & " (" & FORMAT(ABS(VariancePct), "0.0%")
            & ") below budget."
    )

RETURN
IF(
    ISBLANK(Revenue),
    "No financial data for the selected filters.",
    BudgetMessage
        & UNICHAR(10)
        & "Gross profit: "
        & FORMAT(Profit, "£#,##0,,.00M")
        & " | Gross margin: "
        & FORMAT(Margin, "0.0%")
)
```

## Executive Operational Insight

Home table: 06. Executive Insights  
Filter-responsive narrative.

```dax
Executive Operational Insight =
VAR OnTime = [On-Time Completion %]
VAR LabourVariance = [Labour Hours Variance %]

VAR EligibleRegions =
    FILTER(
        ADDCOLUMNS(
            ALLSELECTED(dim_regions[region_name]),
            "@Rate", [On-Time Completion %],
            "@Jobs", [Completed Jobs with Due Date]
        ),
        [@Jobs] >= 100
            && NOT ISBLANK([@Rate])
    )

VAR WorstRegion =
    TOPN(
        1,
        EligibleRegions,
        [@Rate], ASC,
        dim_regions[region_name], ASC
    )

VAR RegionName =
    CONCATENATEX(
        WorstRegion,
        dim_regions[region_name]
    )

VAR RegionRate =
    MINX(WorstRegion, [@Rate])

VAR LabourMessage =
    SWITCH(
        TRUE(),
        ISBLANK(LabourVariance),
            "Labour efficiency data unavailable.",
        LabourVariance > 0,
            "Labour hours are "
                & FORMAT(LabourVariance, "0.0%")
                & " above plan.",
        LabourVariance < 0,
            "Labour hours are "
                & FORMAT(ABS(LabourVariance), "0.0%")
                & " below plan.",
        "Labour hours are on plan."
    )

RETURN
"On-time completion: "
    & FORMAT(OnTime, "0.0%")
    & UNICHAR(10)
    & IF(
        ISBLANK(RegionRate),
        "No eligible regional comparison.",
        "Lowest eligible region: "
            & RegionName
            & " ("
            & FORMAT(RegionRate, "0.0%")
            & ")"
    )
    & UNICHAR(10)
    & LabourMessage
```

## Executive Recommended Action

Home table: 06. Executive Insights  
Supporting measure; calculation and dependencies shown below.

```dax
Executive Recommended Action =
VAR WorstArea = [Highest Risk Service Region]
VAR OnTime = [On-Time Completion %]
VAR LabourVariance = [Labour Hours Variance %]
VAR RevenueVariance = [Revenue Variance %]

RETURN
SWITCH(
    TRUE(),

    NOT ISBLANK(RevenueVariance)
        && RevenueVariance < 0,
        "FINANCIAL PRIORITY: Revenue is below budget. "
            & "Review adverse service-region variances "
            & "and investigate contract profitability.",

    NOT ISBLANK(WorstArea)
        && NOT ISBLANK(OnTime)
        && OnTime < 0.85,
        "OPERATIONAL PRIORITY: Investigate "
            & WorstArea
            & ", the highest-risk eligible service-region "
            & "combination. Review late jobs, repeat visits "
            & "and labour utilisation.",

    NOT ISBLANK(LabourVariance)
        && LabourVariance > 0.05,
        "EFFICIENCY PRIORITY: Labour hours exceed plan "
            & "by more than 5%. Review scheduling and "
            & "resource allocation.",

    "Continue monitoring profitability, delivery "
        & "performance and operational risk."
)
```

## Operations Insight

Home table: 06. Executive Insights  
Filter-responsive narrative.

```dax
Operations Insight =
VAR OnTime = [On-Time Completion %]
VAR RepeatRate = [Repeat Visit Rate %]
VAR LabourVar = [Labour Hours Variance %]

-- Lowest-performing eligible region
VAR RegionTable =
    ADDCOLUMNS(
        ALLSELECTED(dim_regions[region_name]),
        "@OnTime", [On-Time Completion %],
        "@Jobs", [Jobs Completed]
    )

VAR WorstRegion =
    TOPN(
        1,
        FILTER(
            RegionTable,
            [@Jobs] >= 100
                && NOT ISBLANK([@OnTime])
        ),
        [@OnTime], ASC,
        dim_regions[region_name], ASC
    )

VAR RegionName =
    CONCATENATEX(
        WorstRegion,
        dim_regions[region_name]
    )

VAR RegionRate =
    MAXX(WorstRegion, [@OnTime])

-- Highest labour variance by service
VAR ServiceTable =
    ADDCOLUMNS(
        ALLSELECTED(dim_services[service_name]),
        "@Labour", [Labour Hours Variance %],
        "@Jobs", [Jobs Completed]
    )

VAR WorstService =
    TOPN(
        1,
        FILTER(
            ServiceTable,
            [@Jobs] >= 100
                && NOT ISBLANK([@Labour])
        ),
        [@Labour], DESC,
        dim_services[service_name], ASC
    )

VAR ServiceName =
    CONCATENATEX(
        WorstService,
        dim_services[service_name]
    )

VAR ServiceVariance =
    MAXX(WorstService, [@Labour])

-- Key operational exception
VAR ExceptionText =
    "KEY OPERATIONAL EXCEPTION"
    & UNICHAR(10)
    & IF(
        NOT ISBLANK(RegionName),
        RegionName
            & " has the lowest on-time rate ("
            & FORMAT(RegionRate, "0.0%")
            & "). ",
        ""
    )
    & IF(
        NOT ISBLANK(ServiceName),
        ServiceName
            & " has the highest labour overrun ("
            & FORMAT(ServiceVariance, "+0.0%;-0.0%")
            & "). ",
        ""
    )
    & "Repeat visits account for "
    & FORMAT(RepeatRate, "0.0%")
    & " of completed jobs."

-- Recommended action
VAR ActionText =
    "RECOMMENDED INVESTIGATION"
    & UNICHAR(10)
    & SWITCH(
        TRUE(),

        NOT ISBLANK(OnTime) && OnTime < 0.85,
        "Prioritise delivery reliability in "
            & COALESCE(RegionName, "underperforming regions")
            & ". Review scheduling, staffing and repeat visits.",

        NOT ISBLANK(LabourVar) && LabourVar > 0.05,
        "Investigate labour overruns in "
            & COALESCE(ServiceName, "high-variance services")
            & " and review resource utilisation.",

        NOT ISBLANK(RepeatRate) && RepeatRate > 0.08,
        "Investigate repeat visits to identify "
            & "potential service quality issues.",

        "Continue monitoring delivery performance, "
            & "repeat visits and labour efficiency."
    )

RETURN
IF(
    ISBLANK(OnTime),
    "No operational data for the selected filters.",
    ExceptionText
        & UNICHAR(10) & UNICHAR(10)
        & ActionText
)
```

## Contracts Insight

Home table: 06. Executive Insights  
Filter-responsive narrative.

```dax
Contracts Insight =
VAR Contracts = [Active Contracts]
VAR Revenue = [Total Revenue]
VAR Margin = [Gross Margin %]
VAR LowMargin = [Low Margin Contracts]

VAR Expiring = [Contracts Expiring in 90 Days]
VAR RenewalValue = [Renewal Value 90 Days]
VAR HighRisk = [High Risk Contracts]

VAR PortfolioText =
    "PORTFOLIO PERFORMANCE"
    & UNICHAR(10)
    & FORMAT(Contracts, "#,0")
    & " active contracts | Revenue: "
    & FORMAT(Revenue / 1000000, "£0.00")
    & "M | Gross margin: "
    & FORMAT(Margin, "0.0%")
    & " | Low-margin contracts: "
    & FORMAT(LowMargin, "#,0")

VAR RenewalText =
    "RENEWAL & RISK EXPOSURE"
    & UNICHAR(10)
    & FORMAT(Expiring, "#,0")
    & " contracts expire within 90 days, representing "
    & FORMAT(RenewalValue / 1000000, "£0.00")
    & "M in annual contract value. "
    & FORMAT(HighRisk, "#,0")
    & " contracts are classified as high risk."

VAR PriorityText =
    SWITCH(
        TRUE(),

        Expiring > 0 && HighRisk > 0,
            "Review upcoming renewals and high-risk contracts. "
            & "Check whether any high-risk contracts are also "
            & "approaching expiry.",

        HighRisk > 0,
            "Investigate high-risk contracts for margin "
            & "and delivery performance issues.",

        LowMargin > 0,
            "Review low-margin contracts for pricing "
            & "and cost-efficiency opportunities.",

        NOT ISBLANK(Margin) && Margin < 0.30,
            "Portfolio margin is below the 30% benchmark. "
            & "Review contract pricing and operating costs.",

        "Continue monitoring profitability, "
        & "renewals and operational performance."
    )

RETURN
PortfolioText
    & UNICHAR(10)
    & UNICHAR(10)
    & RenewalText
    & UNICHAR(10)
    & UNICHAR(10)
    & "MANAGEMENT PRIORITY"
    & UNICHAR(10)
    & PriorityText
```

## Financials Insight

Home table: 06. Executive Insights  
Filter-responsive narrative.

```dax
Financials Insight =
VAR CostVariance =
    DIVIDE(
        [Total Costs] - [Budget Cost],
        [Budget Cost]
    )

VAR ServiceTable =
    ADDCOLUMNS(
        ALLSELECTED(dim_services[service_name]),
        "@Margin", [Gross Margin %],
        "@Revenue", [Total Revenue]
    )

VAR LowestMarginService =
    TOPN(
        1,
        FILTER(
            ServiceTable,
            [@Revenue] >= 100000
                && NOT ISBLANK([@Margin])
        ),
        [@Margin], ASC,
        dim_services[service_name], ASC
    )

VAR ServiceName =
    CONCATENATEX(
        LowestMarginService,
        dim_services[service_name]
    )

VAR ServiceMargin =
    MAXX(
        LowestMarginService,
        [@Margin]
    )

VAR CostText =
    SWITCH(
        TRUE(),
        ISBLANK(CostVariance),
            "Cost budget comparison is unavailable.",
        CostVariance > 0,
            "Costs exceed budget by "
                & FORMAT(CostVariance, "0.0%") & ".",
        CostVariance < 0,
            "Costs are "
                & FORMAT(ABS(CostVariance), "0.0%")
                & " below budget.",
        "Costs are in line with budget."
    )

VAR MarginText =
    IF(
        NOT ISBLANK(ServiceName),
        " "
            & ServiceName
            & " has the lowest eligible service margin ("
            & FORMAT(ServiceMargin, "0.0%")
            & ").",
        ""
    )

VAR ExceptionText =
    "KEY FINANCIAL EXCEPTION"
        & UNICHAR(10)
        & CostText
        & MarginText

VAR ActionText =
    "MANAGEMENT PRIORITY"
        & UNICHAR(10)
        & SWITCH(
            TRUE(),

            NOT ISBLANK(CostVariance)
                && CostVariance > 0.05,
                "Investigate budget overruns and review "
                    & COALESCE(
                        ServiceName,
                        "lower-margin services"
                    )
                    & "'s labour, materials and subcontractor costs.",

            NOT ISBLANK(CostVariance)
                && CostVariance > 0,
                "Review expenditure against budget and "
                    & "identify opportunities to protect margins.",

            NOT ISBLANK(ServiceMargin)
                && ServiceMargin < 0.30,
                "Review pricing and cost efficiency in "
                    & ServiceName & ".",

            "Maintain cost discipline and monitor "
                & "service-level profitability."
        )

RETURN
IF(
    ISBLANK([Total Revenue]),
    "No financial data for the selected filters.",
    ExceptionText
        & UNICHAR(10) & UNICHAR(10)
        & ActionText
)
```
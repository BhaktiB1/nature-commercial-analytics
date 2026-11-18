let
  Source = Csv.Document(File.Contents("C:\Portfolio\Nature\Data\qa_contract_month_reconciliation.csv"), [Delimiter = ",", Columns = 18, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"contract_id", type text}, {"month", type date}, {"budgeted_jobs", Int64.Type}, {"budgeted_labour_hours", type number}, {"budgeted_cost_gbp", type number}, {"budgeted_revenue_gbp", type number}, {"actual_jobs", Int64.Type}, {"actual_revenue_gbp", type number}, {"actual_cost_gbp", type number}, {"has_budget", Int64.Type}, {"budget_gp_gbp", type number}, {"actual_gp_gbp", type number}, {"gp_variance_gbp", type number}, {"gp_effect_volume_gbp", type number}, {"gp_effect_revenue_rate_gbp", type number}, {"gp_effect_cost_rate_gbp", type number}, {"gp_effect_unbudgeted_gbp", type number}, {"bridge_check_gbp", Int64.Type}}, "en-US")
in
  #"Changed column type"

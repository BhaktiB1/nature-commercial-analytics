let
  Source = Csv.Document(File.Contents("C:\Portfolio\Nature\Data\fact_monthly_budgets.csv"), [Delimiter = ",", Columns = 6, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"contract_id", type text}, {"month", type date}, {"budgeted_jobs", Int64.Type}, {"budgeted_labour_hours", type number}, {"budgeted_cost_gbp", type number}, {"budgeted_revenue_gbp", type number}}, "en-US")
in
  #"Changed column type"

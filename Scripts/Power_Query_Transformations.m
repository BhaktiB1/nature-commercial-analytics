// Reference collection; queries are separate expressions.

// Query: 01. Financial measures
let
  Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i44FAA==", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type nullable text) meta [Serialized.Text = true]) in type table [Column1 = _t])
in
  Source

// Query: 02. Operational measures
let
  Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i44FAA==", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type nullable text) meta [Serialized.Text = true]) in type table [Column1 = _t])
in
  Source

// Query: dim_clients
let
  Source = Csv.Document(File.Contents("C:\Portfolio\Nature\Data\dim_clients.csv"), [Delimiter = ",", Columns = 3, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true])
in
  #"Promoted headers"

// Query: dim_contracts
let
  Source = Csv.Document(File.Contents("C:\Portfolio\Nature\Data\dim_contracts.csv"), [Delimiter = ",", Columns = 8, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"contract_id", type text}, {"client_id", type text}, {"region_id", type text}, {"service_id", type text}, {"contract_start", type date}, {"contract_end", type date}, {"annual_contract_value_gbp", Int64.Type}, {"contract_status", type text}}, "en-US")
in
  #"Changed column type"

// Query: dim_regions
let
  Source = Csv.Document(File.Contents("C:\Portfolio\Nature\Data\dim_regions.csv"), [Delimiter = ",", Columns = 2, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true])
in
  #"Promoted headers"

// Query: dim_services
let
  Source = Csv.Document(File.Contents("C:\Portfolio\Nature\Data\dim_services.csv"), [Delimiter = ",", Columns = 2, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true])
in
  #"Promoted headers"

// Query: fact_contract_events
let
  Source = Csv.Document(File.Contents("C:\Portfolio\Nature\Data\fact_contract_events.csv"), [Delimiter = ",", Columns = 4, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"event_id", type text}, {"contract_id", type text}, {"event_date", type date}, {"event_type", type text}}, "en-US")
in
  #"Changed column type"

// Query: fact_invoices
let
  Source = Csv.Document(File.Contents("C:\Portfolio\Nature\Data\fact_invoices.csv"), [Delimiter = ",", Columns = 6, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"invoice_id", type text}, {"job_id", type text}, {"contract_id", type text}, {"invoice_date", type date}, {"invoice_amount_gbp", type number}, {"invoice_status", type text}}, "en-US")
in
  #"Changed column type"

// Query: fact_jobs
let
  Source = Csv.Document(File.Contents("C:\Portfolio\Nature\Data\fact_jobs_enriched.csv"), [Delimiter = ",", Columns = 28, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"job_id", type text}, {"contract_id", type text}, {"scheduled_date", type date}, {"due_date", type date}, {"completed_date", type date}, {"job_status", type text}, {"job_type", type text}, {"job_priority", type text}, {"weather_disruption_flag", Int64.Type}, {"resource_shortage_flag", Int64.Type}, {"planned_labour_hours", type number}, {"actual_labour_hours", type number}, {"planned_job_cost_gbp", type number}, {"repeat_visit_flag", Int64.Type}, {"job_earned_revenue_gbp", type number}, {"invoice_count", Int64.Type}, {"first_invoice_date", type date}, {"has_invoice", Int64.Type}, {"has_cost", Int64.Type}, {"is_completed", Int64.Type}, {"is_on_time", Int64.Type}, {"days_late", Int64.Type}, {"labour_cost_gbp", type number}, {"overtime_cost_gbp", type number}, {"materials_cost_gbp", type number}, {"travel_cost_gbp", type number}, {"subcontractor_cost_gbp", type number}, {"total_actual_cost_gbp", type number}}, "en-US")
in
  #"Changed column type"

// Query: fact_monthly_budgets
let
  Source = Csv.Document(File.Contents("C:\Portfolio\Nature\Data\fact_monthly_budgets.csv"), [Delimiter = ",", Columns = 6, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"contract_id", type text}, {"month", type date}, {"budgeted_jobs", Int64.Type}, {"budgeted_labour_hours", type number}, {"budgeted_cost_gbp", type number}, {"budgeted_revenue_gbp", type number}}, "en-US")
in
  #"Changed column type"

// Query: qa_contract_month_reconciliation
let
  Source = Csv.Document(File.Contents("C:\Portfolio\Nature\Data\qa_contract_month_reconciliation.csv"), [Delimiter = ",", Columns = 18, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"contract_id", type text}, {"month", type date}, {"budgeted_jobs", Int64.Type}, {"budgeted_labour_hours", type number}, {"budgeted_cost_gbp", type number}, {"budgeted_revenue_gbp", type number}, {"actual_jobs", Int64.Type}, {"actual_revenue_gbp", type number}, {"actual_cost_gbp", type number}, {"has_budget", Int64.Type}, {"budget_gp_gbp", type number}, {"actual_gp_gbp", type number}, {"gp_variance_gbp", type number}, {"gp_effect_volume_gbp", type number}, {"gp_effect_revenue_rate_gbp", type number}, {"gp_effect_cost_rate_gbp", type number}, {"gp_effect_unbudgeted_gbp", type number}, {"bridge_check_gbp", Int64.Type}}, "en-US")
in
  #"Changed column type"

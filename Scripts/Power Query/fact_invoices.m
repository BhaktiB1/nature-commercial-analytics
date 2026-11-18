let
  Source = Csv.Document(File.Contents("C:\Portfolio\Nature\Data\fact_invoices.csv"), [Delimiter = ",", Columns = 6, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"invoice_id", type text}, {"job_id", type text}, {"contract_id", type text}, {"invoice_date", type date}, {"invoice_amount_gbp", type number}, {"invoice_status", type text}}, "en-US")
in
  #"Changed column type"

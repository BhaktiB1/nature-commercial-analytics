let
  Source = Csv.Document(File.Contents("C:\Portfolio\Nature\Data\dim_contracts.csv"), [Delimiter = ",", Columns = 8, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"contract_id", type text}, {"client_id", type text}, {"region_id", type text}, {"service_id", type text}, {"contract_start", type date}, {"contract_end", type date}, {"annual_contract_value_gbp", Int64.Type}, {"contract_status", type text}}, "en-US")
in
  #"Changed column type"

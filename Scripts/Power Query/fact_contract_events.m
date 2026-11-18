let
  Source = Csv.Document(File.Contents("C:\Portfolio\Nature\Data\fact_contract_events.csv"), [Delimiter = ",", Columns = 4, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"event_id", type text}, {"contract_id", type text}, {"event_date", type date}, {"event_type", type text}}, "en-US")
in
  #"Changed column type"

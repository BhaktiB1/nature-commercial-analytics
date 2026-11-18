let
  Source = Csv.Document(File.Contents("C:\Portfolio\Nature\Data\dim_services.csv"), [Delimiter = ",", Columns = 2, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true])
in
  #"Promoted headers"

json.array!(@helps) do |help|
  json.extract! help, :description
  json.url help_url(help, format: :json)
end

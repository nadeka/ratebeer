json.array!(@active_breweries.join(@retired_breweries) do |brewery|
  json.extract! brewery, :id, :name, :year, :beers, :active
  json.url brewery_url(brewery, format: :json)
end

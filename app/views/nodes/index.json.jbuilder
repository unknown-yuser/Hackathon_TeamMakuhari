json.array!(@nodes) do |node|
  json.extract! node, :node_id, :latitude, :longitude
  json.url node_url(node, format: :json)
end

json.array!(@nodes) do |node|
  json.extract! node, :id, :node_id, :latitude, :longitude
  json.url node_url(node, format: :json)
end

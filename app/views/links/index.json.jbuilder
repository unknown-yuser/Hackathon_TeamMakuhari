json.array!(@links) do |link|
  json.extract! link, :link_id, :src_node_id, :dst_node_id, :link_type, :width, :hill, :gap, :gap_latitude, :gap_longitude, :steps, :bus_stop, :bus_stop_latitude, :bus_stop_longitude, :blind_guide, :signals, :street_name, :length
  json.url link_url(link, format: :json)
end

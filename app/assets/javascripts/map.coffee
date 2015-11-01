hostname = 'https://hokoo.herokuapp.com'

innerProduct = (v0, v1) -> v0[0]*v1[0]+v0[1]*v1[1]
dist = (v0, v1) -> Math.sqrt((v0[0]-v1[0])**2 + (v0[1]-v1[1]) **2)

getDistance = (node0, node1, pos) ->

  v_targent = [node1[0]-node0[0], node1[1]-node0[1]]
  v_normal = [node1[1]-node0[1], node0[0]-node1[0]]
  v_normal_size = Math.sqrt((v_normal[0])**2 + (v_normal[1]) **2)

  if v_normal_size == 0
    v_normal = [0,0]
  else
    v_normal = v_normal.map (e) -> e/v_normal_size,

  p1 = [pos[0]-node0[0], pos[1]-node0[1]]
  p2 = [pos[0]-node1[0], pos[1]-node1[1]]

  if innerProduct(v_targent, p1) <= 0
    dist([0,0], p1)
  else if innerProduct(v_targent, p2) >= 0
    dist([0,0], p2)
  else
    Math.abs(innerProduct(v_normal, p1))

nearest_link = (links, latLng) ->
  pos = [latLng.lat(), latLng.lng()]
  min_dist = Number.POSITIVE_INFINITY
  n_link = links[0]
  links.map (link) ->
    nodes = link.node.map (node) ->
      return [node.latitude, node.longitude]
    t_dist = getDistance(nodes[0], nodes[1], pos)
    if t_dist < min_dist
      min_dist = t_dist
      n_link = link
  return n_link


retrieveNodes = (fnc) ->
  callback = (response) ->
    jobj = {}; response.map (node) -> jobj[node.node_id] = node
    fnc jobj

  $.ajax
    url: hostname + '/nodes.json'
    type: 'GET'
    datatype: 'json'
    success: callback
    error: (x, t, e) -> console.log e

retrieveLinks = (fnc) ->
  $.ajax
    url: hostename + '/links.json'
    type: 'GET'
    datatype: 'json'
    success: fnc
    error: (x, t, e) -> console.log e

calculate_center = (nodes) ->
  sum_lat = 0
  sum_lng = 0
  count = 0
  for nodeId of nodes
    sum_lat += nodes[nodeId].latitude
    sum_lng += nodes[nodeId].longitude
    count += 1
    console.log(nodes[nodeId])
  console.log(sum_lat)
  console.log(sum_lng)
  console.log(count)
  return { latitude: sum_lat/count, longitude: sum_lng/count }

make_LatLng = (node) ->
  new google.maps.LatLng(node.latitude, node.longitude)

click_handler = (links) -> (evt) ->
    link = nearest_link(links, evt.latLng)
    console.log link

retrieveNodes (nodes) ->
  retrieveLinks (links) ->
    console.log nodes
    console.log links
    center_lat_lng = calculate_center(nodes)
    center = new google.maps.LatLng(center_lat_lng.latitude, center_lat_lng.longitude)
    map = new google.maps.Map(document.getElementById('map'),
        zoom: 16,
        center: center,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      )
    links.map (link) ->
      line = new google.maps.Polyline(
        strokeWeight: 3,
        strokeOpacity: 0.8,
        strokeColor: 'green',
        path: [make_LatLng(link.node[0]), make_LatLng(link.node[1])]
      )
      line.setMap(map)
    google.maps.event.addListener(map, 'click', click_handler(links))

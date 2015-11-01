retrieveMulti = (fnc) ->
  callback = (response) ->
    jobj = {}; response.map (node) -> jobj[node.node_id] = node
    fnc jobj

  $.ajax
    url:"http://localhost:3000/nodes.json"
    type:'GET'
    datatype: 'json'
    success: callback
    error: (x, t, e) -> alert e

retrieveMulti (nodes) -> 
  #main operator
  console.log nodes

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


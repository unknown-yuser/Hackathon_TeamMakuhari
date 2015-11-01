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

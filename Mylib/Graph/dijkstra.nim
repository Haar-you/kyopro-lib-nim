import heapqueue, options

import Mylib/Graph/graph

proc dijkstra*[T](g: Graph[T], s: int): seq[Option[T]] {.noSideEffect.} =
  let N = g.len
  var dist = newSeq[Option[T]](N)
  var check = newSeq[bool](N)
  var heap = initHeapQueue[(T, int)]()

  dist[s] = some(T(0))
  heap.push((T(0), s))

  while heap.len != 0:
    let (d, i) = heap.pop

    if check[i]: continue
    check[i] = true

    for e in g[i]:
      if dist[e.to].isNone:
        dist[e.to] = some(d + e.cost)
        heap.push((dist[e.to].get, e.to))

      elif dist[i].get + e.cost < dist[e.to].get:
        dist[e.to] = some(dist[i].get + e.cost)
        heap.push((dist[e.to].get, e.to))

  return dist

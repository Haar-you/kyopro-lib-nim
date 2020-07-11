type
  Edge*[T] = object
    to*: int
    cost*: T
  
  Graph*[T] = seq[seq[Edge[T]]]

proc make*[T](t: typedesc[Graph[T]], size: int): Graph[T] {.noSideEffect.} =
  return Graph[T](newSeq[seq[Edge[T]]](size))

proc add_edge*[T](g: var Graph[T], s, t: int, c: T) = g[s].add(Edge[T](to: t, cost: c))

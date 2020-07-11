import sequtils
import Mylib/Graph/graph

type
  Rerooting*[T, U] = ref object
    N: int
    G: Graph[T]
    id: U
    merge: (U, U) -> U
    f: (U, Edge[T]) -> U
    g: (U, int) -> U
    dp: seq[seq[U]]

proc rooting[T, U](self: var Rerooting[T, U]; cur: int, par: int = -1) =
  for i, e in self.G[cur]:
    if e.to == par:
      swap(self.G[cur][i], self.G[cur][^1])
      break
  
  for e in self.G[cur]:
    if e.to != par: self.rooting(e.to, cur)

proc rec1[T, U](self: var Rerooting[T, U]; cur: int, par: int = -1): U =
  var acc = self.id

  for i, e in self.G[cur]:
    if e.to == par: continue
    self.dp[cur][i] = self.rec1(e.to, cur)
    acc = self.merge(acc, self.f(self.dp[cur][i], e))
  
  return self.g(acc, cur)

proc rec2[T, U](self: var Rerooting[T, U]; cur: int, par: int; value: U) =
  var l = self.G[cur].len

  if self.G[cur].len != 0 and self.G[cur][^1].to == par:
    self.dp[cur][^1] = value
    l -= 1

  var left = newSeqWith(l + 1, self.id)
  var right = newSeqWith(l + 1, self.id)

  for i in 0 ..< l - 1:
    let e = self.G[cur][i]
    left[i + 1] = self.merge(left[i], self.f(self.dp[cur][i], e))

  for i in (1 .. l - 1).toSeq.reversed:
    let e = self.G[cur][i]
    right[i - 1] = self.merge(right[i], self.f(self.dp[cur][i], e))

  for i in 0 ..< l:
    let e = self.G[cur][i]
    var v = self.merge(left[i], right[i])

    if par != -1:
      v = self.merge(v, self.f(value, self.G[cur][^1]))
      
    self.rec2(e.to, cur, self.g(v, cur))


proc run*[T, U](t: typedesc[Rerooting[T, U]]; G: Graph[T]; id: U; merge: (U, U) -> U; f: (U, Edge[T]) -> U; g: (U, int) -> U): seq[U] =
  let N = G.len
  var self = Rerooting[T, U](N: N, G: G, id: id, merge: merge, f: f, g: g, dp: newSeq[seq[U]](N))

  for i in 0 ..< N:
    self.dp[i] = newSeqWith[U](self.G[i].len, self.id)
  
  self.rooting(0)
  discard self.rec1(0)
  self.rec2(0, -1, id)

  var ret = newSeqWith(N, id)
  
  for i in 0 ..< N:
    for j in 0 ..< G[i].len:
      ret[i] = merge(ret[i], f(self.dp[i][j], G[i][j]))
    ret[i] = g(ret[i], i)

  return ret

import sequtils

type
  UnionFind* = object
    par: seq[int]
    size: seq[int]
    depth: seq[int]
    count: int

proc make*(t: typedesc[UnionFind]; n: int): UnionFind =
  return UnionFind(par: toSeq(0 ..< n), size: newSeqWith(n, 1), depth: newSeqWith(n, 1))

proc rootOf*(self: var UnionFind; i: int): int =
  if self.par[i] == i: return i
  self.par[i] = self.rootOf(self.par[i])
  return self.par[i]

proc isSame*(self: var UnionFind; i, j: int): bool =
  return self.rootOf(i) == self.rootOf(j)

proc merge*(self: var UnionFind; i, j: int): int {.discardable.} =
  let
    i = self.rootOf(i)
    j = self.rootOf(j)

  if i == j: return i
  else:
    self.count -= 1
    if self.depth[i] < self.depth[j]:
      self.par[i] = j
      self.size[j] += self.size[i]
      return j
    else:
      self.par[j] = i
      self.size[i] += self.size[j]
      if self.depth[i] == self.depth[j]: self.depth[i] += 1
      return i

proc sizeOf*(self: UnionFind; i: int): int = result = self.size[i]

proc countGroups*(self: UnionFind): int = result = self.count

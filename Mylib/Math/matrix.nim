import sequtils

type
  SquareMatrix*[T] = object
    N: int
    data: seq[seq[T]]

proc make*[T](t: typedesc[SquareMatrix[T]], N: int): SquareMatrix[T] {.noSideEffect.} =
  return SquareMatrix[T](N: N, data: newSeqWith(N, newSeqWith(N, 0.T)))

proc one*[T](t: typedesc[SquareMatrix[T]], N: int): SquareMatrix[T] {.noSideEffect.} =
  var ret = SquareMatrix[T].make(N)
  for i in 0 ..< N: ret.data[i][i] = 1.T
  return ret

proc init_with_seq*[T](self: var SquareMatrix[T], value: seq[seq[T]]) =
  let N = self.N
  for i in 0 ..< N:
    for j in 0 ..< N:
      self.data[i][j] = value[i][j]

proc `*`*[T](lhs, rhs: SquareMatrix[T]): SquareMatrix[T] {.noSideEffect.} =
  let N = lhs.N
  var ret = SquareMatrix[T].make(N)

  for i in 0 ..< N:
    for j in 0 ..< N:
      for k in 0 ..< N:
        ret.data[i][j] += lhs.data[i][k] * rhs.data[k][j]
        
  return ret

proc `^`*[T](self: SquareMatrix[T], p: int64): SquareMatrix[T] {.noSideEffect.} =
  let N = self.N
  var
    ret = SquareMatrix[T].one(N)
    a = self
    p = p

  while p > 0:
    if (p and 1) == 1: ret = ret * a
    a = a * a
    p = p div 2

  return ret

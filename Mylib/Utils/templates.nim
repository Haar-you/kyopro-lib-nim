import sequtils, strutils, sugar, algorithm, bitops, math

const LOCAL {.booldefine.} = false

template `max=`*(x, y) = x = max(x, y)
template `min=`*(x, y) = x = min(x, y)
template times*(n: int; body: untyped): untyped = (for _ in 0 ..< n: body)
proc `<-`*[T, U](a: var T, b: U): var T =
  a = b
  return a

template `<<`(a: untyped, b: int): untyped = (a shl b)
template `>>`(a: untyped, b: int): untyped = (a shr b)

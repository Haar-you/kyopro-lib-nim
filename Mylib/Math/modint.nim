type
  ModInt*[M: static[int]] = distinct int64

proc `+`*[M](lhs, rhs: ModInt[M]): ModInt[M] {.noSideEffect.} =
  var t = int64(lhs) + int64(rhs)
  if t >= M: t -= M
  return ModInt[M](t)

proc `+`*[M](lhs: ModInt[M], rhs: int64): ModInt[M] {.noSideEffect.} =
  return ModInt[M]((int64(lhs) + rhs mod M) mod M)

proc `-`*[M](lhs, rhs: ModInt[M]): ModInt[M] {.noSideEffect.} =
  var t = int64(lhs) - int64(rhs)
  if t < 0: t += M
  return ModInt[M](t)

proc `-`*[M](lhs: ModInt[M], rhs: int64): ModInt[M] {.noSideEffect.} =
  var t = int64(lhs) - rhs mod M
  if t < 0: t += M
  return ModInt[M](t)

proc `*`*[M](lhs, rhs: ModInt[M]): ModInt[M] {.noSideEffect.} = return ModInt[M]((int64(lhs) * int64(rhs)) mod M)
proc `*`*[M](lhs: ModInt[M], rhs: int64): ModInt[M] {.noSideEffect.} = return ModInt[M]((int64(lhs) * rhs mod M) mod M)

proc pow*[M](a: ModInt[M], p: int64): ModInt[M] {.noSideEffect.} =
  var
    ret = ModInt[M](1)
    a = a
    p = p

  while p > 0:
    if (p and 1) == 1: ret = ret * a
    a = a * a
    p = p shr 1

  return ret

proc inv*[M](a: ModInt[M]): ModInt[M] {.noSideEffect.} =
  var
    a: int64 = int64(a)
    b: int64 = M
    u: int64 = 1
    v: int64 = 0

  while b != 0:
    let t = a div b
    a -= t * b
    swap(a, b)
    u -= t * v
    swap(u, v)

  u = u mod M
  if u < 0: u += M

  return ModInt[M](u)

proc `/`*[M](lhs, rhs: ModInt[M]): ModInt[M] {.noSideEffect.} = return lhs * rhs.inv

proc frac*[M](x: typedesc[ModInt[M]], a: int64, b: int64): ModInt[M] {.noSideEffect.} = return ModInt[M](a) * ModInt[M](b).inv

proc `$`*[M](a: ModInt[M]): string {.noSideEffect.} = $(int64(a))
proc `+=`*[M](lhs: var ModInt[M], rhs: ModInt[M]) = lhs = lhs + rhs
proc `-=`*[M](lhs: var ModInt[M], rhs: ModInt[M]) = lhs = lhs - rhs
proc `*=`*[M](lhs: var ModInt[M], rhs: ModInt[M]) = lhs = lhs * rhs
proc `/=`*[M](lhs: var ModInt[M], rhs: ModInt[M]) = lhs = lhs / rhs

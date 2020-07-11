import sequtils
import Mylib/Math/Action/action

type
  LazySegmentTree*[T, U] = ref object
    size: int
    data: seq[T]
    lazy: seq[U]
    action: Action[T, U]


proc make*[T, U](t: typedesc[LazySegmentTree[T, U]]; size: int; action: Action[T, U]): LazySegmentTree[T, U] = 
  let size = size.nextPowerOfTwo * 2
  return LazySegmentTree[T, U](size: size, data: newSeqWith(size, action.e1), lazy: newSeqWith(size, action.e2), action: action)

proc propagate[T, U](self: var LazySegmentTree[T, U]; i: int) =
  if self.lazy[i] == self.action.e2: return
  if i < self.size div 2:
    self.lazy[i * 2 + 0] = self.action.g(self.lazy[i], self.lazy[i * 2 + 0])
    self.lazy[i * 2 + 1] = self.action.g(self.lazy[i], self.lazy[i * 2 + 1])

  let l = (self.size div 2) shr (31 - i.countLeadingZeroBits)
  self.data[i] = self.action.h(self.data[i], self.lazy[i], l)
  self.lazy[i] = self.action.e2

proc update[T, U](self: var LazySegmentTree[T, U]; i, l, r, s, t: int; value: U): T =
  self.propagate(i)
  if r <= s or t <= l: return self.data[i]
  elif s <= l and r <= t:
    self.lazy[i] = self.action.g(value, self.lazy[i])
    self.propagate(i)
    return self.data[i]

  self.data[i] = self.action.f(
    self.update(i * 2 + 0, l, (l + r) div 2, s, t, value),
    self.update(i * 2 + 1, (l + r) div 2, r, s, t, value)
  )
  return self.data[i]

proc update*[T, U](self: var LazySegmentTree[T, U]; l, r: int; value: U) =
  discard self.update(1, 0, self.size div 2, l, r, value)

proc get[T, U](self: var LazySegmentTree[T, U]; i, l, r, x, y: int): T =
  self.propagate(i)
  if r <= x or y <= l: return self.action.e1
  elif x <= l and r <= y: return self.data[i]
  return self.action.f(
    self.get(i * 2 + 0, l, (l + r) div 2, x, y),
    self.get(i * 2 + 1, (l + r) div 2, r, x, y)
  )

proc get*[T, U](self: var LazySegmentTree[T, U]; l, r: int): T = 
  self.get(1, 0, self.size div 2, l, r)

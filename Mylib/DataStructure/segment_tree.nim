import sugar
import math
import sequtils

import Mylib/Math/Monoid/monoid

type
  SegmentTree*[T] = object
    size: int
    data: seq[T]
    m: Monoid[T]

proc make*[T](t: typedesc[SegmentTree[T]], size: int, m: Monoid[T]): SegmentTree[T] {.noSideEffect.} =
  let size = size.nextPowerOfTwo * 2
  return SegmentTree[T](size: size, data: newSeqWith[T](size, m.e), m: m)

proc init_with_array*[T](self: var SegmentTree[T], value: openArray[T]) =
  let h = self.size div 2
  for i, x in value: self.data[i + h] = x
  for i in count_down(h - 1, 1):
    self.data[i] = self.m.f(self.data[i * 2], self.data[i * 2 + 1])

proc get*[T](self: SegmentTree[T], l: int, r: int): T =
  var ret_r, ret_l = self.m.e

  var l = l + self.size div 2
  var r = r + self.size div 2

  while l < r:
    if (r and 1) == 1:
      r -= 1
      ret_r = self.m.f(self.data[r], ret_r)
    if (l and 1) == 1:
      ret_l = self.m.f(ret_l, self.data[l])
      l += 1
    l = l div 2
    r = r div 2

  return self.m.f(ret_r, ret_l)

proc update*[T](self: var SegmentTree[T], i: int, value: T) =
  var i = i + self.size div 2
  self.data[i] = value
  while i > 1:
    i = i div 2
    self.data[i] = self.m.f(self.data[i * 2], self.data[i * 2 + 1])

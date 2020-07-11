import deques

type
  ConvexHullTrick*[T] = ref object
    ls: Deque[(T, T)]
    
proc make*[T](t: typedesc[ConvexHullTrick[T]]): ConvexHullTrick[T] = 
  return ConvexHullTrick[T](ls: initDeque[(T, T)]())

proc is_needless[T](a, b, c: (T, T)): bool =
  return (a[1] - b[1]) * (a[0] - c[0]) >= (a[1] - c[1]) * (a[0] - b[0])

proc add*[T](self: var ConvexHullTrick[T]; a, b: T) =
  if self.ls.len > 0:
    let l = self.ls.peekLast()

    if l[0] == a:
      if l[1] < b: return
      self.ls.popLast

  while self.ls.len >= 2 and is_needless((a, b), self.ls.peekLast, self.ls[^2]):
    self.ls.popLast

  self.ls.addLast((a, b))

proc apply[T](l: (T, T); x: T): T = result = l[0] * x + l[1]

proc query*[T](self: var ConvexHullTrick[T]; x: T): T =
  while self.ls.len >= 2 and apply(self.ls[0], x) > apply(self.ls[1], x):
    self.ls.popFirst

  return apply(self.ls[0], x)

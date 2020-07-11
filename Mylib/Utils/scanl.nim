import sugar

proc scanl*[T](s: openArray[T]; op: (T, T) -> T; e: T): seq[T] =
  var a = e
  var ret = @[e]

  for x in s:
    a = op(a, x)
    ret.add(a)

  return ret

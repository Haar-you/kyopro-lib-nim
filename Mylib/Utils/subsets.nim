iterator subsets(a: int): int =
  var t = a
  while true:
    yield t
    if t == 0: break
    t = (t - 1) and a

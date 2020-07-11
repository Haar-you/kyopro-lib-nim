type 
  FactorialTable*[T] = ref object
    N: int
    factorial: seq[T]
    inverse: seq[T]

proc make*[T](t: typedesc[FactorialTable[T]]; N: int): FactorialTable[T] =
  var factorial = newSeq[T](N + 1)
  var inverse = newSeq[T](N + 1)

  factorial[0] = 1.T
  for i in 1 .. N: factorial[i] = factorial[i - 1] * i.T
  
  inverse[N] = 1.T / factorial[N]
  for i in countdown(N - 1, 0): inverse[i] = inverse[i + 1] * (i + 1)

  return FactorialTable[T](factorial: factorial, inverse: inverse)

proc P*[T](self: FactorialTable[T]; n, k: int): T =
  if n < k or n < 0 or k < 0: return 0.T
  return self.factorial[n] * self.inverse[n - k]

proc C*[T](self: FactorialTable[T]; n, k: int): T =
  if n < k or n < 0 or k < 0: return 0.T
  return self.P(n, k) * self.inverse[k]

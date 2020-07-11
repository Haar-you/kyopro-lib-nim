import Mylib/Math/Action/action

proc max_add*[T, U](): Action[T, U] = 
  result = Action[T, U](
    e1: 0.T,
    e2: 0.U,
    f: proc (a, b: T): T = return max(a, b),
    g: proc (a, b: U): U = return a + b,
    h: proc (a: U, b: T; l: int): T = return a + b
  )

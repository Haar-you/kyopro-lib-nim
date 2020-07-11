type
  Action*[T, U] = ref object
    e1: T
    e2: U
    f: (T, T) -> T
    g: (U, U) -> U
    h: (U, T, int) -> T

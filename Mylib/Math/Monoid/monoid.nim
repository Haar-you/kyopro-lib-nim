import sugar

type
  Monoid*[T] = ref object
    e: T
    f: (T, T) -> T

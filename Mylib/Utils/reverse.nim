type Reverse*[T] = distinct T
proc `<`*[T](lhs, rhs: Reverse[T]): bool = return T(rhs) < T(lhs)
proc `$`*[T](val: Reverse[T]): string = return $T(val)

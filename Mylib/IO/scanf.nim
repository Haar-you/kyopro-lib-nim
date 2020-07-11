
proc scanf*(formatstr: cstring){.header: "<stdio.h>", importc: "scanf", varargs.}
proc nextInt*(): int32 = scanf("%d", addr result)
proc nextLong*(): int64 = scanf("%lld", addr result)
proc nextFloat*(): float64 = scanf("%lf", addr result)
proc getchar*(): char {.header: "<stdio.h>", importc: "getchar".}
proc nextChar*(): char =
  while true:
    let c = getchar()
    if c.ord >= 0x21 and c.ord <= 0x7e:
      result = c
      break

proc nextStr*(): string =
  var ok = false
  while true:
    let c = getchar()
    if c.ord >= 0x21 and c.ord <= 0x7e: ok = true
    elif ok: break

    if ok:
      result.add(c)
      

import times, strformat

template timer*(body) =
  let t = cpuTime()
  body
  let d = (cpuTime() - t) * 1000
  when LOCAL:
    echo "$1 ms" % $d

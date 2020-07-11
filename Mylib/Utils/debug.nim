import terminal

template dump(a) =
  when LOCAL:
    setForegroundColor(stdout, fgGreen, true)
    echo a
    setForegroundColor(stdout, fgDefault)

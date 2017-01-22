set text {}
foreach {line} [split [read [open {input.txt} r]] "\n"] {
  if {!($line eq {})} {
    append text "$line\n"
  }
}
puts [open output.txt w] $text
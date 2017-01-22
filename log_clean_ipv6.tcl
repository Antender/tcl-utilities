set text [split [read [set fid [open [lindex $argv 0] r]]] \n]
foreach line $text {
  if {[regexp {^([0-9]|[a-f])+:} $line]} {
    puts $line
  }
}
close $fid  

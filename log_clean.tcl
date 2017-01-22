set text [split [read [set fid [open [lindex $argv 0] r]]] \n]
foreach line $text {
  if {[regexp {/v1/time} $line] != 1} {
    puts [regsub -all {.\[[0-9]+m} $line {}]
  }
}
close $fid

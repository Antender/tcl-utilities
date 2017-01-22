proc  rndnums {saved} {
  if {[llength $saved]!=5} {
  puts "Saved: $saved"
  puts "Random:"
  for {set i 1} {$i<=(5-[llength $saved])} {incr i} {
    lappend random [set temp [expr entier(rand()*(6))+1]]
    puts -nonewline "   $i)$temp"
  } 
  puts {}
  puts "Save:"
  set flag true
  while {$flag} {
    set temp [gets stdin]
    set flag false
    foreach element $temp {
      if {(!([regexp {[1-5]} $element])) || (5-[llength $saved])<$element } {
         set flag true
      }
    }
  }
  foreach element $temp {
    lappend result [lindex $random [expr $element-1] ]
  }
  puts {}
  concat $saved $result
  } {set saved}
}
while {[puts continue? ; gets stdin] eq {}} {
  set temp [rndnums [rndnums [rndnums {} ]]]
  puts "Final result: $temp"
  set summ 0
  foreach element $temp {
     set summ [expr $summ+$element]
  }
 puts "Summ: $summ"
}

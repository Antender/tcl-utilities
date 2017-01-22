proc ! n {
	for {set i 1} {$i<=$n} {lappend fact $i;incr i} {}
	expr [join $fact *] 
} 
source random.tcl
proc HexIdent {} {
for {set x 0} {$x<32} {incr x} {append result [string map { 10 A 11 B 12 C 13 D 14 E 15 F} [[::simulation::random::prng_Discrete 15]]]}
return $result
}
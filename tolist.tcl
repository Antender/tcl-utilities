foreach row [string map {( \{ ) \}} [read stdin]] {lappend matr "<[join $row ,]>"}
puts "<[join $matr |]>"
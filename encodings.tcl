puts [open [lindex $argv 1] w] [encoding convertto [lindex $argv 3] [encoding convertfrom [lindex $argv 2] [read [open [lindex $argv 0] r]]]] 




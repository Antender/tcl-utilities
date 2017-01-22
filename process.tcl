foreach {fullfn} "[glob -path [lindex $argv 0]/ *.[lindex $argv 1]]" {
  puts "Processing ${fullfn}"
  set reg "{(.+)\.}[lindex $argv 1]\$"                        
  regexp $reg $fullfn _ shortfn
  try {exec de4dot.exe -f ${fullfn} -o ${shortfn}_deobf.[lindex $argv 1]}
}
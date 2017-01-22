set text [read [set fid [open [lindex $argv 0] r]]]
close $fid
set rows [lrange [regexp -all -inline {(?:<tr.*?>)(.*?)(?:</tr>)} $text] 1 end]
foreach {row dup} $rows {
  set data [lrange [regexp -all -inline {(?:<td.*?>)(.*?)(?:</td>)} $row] 1 end]
  set countryname [lrange [regexp -inline {(?:<span class="v-button-caption">)(.*?)(?:</span>)} [lindex $data 0]] 1 end]
  set twocode [lrange [regexp -inline {(?:<div.*?>)(.*?)(?:</div>)} [lindex $data 4]] 1 end]
  set threecode [lrange [regexp -inline {(?:<div.*?>)(.*?)(?:</div>)} [lindex $data 6]] 1 end]
  set numcode [lrange [regexp -inline {(?:<div.*?>)(.*?)(?:</div>)} [lindex $data 8]] 1 end]
  puts [string map [list \{ {} \} {}] $countryname],$twocode,$threecode,$numcode
}
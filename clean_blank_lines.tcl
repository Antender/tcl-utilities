set text [split [read [set fid [open codes.raw r]]] "\n"]
close $fid
foreach line $text {
    if {![regexp {[:blank:]} $line]} {puts "\{$line\}"}
}

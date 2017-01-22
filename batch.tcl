foreach filename [glob -directory {C:/Games/Mafia 2/pc/sds/cars} *.dae] {
  set filedir [string range [file tail $filename] 0 [string first . [file tail $filename]]-1]
  set fulldir "[file dirname $filename]/extracted/$filedir"
  if {![file exists $fulldir]} {
    file mkdir $fulldir
  }
  file copy $filename "$fulldir/[string range [file tail $filename] [string first . [file tail $filename]]+1 end]"
  file delete $filename
}
proc reencode {path from to} { 
  set files [glob -nocomplain -directory $path -type f *\.txt] 
  foreach file $files { 
  puts $file
	set fid [open $file r] 
	fconfigure $fid -encoding $from 
  set contents [read $fid] 
	close $fid 
	set fid [open $file w] 
	fconfigure $fid -encoding $to
	puts $fid $contents 
	close $fid 
  } 
  set dirs [glob -nocomplain -directory $path -type d *] 
  foreach dir $dirs { 
    reencode $dir $from $to
  } 
} 
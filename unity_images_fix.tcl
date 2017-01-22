proc recReplace {path oldStr newStr} {
foreach {file} [glob -directory $path -nocomplain -type f *.meta] {
    set contents [read [set fid [open $file r]]]
    close $fid
    puts [open $file w] [string map "$oldStr $newStr" $contents]
    close $fid
}
foreach {dir} [glob -directory $path -nocomplain -type d *] {
    recReplace $dir $oldStr $newStr
}
}

recReplace /Volumes/HDD/Projects/capture/Assets/Resources/Sprites/ {"textureFormat: -1"} {"textureFormat: -3"}
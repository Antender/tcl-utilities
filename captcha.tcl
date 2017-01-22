package require Tk
package require http
package require pixane
wm title . "Captcha"


set url "http://www.google.com/addurl/image?id=1253767880526713808&hl=ru"
set id [open capt.jpg w]
set tok [::http::geturl $url -channel $id -blocksize 4096]
::http::cleanup $tok
close $id


image create photo captcha
pixane create piximg -tkphoto captcha
pixane load piximg -file capt.jpg
label .l -image captcha -bd 1 -relief sunken
pack .l -side top -padx .5m -pady .5m

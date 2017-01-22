package require http
proc Get_Url {url} {
  set token [::http::geturl $url]
  set result [::http::data $token]
  ::http::cleanup $token
  return $result
}
set id 1132
set data [Get_Url "http://aow.heavengames.com/downloads/showfile.php?fileid=${id}#"]
regexp "(?:onclick=\"get_file\\(')(?:${id})(?:',')(.+?)(?:'\\))" $data result code
puts [open output.zip w] [Get_Url "http://aow.heavengames.com/downloads/getfile.php?id=${id}&dd=1&s=${code}"]

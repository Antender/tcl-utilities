set ids [split [read [set fid [open out.txt r]]] "\n"]
close $fid
puts {db.getCollection("gameprofiles").insert([}
set index 0
foreach {id} $ids {
    puts "\{
    \"_id\" : ObjectId(\"$id\"),
	\"updated\" : ISODate(\"2013-12-16T11:15:17.083Z\"),
	\"created\" : ISODate(\"2013-12-16T11:15:17.083Z\"),
	\"__v\" : 0\},"
    incr index
}
puts {])}
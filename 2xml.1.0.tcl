#!/usr/bin/tclsh
if {$argc==2} {
    #������� ������� ���� ��� ������ � ������
    if {[catch {set sourcefile [open [lindex $argv 0] r ] } errMsg ]} {puts $errMsg }   \
    elseif {[catch {set destfile [open [lindex $argv 1] w ] } errMsg ]} {puts $errMsg } \
    else {
    #������ ��������� xml, ��� ������ ��������, �������� ������
    puts $destfile {<?xml version="1.0" encoding="Windows-1251"?>}
    puts $destfile {<questionpack>}
    puts $destfile "\<title\>[gets $sourcefile]\<\/title\>"
    #�������� ��������� ���������
    set outputbuffer {<settings}
    if {[regexp -nocase {(������:)([0-9])+} [set parsebuffer [gets $sourcefile]] matchbuffer ]} \
    {regexp -nocase {([1-9])([0-9])*} $matchbuffer matchbuffer ; append outputbuffer " timer\=\"$matchbuffer\"" }
    puts $destfile "$outputbuffer \/>"
    #�������� ���� ������� ��������
    puts $destfile {<questions>}
    while {![eof $sourcefile]} \
    { switch -regexp [set parsebuffer [gets $sourcefile]]  \
    {(?i)([A])([(])(.)(.)+([)])}                                       \
    { #��������� ����� �
    puts $destfile {<question type="A">}
    regexp -nocase {([^(-)])([^(-)])+} $parsebuffer matchbuffer
    puts $destfile "\<title\>$matchbuffer\<\/title\>"
    while {[set parsebuffer [gets $sourcefile]]!={}}               \
    { #��������� ������� �� ������������
    switch -regexp $parsebuffer                          \
    {(?i)([R])([(])(.)(.)+([)])}                                       \
    {regexp -nocase {([^(-)])([^(-)])+} $parsebuffer matchbuffer
    puts $destfile "\<answer right=true\>$matchbuffer\<\/answer\>"} \
    {(?i)([W])([(])(.)(.)+([)])}                                       \
    {regexp -nocase {([^(-)])([^(-)])+} $parsebuffer matchbuffer
    puts $destfile "\<answer right=false\>$matchbuffer\<\/answer\>"} }
    puts $destfile {</question>} }                                     \
    {(?i)([B])([(])(.)(.)+([)])}                                       \
    { #��������� ����� B
    puts $destfile {<question type="B">}
    regexp -nocase {([^(-)])([^(-)])+} $parsebuffer matchbuffer
    puts $destfile "\<title\>$matchbuffer\<\/title\>"
    puts $destfile "\<rightanswer\>[gets $sourcefile]\<\/rightanswer\>"
    puts $destfile {</question>} }   \
    {(?i)([C])([(])(.)(.)+([)])}                                       \
    { #��������� ����� C
    puts $destfile {<question type="C">}
    regexp -nocase {([^(-)])([^(-)])+} $parsebuffer matchbuffer
    puts $destfile "\<title\>$matchbuffer\<\/title\>"
    puts $destfile {<rightanswer>}
    while {[set parsebuffer [gets $sourcefile]]!={}}               \
    {puts $destfile $parsebuffer }
    puts $destfile {</rightanswer>}
    puts $destfile {</question>}  } }
    #��������� �������� ����, �����, ������� Done!
    puts $destfile {</questions>}
    puts $destfile {</questionpack>}
    close $sourcefile
    close $destfile
    puts {Done!}	}
#������� ���������, ���� ������������ ���������� ���������� ���������� ������
} else {puts stdout {Command format: 2xml.tcl source.file destination.file}}

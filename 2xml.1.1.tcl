#!/usr/bin/tclsh
if {$argc==2} {
    #Пробуем открыть файл для чтения и записи
    if [catch {open [lindex $argv 0] r } sourcefile ] {puts stderr {Couldn't open file [$sourcefile] for reading} \
    elseif [catch {open [lindex $argv 1] w } destfile ] {puts stderr {Couldn't open file [$sourcefile] for reading} }\
    else {
    #Создаём заголовок xml, тег пакета вопросов, название пакета
    puts $destfile {<?xml version="1.0" encoding="UTF-8"?>}
    puts $destfile "<questionpack title=\"[gets $sourcefile]\">"
    #Пытаемся разобрать настройки
    set outputbuffer {<settings}
    if {[regexp -nocase {(Таймер:)([0-9])+} [set parsebuffer [gets $sourcefile]] matchbuffer ]} \
    {regexp -nocase {([1-9])([0-9])*} $matchbuffer matchbuffer ; append outputbuffer " timer\=\"$matchbuffer\"" }
    puts $destfile "$outputbuffer \/>"
    #Начинаем цикл разбора вопросов
    puts $destfile {<questions>}
    while {![eof $sourcefile]} \
    { switch -regexp [set parsebuffer [gets $sourcefile]]  \
    {(?i)([A])([(])(.)(.)+([)])}                                       \
    { #Разбираем часть А
    regexp -nocase {([^(-)])([^(-)])+} $parsebuffer matchbuffer
    puts $destfile "<question type=\"A\" title=\"$matchbuffer\">"
    while {[set parsebuffer [gets $sourcefile]]!={}}               \
    { #Разбираем пометку на правильность
    switch -regexp $parsebuffer                          \
    {(?i)([R])([(])(.)(.)+([)])}                                       \
    {regexp -nocase {([^(-)])([^(-)])+} $parsebuffer matchbuffer
    puts $destfile "\<answer right=\"true\"\>$matchbuffer\<\/answer\>"} \
    {(?i)([W])([(])(.)(.)+([)])}                                       \
    {regexp -nocase {([^(-)])([^(-)])+} $parsebuffer matchbuffer
    puts $destfile "\<answer right=\"false\"\>$matchbuffer\<\/answer\>"} }
    puts $destfile {</question>} }                                     \
    {(?i)([B])([(])(.)(.)+([)])}                                       \
    { #Разбираем часть B
    regexp -nocase {([^(-)])([^(-)])+} $parsebuffer matchbuffer
    puts $destfile "<question type=\"B\" title=\"$matchbuffer\">"
    puts $destfile "\<rightanswer\>[gets $sourcefile]\<\/rightanswer\>"
    puts $destfile {</question>} }   \
    {(?i)([C])([(])(.)(.)+([)])}                                       \
    { #Разбираем часть C
    regexp -nocase {([^(-)])([^(-)])+} $parsebuffer matchbuffer
    puts $destfile "<question type=\"C\" title=\"$matchbuffer\">"
    puts $destfile {<rightanswer>}
    while {[set parsebuffer [gets $sourcefile]]!={}}               \
    {puts $destfile $parsebuffer }
    puts $destfile {</rightanswer>}
    puts $destfile {</question>}  } }
    #Закрываем основные теги, файлы, выводим Done!
    puts $destfile {</questions>}
    puts $destfile {</questionpack>}
    close $sourcefile
    close $destfile
    puts {Done!}	}
#Выводим подсказку, если неправильное количество параметров коммандной строки
} else {puts stdout {Need options: source.file destination.file} }

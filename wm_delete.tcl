set ::changed false 
proc main_window_destroyed {} {
if {$::changed==true} {switch -- [tk_messageBox -type yesnocancel -message "Сохранить файл?"] {
	yes      {save_as;destroy .}
	no       {destroy .}
	cancel {}
	}
} else {destroy .}}
# Writes build info to apsim.xml

if {[catch {set msg [exec svn log -q -r BASE ../..]} emsg] } {
  puts $emsg
  set releaseNumber "r0"
} else {
  set msg [lindex [split $msg "\n"] 1]
  set releaseNumber [lindex [split $msg "|"] 0]
}

set buildTime [clock format [clock seconds] -format "%d-%b-%Y"]

set fp [open ../../ApsimTemplate.xml r]; set text [read -nonewline $fp]; close $fp

regsub -all -line "\<builddate\>.*\</builddate\>$" $text "\<builddate\>$buildTime\</builddate\>" text
regsub -all -line "\<buildnumber\>.*\</buildnumber\>$" $text "\<buildnumber\>$releaseNumber\</buildnumber\>" text

set fp [open ../../Apsim.xml w]
puts -nonewline $fp $text
close $fp

exit
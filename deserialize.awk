BEGIN { section=header }
/^X-ExtEditorR/ { section=exteditor }
!/^X-ExtEditorR/ { if (section == exteditor) { section=body } }
/<div class="moz-signature">/ {
  section=signature
  split($0, parts, "<div class=\"moz-signature\">")
  $0=""
  # print "body " parts[1]
  print parts[1] > body
  # print "signature <div class=\"moz-cite-prefix\">" parts[2]
  print "<div class=\"moz-cite-prefix\">" parts[2] > signature
}
/<div class="moz-cite-prefix">/ { 
  section=previous
  split($0, parts, "<div class=\"moz-cite-prefix\">")
  $0=""
  # print "signature " parts[1]
  print parts[1] > signature
  # print "previous <div class=\"moz-cite-prefix\">" parts[2]
  print "<div class=\"moz-cite-prefix\">" parts[2] > previous
}

{
  print $0 > section
}

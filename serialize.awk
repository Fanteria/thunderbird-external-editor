BEGIN { section="none" }
/^---$/ { if (section == "none") {
    section=header
    next
  } else {
    section=body
    next
  }
}

{
  print $0 > dir "/" section
  # print section " " $0
}

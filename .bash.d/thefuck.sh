#
# Programatically correct mistyped console commands
#
if command -v thefuck >/dev/null 2>&1 ; then
  eval "$(thefuck --alias)"
fi

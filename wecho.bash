#!/bin/bash

wecho() {
  [[ ! -v COLUMNS ]] && {
    declare -ig COLUMNS
    COLUMNS=${COLUMNS:-$(tput cols 2>/dev/null || echo '78')}
  }
  # initialise number of spaces to indent
  (($#)) || { echo; return 0; }
  local -i i4=$(($1*4))
  shift
  if ((i4)); then
    # indent
    echo "$@" | fmt -w $((COLUMNS-i4)) | sed "s/^/$(printf "%${i4}s")/"
  else
    # no indent (avoid doing unnecessary 'sed')
    echo "$@" | fmt -w $COLUMNS
  fi
}
declare -fx wecho

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  set -eu
  if (($# == 0)) || [[ " $* " == *' -h '* ]] || [[ " $* " == *' --help '* ]]; then
    wecho 0 "function: wecho"
    wecho 1 "desc:"
    wecho 2 "'echo' command wrapper for indenting and wordwrapping. All 'echo' options remain valid."
    wecho 1 "usage:"
    wecho 2 "wecho {indent_level} [{echo_opts...}] [{echo_args...}]"
    wecho 1 "desc:"
    wecho 2 "Uses 'fmt' to wordwrap 'echo'-ed text to COLUMNS width, then uses 'sed' to indent every line by {indent_level}*4 spaces. If COLUMNS is not defined, then 'tput' is used to calculate it's value."
    wecho 1 "depends:"
    wecho 2 "fmt sed [tput] [COLUMNS]"
    wecho 1 "eg:"
    wecho 2 "wecho 2 \"a really, really, ... ... long sentence or paragraphs.\""
    COLUMNS=256
    wecho 2 "COLUMNS=256; wecho 1 \"another ... really ... long ... hunk ... of ... text.\" # indent 4 spaces+wordwrap."
    exit 1
  fi
  declare -i indent
  indent=$(($1)) || { >&2 echo "Invalid width argument '$1'."; exec $0 --help; exit 1;}

	wecho "$@"
fi

#fin

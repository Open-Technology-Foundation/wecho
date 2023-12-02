function: wecho
desc:
        'echo' command wrapper for indenting and wordwrapping. All 'echo' options
        remain valid.
usage:
        wecho {indent_level} [{echo_opts...}] [{echo_args...}]
desc:
        Uses 'fmt' to wordwrap 'echo'-ed text to COLUMNS width, then uses 'sed' to
        indent every line by {indent_level}*4 spaces. If COLUMNS is not defined, then
        'tput' is used to calculate it's value.
depends:
        fmt sed [tput] [COLUMNS]
eg:
        wecho 2 "a really, really, ... ... long sentence or paragraphs."
        COLUMNS=256; wecho 1 "another ... really ... long ... hunk ... of ... text." # indent 4 spaces+wordwrap.

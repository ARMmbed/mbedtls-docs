#compdef ssl-opt.sh compat.sh
## Completion for tests/ssl-opt.sh and tests/compat.sh in Mbed TLS.

_compat_sh_set_values () {
  spec="$spec:$1: _values -s ' ' '$1' ${${line%'*}##*'}"
}

_ssl_opt_sh () {
  local line opt spec specs
  specs=()
  for line in "${(@M)${(@)${(@f)$(_call_program help $words[1] --help)}//$'\t'##/ }:# #-*}"; do
    line=${line## ##}
    opt=(${(s:|:)${line%%[= ]*}})
    spec=
    line=${line#"${line%%[= ]*}"}
    line=${line##[^ ]# ##}
    spec="[$line]${spec}"
    case $words[1]:t:r in
      compat)
        case $opt[1] in
          -V) _compat_sh_set_values 'Verification modes';;
          -e) spec="${spec}:Exclude matching ciphersuites (BRE):";;
          -f) spec="${spec}:Restrict to matching ciphersuites (BRE):";;
          -m) _compat_sh_set_values 'Protocol versions';;
          -p) _compat_sh_set_values 'Peers';;
          -t) _compat_sh_set_values 'Key exchange types';;
        esac;;
      ssl-opt)
        case $opt[1] in
          -e|-f) spec="${spec}:BRE:";;
          --port|--*-port) spec="${spec}:port number:";;
          --seed) spec="${spec}:seed:";;
        esac;;
    esac
    specs+=($^opt$spec)
  done
  _arguments : $specs
}

_ssl_opt_sh "%@"

# Local Variables:
# mode: sh
# sh-shell: zsh
# End:


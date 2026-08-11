extract() {
  (( $# )) || { echo "usage: extract <archive>..."; return 1 }

  for a in "$@"; do
    [[ -f $a ]] || { echo "extract: $a: no such file"; return 1 }

    case $a in
      # bsdtar sniffs the compression itself, so one branch covers gz/bz2/xz/zst
      *.tar|*.tar.*|*.tgz|*.tbz2|*.txz) tar xvf "$a" ;;
      *.zip|*.cbz|*.epub|*.jar)         unzip "$a" ;;
      *.gz)                             gunzip "$a" ;;
      *.bz2)                            bunzip2 "$a" ;;
      *.Z)                              uncompress "$a" ;;
      *) echo "extract: $a: unsupported format"; return 1 ;;
    esac
  done
}

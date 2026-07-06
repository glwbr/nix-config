extract() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: extract <file1> [file2] [...]"
    echo "Supported formats: zip, rar, tar, tar.gz, tar.bz2, tar.xz, 7z, gz, bz2, xz, Z, dmg, iso, etc."
    return 1
  fi

  for n in "$@"; do
    if [[ ! -f "$n" ]]; then
      echo "extract: '$n' - file does not exist"
      return 1
    fi

    case "$n" in
      *.tar.bz2|*.tbz2|*.tar.gz|*.tgz|*.tar.xz|*.txz|*.tar)
        tar xvf "$n"
        ;;
      *.bz2)
        bunzip2 "$n"
        ;;
      *.gz)
        gunzip "$n"
        ;;
      *.xz)
        unxz "$n"
        ;;
      *.lzma)
        unlzma "$n"
        ;;
      *.z)
        uncompress "$n"
        ;;
      *.rar|*.cbr)
        unrar x -ad "$n"
        ;;
      *.zip|*.cbz|*.epub)
        unzip "$n"
        ;;
      *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
        7z x "$n"
        ;;
      *.exe)
        cabextract "$n"
        ;;
      *.cpio)
        cpio -id < "$n"
        ;;
      *.ace|*.cba)
        unace x "$n"
        ;;
      *)
        echo "extract: '$n' - unknown archive format"
        return 1
        ;;
    esac
  done
}

# vim:ft=bash

#!/bin/bash

has() {
  command -v "$1" >/dev/null 2>&1 || return 1
}

error() {
  echo -e "\033[31m[$(date +'%Y-%m-%dT%H:%M:%S')]: ${*} \033[0m" >&2
}

log() {
  echo -e "\033[32m${*}\033[0m" >&2
}

warn() {
  echo -e "\033[33mWARNING: ${*}\033[0m"
}

handle_files() {
  local filename="$1"
  local font_dir="/usr/share/fonts/${filename}"

  if ! sh -c "mkdir -p '$filename' && tar --exclude='*Propo*' --exclude='*Oblique*' -xJf '$filename.tar.xz' -C '$filename'"; then
    error "Failed to extract $filename"
    return 1
  fi
  rm -vr "${filename}.tar.xz"
}

download_font() {
  local filename="$1"
  local url="https://github.com/${nf_source}/releases/download/${latest_release}/${filename}.tar.xz"
  local max_retries=2
  local retry_count=0
  
  log "Downloading $filename"
  
  while [ $retry_count -lt $max_retries ]; do
    if curl -L --fail --silent --show-error \
         --progress-bar \
         -o "${filename}.tar.xz" \
         "$url"; then
      handle_files "$filename"
      return 0
    fi
    
    retry_count=$((retry_count + 1))
    if [ $retry_count -lt $max_retries ]; then
      warn "Retry $retry_count of $max_retries for $filename"
      sleep 2
    fi
  done
  
  download_errors+=("$filename")
  error "Failed to download $filename after $max_retries attempts"
  return 1
}

main() {
  readonly fonts=('FiraCode' 'Meslo' 'SourceCodePro' 'UbuntuMono' 'JetBrainsMono')
  readonly nf_source='ryanoasis/nerd-fonts'
  
  ! has curl && error "Please install curl" && exit 1
  ! has unzip && error "Please install unzip" && exit 1
  
  if ! has jq; then
    readonly latest_release='v2.3.3'
    warn "jq not found, using ${latest_release}"
  else
    warn "Fetching latest release..."
    if ! latest_release=$(curl -sL "https://api.github.com/repos/${nf_source}/releases" | jq -r '.[0].tag_name'); then
      error "Failed to fetch latest release version"
      exit 1
    fi
    warn "Using ${latest_release}"
  fi
  
  mkdir -p ~/.local/share/fonts || {
    error "Failed to create fonts directory"
    exit 1
  }
  cd ~/.local/share/fonts || {
    error "Failed to change to fonts directory"
    exit 1
  }
  
  declare -a download_errors=()
  warn '*.tar.xz file will be removed after extraction'
  for filename in "${fonts[@]}"; do
    download_font "$filename"
  done
  
  if [ ${#download_errors[@]} -gt 0 ]; then
    error "Failed to download the following fonts: ${download_errors[*]}"
    warn "Font-cache won't be rebuilt please check the errors"
    exit 1
  else
    log "Rebuilding font cache with fc-cache..."
    if fc-cache -f; then
      log "Done!"
    else
      error "Failed to rebuild font cache"
      exit 1
    fi
  fi
}

main

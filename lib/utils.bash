#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/JohnnyMorganz/StyLua"
TOOL_NAME="stylua"
TOOL_TEST="stylua --version"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if stylua is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' \
    | LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" \
    | grep -o 'refs/tags/.*' | cut -d/ -f3- \
    | sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
  list_github_tags
}

download_release() {
  local version="$1"
  local filename="$2"
  local platform="$(get_platform)"
  if [ "${platform}" == "darwin" ]; then
    platform="macos"
  fi
  local arch="$(get_arch)"
  if [ "${arch}" == "arm64" ]; then
    arch="aarch64"
  fi

  if [ "${platform}" == "linux" ] && [ "${arch}" == "x86_64" ]; then
    local musl="$(grep musl /usr/bin/ldd)"
    if [ -n "${musl}" ]; then
      arch="${arch}-musl"
    fi
  fi

  local remote_filename="stylua-${platform}-${arch}.zip"
  if [[ ${version} < "0.13.0" ]]; then
    remote_filename="stylua-${version}-${platform}.zip"
  elif [[ ${version} < "2.0.0" ]]; then
    remote_filename="stylua-${platform}.zip"
  fi
  local url="$GH_REPO/releases/download/v${version}/${remote_filename}"

  echo "* Downloading $TOOL_NAME release $version..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    mkdir -p "$install_path"
    cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

    # TODO: Assert stylua executable exists.
    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    chmod +x "$install_path/bin/$tool_cmd"
    test -x "$install_path/bin/$tool_cmd" || fail "Expected $install_path/bin/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error occurred while installing $TOOL_NAME $version."
  )
}

get_platform() {
  uname | tr '[:upper:]' '[:lower:]'
}

get_arch() {
  uname -m
}

# Marza

A [NodeJS](https://nodejs.org) version manager that doesn't pollute your shell.

## Installation

Just download the `marza` script to somewhere on your `$PATH`, e.g.

```bash
mkdir -p ~/.local/bin
curl -sSLo ~/.local/bin/marza https://raw.githubusercontent.com/MelvDouc/marza/refs/heads/main/src/marza
chmod +x ~/.local/bin/marza
cat << 'EOF' >> ~/.bashrc
	export MARZA_HOME="$XDG_DATA_HOME/marza"
	PATH="$MARZA_HOME/bin:$PATH"
EOF
exec $SHELL
```

## Dependencies

- You need to have either `curl` or `wget` installed to download Node versions.
- You also need `gzip` or `xz` (a.k.a. `xz-utils` on Debian) for the script to extract tarballs.

`curl` and `gzip` / `xz` are probably already installed if you're using a regular distro but not if you're in a minimal environment like a container.

## Commands

### help

Prints a detailed help message.

### install

Download a NodeJS version. It'll be located in `$MARZA_HOME/versions/<major>.<minor>.<patch>/`.

### use

Set the current Node version to one that's installed. It's important that `$MARZA_HOME/versions/current/bin` be on your path as it contains the `node` and `npm` executables.

### remove

Alias: `rm`.

Remove an installed version.

### list

Alias: `ls`.

Get a list of locally installed versions. Run `marza ls remote` to view the versions available for download.

## clear-cache

Marza downloads and saves the index of NodeJS versions once a day when run. If you ran a marza command and a new NodeJS version was released later that day, it won't be listed by marza as marza will refer to its cache at `${XDG_CACHE_HOME:$HOME/.cache}/marza/index`. Clearing the cache will force marza to download the online index again.

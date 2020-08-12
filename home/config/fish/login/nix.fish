if test -d "$HOME/.nix-profile"
  set -x NIX_REMOTE daemon
  set NIX_LINK "$HOME/.nix-profile"

  # Set the default profile.
  if not [ -L "$NIX_LINK" ];
    echo "creating $NIX_LINK" >&2
    set -l _NIX_DEF_LINK /nix/var/nix/profiles/default
    /run/current-system/sw/bin/ln -s "$_NIX_DEF_LINK" "$NIX_LINK"
  end

  set PATH $NIX_LINK/bin $NIX_LINK/sbin $PATH
  set MANPATH $NIX_LINK/share/man $MANPATH

  # Append ~/.nix-defexpr/channels/nixpkgs to $NIX_PATH so that
  # <nixpkgs> paths work when the user has fetched the Nixpkgs
  # channel.

  set -l bare_channels $HOME/.nix-defexpr/channels
  for p in $NIX_PATH
    if test "$p" = "$bare_channels"
      set -e bare_channels
      break
    end
  end

  if test -n "$bare_channels"
    if test -n "$NIX_PATH"
      set NIX_PATH $bare_channels:$NIX_PATH
    else
      set NIX_PATH $bare_channels
    end
  end

  set SSL_CERT_FILE /etc/ssl/certs/ca-certificates.crt
end

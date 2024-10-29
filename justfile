nixosup:
  bash -c 'sudo nixos-rebuild switch --flake .#$HOSTNAME'

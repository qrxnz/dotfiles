{
  pkgs,
  config,
  ...
}: {
  users.users.qrxnz = {
    shell = pkgs.nushell;
  };
}

{
  pkgs,
  userame,
  ...
}: {
  virtualisation = {
    docker.enable = true;
  };

  users.groups.docker.members = ["${username}"];

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}

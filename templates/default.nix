{...}: {
  lib = {
    description = "Snowfall library template";
    path = ./lib;
  };
  module = {
    description = "Snowfall module template";
    path = ./module;
  };
  overlay = {
    description = "Snowfall overlay template";
    path = ./overlay;
  };
  system = {
    description = "Snowfall system template";
    path = ./system;
  };
}

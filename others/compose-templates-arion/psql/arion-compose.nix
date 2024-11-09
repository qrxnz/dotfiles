{
  project.name = "example";

  services.postgres = {
    service.image = "postgres:17";
    service.volumes = ["${toString ./.}/postgres-data:/var/lib/postgresql/data"];
    service.environment.POSTGRES_PASSWORD = "pass";

    service.ports = [
      "5432:5432" # host:container
    ];
  };
}

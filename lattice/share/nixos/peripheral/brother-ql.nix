{ inputs, ... }: {
  environment.systemPackages = [
    inputs.brother-ql.packages.default
  ];
}

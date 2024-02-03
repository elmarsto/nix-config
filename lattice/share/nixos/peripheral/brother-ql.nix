{ inputs, system, ... }: {
  environment.systemPackages = [
    # FIXME: hardwired architecture
    inputs.brother-ql.packages.x86_64-linux.default
  ];
}

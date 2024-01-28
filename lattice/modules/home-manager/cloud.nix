{ config, pkgs, ... }:
let
  guiPkgs = with pkgs; [
    #azuredatastudio
  ];
  termPkgs = with pkgs; [
    # awscli
    # azure-cli
    # azure-functions-core-tools
    # azure-storage-azcopy
    # click
    # cloudflared
    # drive
    # flannel
    # flyctl
    # gdrive
    # google-drive-ocamlfuse
    # k9s
    # kdash
    # kops
    # kube-linter
    # kubebuilder
    # kubectl
    # kubectl-gadget
    # kubectl-tree
    # kubeprompt
    # kubernetes
    # kubernetes-helm
    # kubescape
    # kubeshark
    # kubespy
    # kustomize
    # lens
    # minikube
    # rakkess
    # redis
    # redis-dump
    #redisinsight
    # skaffold
    # stern
    #vercel
  ];
in
{
  home.packages = if config.lattice.gui.enable then termPkgs ++ guiPkgs else termPkgs;
}

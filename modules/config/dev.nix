{ config, pkgs, lib, ... }:
{
  options = {
    dev.enable = 
      lib.mkEnableOption "enables dev";
  };
  config = lib.mkIf config.dev.enable {
    environment.systemPackages = [
    pkgs.git
    pkgs.gh
    pkgs.vscode
    pkgs.vim
    (pkgs.python312Full.withPackages(pypkgs: [
    pypkgs.peewee
    pypkgs.tkinter
    pypkgs.pygame
    pypkgs.numpy
    pypkgs.pandas
    pypkgs.matplotlib
    pypkgs.seaborn
    pypkgs.nltk
    pypkgs.ipykernel
    pypkgs.pip
    pypkgs.jupyter
    pypkgs.tensorflow
    ]))
    pkgs.python312Packages.scikit-learn
    pkgs.rustc
    pkgs.cargo
    pkgs.texliveFull
    pkgs.sqlitebrowser
    pkgs.proxychains
    pkgs.uv
    ];
  };
}

{ config, pkgs, lib, ... }:
{
  options = {
    dev.enable = 
      lib.mkEnableOption "enables dev";
  };
  config = lib.mkIf config.dev.enable {
    environment.sessionVariables = {
      LD_LIBRARY_PATH = ["${pkgs.gcc.cc.lib}/lib"];
    };
    environment.systemPackages = with pkgs;[
    git
    gh
    vscode
    (python312Full.withPackages(pypkgs: with pypkgs;[
    peewee
    tkinter
    pygame
    numpy
    pandas
    matplotlib
    seaborn
    nltk
    ipykernel
    pip
    jupyter
    tensorflow
    scikit-learn
    ]))
    rustc
    cargo
    texliveFull
    sqlitebrowser
    proxychains
    uv
    ];
    services.ollama = {
      enable = true;
      };
  };
}
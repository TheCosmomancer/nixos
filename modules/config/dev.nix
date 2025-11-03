{ config, pkgs, lib, ... }:
{
  options = {
    dev.enable = 
      lib.mkEnableOption "enables dev";
  };
  config = lib.mkIf config.dev.enable {
    nix.settings = {
      max-jobs = 1;
      cores = 2;
      keep-going = false;
    };
    environment.sessionVariables = {
      LD_LIBRARY_PATH = ["${pkgs.gcc.cc.lib}/lib"];};
    environment.systemPackages = with pkgs;[
    git
    lazygit
    gh
    vscode
    (python312.withPackages(pypkgs: with pypkgs;[
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
    pygobject3
    pydantic
    fastapi
    sqlalchemy
    uvicorn
    pynput
    faster-whisper
    pyaudio
    ]))
    gcc
    pkg-config
    portaudio
    zlib
    ruff
    rustc
    cargo
    rust-analyzer
    whisper-cpp
    beam27Packages.elixir
    # texliveFull
    # pandoc
    typst
    typstwriter
    dbgate
    ];
  };
}
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
    # environment.sessionVariables = {
    #   LD_LIBRARY_PATH = ["${pkgs.gcc.cc.lib}/lib"];};
    environment.systemPackages = with pkgs;[
    git
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
    python-multipart
    pynput
    faster-whisper
    pyaudio
    ]))
    ruff
    python312Packages.xonsh
    gcc
    pkg-config
    portaudio
    zlib
    rustc
    cargo
    rust-analyzer
    cmake
    libclang
    ffmpeg
    beam27Packages.elixir
    # texliveFull
    # pandoc
    typst
    dbgate
    virt-manager
    ];
    programs.nixvim = {
    enable = true;
    };
    virtualisation = {
      libvirtd.enable = true;
      # spiceUSBRedirection.enable = true;
      # qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
    };
  };
}
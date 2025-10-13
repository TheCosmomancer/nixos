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
      LD_LIBRARY_PATH = ["${pkgs.gcc.cc.lib}/lib"];
      GI_TYPELIB_PATH = "${pkgs.glib.out}/lib/girepository-1.0:${pkgs.gtk3}/lib/girepository-1.0:${pkgs.webkitgtk}/lib/girepository-1.0:${pkgs.gtk-layer-shell}/lib/girepository-1.0:${pkgs.pango.out}/lib/girepository-1.0:${pkgs.harfbuzz.out}/lib/girepository-1.0:${pkgs.gdk-pixbuf.out}/lib/girepository-1.0:${pkgs.atk.out}/lib/girepository-1.0:${pkgs.webkitgtk}/lib/girepository-1.0:${pkgs.gtk-layer-shell}/lib/girepository-1.0:${pkgs.pango.out}/lib/girepository-1.0:${pkgs.harfbuzz.out}/lib/girepository-1.0:${pkgs.gdk-pixbuf.out}/lib/girepository-1.0:${pkgs.libsoup.out}/lib/girepository-1.0";
    };
    environment.systemPackages = with pkgs;[
    git
    lazygit
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
    pygobject3
    pydantic
    fastapi
    sqlalchemy
    uvicorn
    pynput
    # speechrecognition
    pyaudio
    ]))
    gcc
    pkg-config
    portaudio
    zlib
    ruff
    rustc
    cargo
    texliveFull
    pandoc
    sqlitebrowser
    proxychains
    uv
    gtk3
    webkitgtk
    gtk-layer-shell
    gobject-introspection
    glib
    pango
    harfbuzz
    gdk-pixbuf
    atk
    libsoup
    ];
    services.ollama = {
    enable = true;
    # acceleration = "cuda";
    loadModels = ["smollm2:1.7b" "llama3.2:3b" "mistral:7b" "gemma:7b" "deepseek-coder:6.7b" "qwen3:8b" "qwen2.5-coder:7b"];
    };
    services.open-webui.enable = true;
  };
}
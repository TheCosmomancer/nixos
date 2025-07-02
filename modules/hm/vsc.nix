{ config, pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    # package = pkgs.vscodium;
    profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;
        userSettings = {
            "files.autoSave" = "onFocusChange";
            "editor.formatOnPaste" = true;
            "security.workspace.trust.untrustedFiles" = "open";
            "telemetry.telemetryLevel" = "off";
        };
        extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        ms-python.python
        ms-python.vscode-pylance
        esbenp.prettier-vscode
        jgclark.vscode-todo-highlight
        james-yu.latex-workshop
        mkhl.direnv
        rust-lang.rust-analyzer
        ms-toolsai.jupyter
        ];
    };
  };
}
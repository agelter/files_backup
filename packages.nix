pkgs: withGUI: with pkgs; [
] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
] ++ pkgs.lib.optionals withGUI [
]
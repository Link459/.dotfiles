    { pkgs ? import <nixpkgs> {} }:

with pkgs;
pkgs.mkShell {
  buildInputs = [
    gcc
    nodejs
    neovim
    tree-sitter
    rust-analyzer
    clang-tools
    (python39.withPackages (pp: with pp; [
      pynvim
    ]))
  ];
}

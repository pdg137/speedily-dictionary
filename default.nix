let
  # Change to this if you want to use your configured channel
  #  nixpkgs = <nixpkgs>;

  # nixos-24.11 from 2024-12-29:
  nixpkgs = fetchTarball {
    name = "nixpkgs";
    url = "https://github.com/NixOS/nixpkgs/archive/d49da4c0.tar.gz";
    sha256 = "02g0ivn1nd8kpzrfc4lpzjbrcixi3p8iysshnrdy46pnwnjmf1rj";
  };

  pkgs = import nixpkgs {};

  gemset = import ./build_gemset.nix pkgs {
    # If you update Gemfile.lock, you will need to revise this hash.
    hash = "sha256-tPE2g5Ab9IvsIMrLf0FKffVbihpQxwKdlBXi60x+Z6M=";
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
  };

  our_ruby_env = pkgs.bundlerEnv {
    name = "our_ruby_env";
    ruby = pkgs.ruby;

    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = gemset.outPath;
  };

in

  pkgs.stdenvNoCC.mkDerivation {
    name = "speedily-dictionary";
    dontUnpack = "true";
    buildInputs = [
      our_ruby_env
      pkgs.ruby
    ];

    DICT_AMERICAN_HUGE = "${pkgs.scowl}/share/dict/wamerican.90";
    DICT_BRITISH_HUGE = "${pkgs.scowl}/share/dict/wbritish.90";

    lib = ./lib;
    spec = ./spec;
    contrib = ./contrib;

    builder = builtins.toFile "builder.sh" ''
      source $stdenv/setup
      eval $shellHook

      cp -r $lib ./lib
      cp -r $spec ./spec
      cp -r $contrib ./contrib

      ruby lib/make_dictionary.rb > "$out"
      rspec
    '';
  }

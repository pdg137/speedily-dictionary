let
  # Change to this if you want to use your configured channel
  #  nixpkgs = <nixpkgs>;

  # nixos-25.11 from 2025-11-30:
  nixpkgs = fetchTarball {
    name = "nixpkgs";
    url = "https://github.com/NixOS/nixpkgs/archive/d542db7.tar.gz";
    sha256 = "0x6wjmpzxrrlmwwq8v3znpyr1qs5m1vf9bdgwwlq0lr5fl8l4v67";
  };

  pkgs = import nixpkgs {};

  gemset = import ./build_gemset.nix pkgs {
    # If you update Gemfile.lock, you will need to revise this hash.
    hash = "sha256-fFpdCrFeFzhX4AtIHLNogF4SZhTJckN6zXh0f8KNiKI=";
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

    BASE_DICTIONARIES = "${pkgs.scowl}/share/dict/wamerican.80 ${pkgs.scowl}/share/dict/wamerican.variants.60 ${pkgs.scowl}/share/dict/wamerican.acceptable.70 ${pkgs.scowl}/share/dict/wbritish.80 ${pkgs.scowl}/share/dict/wbritish.variants.60 ${pkgs.scowl}/share/dict/wbritish.acceptable.70";

    lib = ./lib;
    spec = ./spec;
    contrib = ./contrib;

    builder = builtins.toFile "builder.sh" ''
      source $stdenv/setup
      eval $shellHook

      cp -r $lib ./lib
      cp -r $spec ./spec
      cp -r $contrib ./contrib

      mkdir "$out"
      ruby lib/make_dictionary.rb > "$out/dictionary.txt"
      cat "$out/dictionary.txt" | tr '\n' ',' | sed 's/,$$//' > "$out/dictionary.csv"

      # for rspec
      ln -s $out ./output
      rspec
    '';
  }

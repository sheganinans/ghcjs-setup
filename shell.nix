{ }:
let this = import ./.;
    myEnv = platform: (builtins.getAttr platform this).ghcWithPackages (p: with p; [
      # Add Haskell packages to your environment here
    ]);
in this.nixpkgs.runCommand "shell" {
  buildCommand = ''
    echo "$propagatedBuildInputs $buildInputs $nativeBuildInputs $propagatedNativeBuildInputs" > $out
  '';
  buildInputs = [
    this.nixpkgs.nodejs
  ] ++ builtins.map myEnv this.platforms;
} ""

{ pkgs }:
{
  omen-fan = pkgs.fetchFromGitHub {
    owner = "alou-S";
    repo = "omen-fan";
    rev = "main";  # or the specific commit or tag you want to use
    sha256 = "0000000000000000000000000000000000000000000000000000000000000000";  # replace with the actual hash
  };
}
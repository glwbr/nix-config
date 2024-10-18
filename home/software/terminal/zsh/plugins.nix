pkgs: {
  plugins = [
    {
      name = "pure";
      src = pkgs.fetchFromGitHub {
        owner = "sindresorhus";
        repo = "pure";
        rev = "92b8e9057988566b37ff695e70e2e9bbeb7196c8";
        sha256 = "1q6pxa1lq21f9956v1684bgkfrkdfx4jy9n8gvffp0672agapcsd";
      };
    }
    {
      name = "fast-syntax-highlighting";
      src = pkgs.fetchFromGitHub {
        owner = "zdharma-continuum";
        repo = "fast-syntax-highlighting";
        rev = "cf318e06a9b7c9f2219d78f41b46fa6e06011fd9";
        sha256 = "1bmrb724vphw7y2gwn63rfssz3i8lp75ndjvlk5ns1g35ijzsma5";
      };
    }
    {
      name = "zsh-you-should-use";
      file = "you-should-use.plugin.zsh";
      src = pkgs.fetchFromGitHub {
        owner = "MichaelAquilina";
        repo = "zsh-you-should-use";
        rev = "f13d39a1ae84219e4ee14e77d31bb774c91f2fe3";
        sha256 = "1kb11rqhmsnv3939prb9f00c1giqy3200sjnhh7cxcfjcncq0y7v";
      };
    }
  ];
}

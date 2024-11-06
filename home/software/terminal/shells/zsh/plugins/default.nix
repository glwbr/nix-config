pkgs: {
  plugins = [
    # INFO: https://github.com/Aloxaf/fzf-tab/blob/b6e1b22458a131f835c6fe65bdb88eb45093d2d2/README.md?plain=1#L35
    {
      name = "fzf-tab";
      file = "fzf-tab.plugin.zsh";
      src = pkgs.fetchFromGitHub {
        owner = "Aloxaf";
        repo = "fzf-tab";
        rev = "b6e1b22458a131f835c6fe65bdb88eb45093d2d2";
        sha256 = "04mj0kfjai8yzgh0z7s7jqdckap7c1n9mssa9gpx7b5mlfjz63p0";
      };
    }
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

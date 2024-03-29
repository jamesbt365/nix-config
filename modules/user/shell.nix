{ configs, inputs, pkgs, lib, ... }: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$cmd_duration"
        "$line_break"
        "$character"
      ];
      username = {
        style_user = "bold #FF008E";
        };
      hostname = {
        ssh_only = true;
        format = "[$hostname](bold blue) ";
        disabled = false;
        };
      directory = {
        read_only = "";
        truncation_length = 3;
        truncation_symbol = "../";
        };
        cmd_duration = {
          style = "#50CB93";
        };
    };
  };
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
  };
}

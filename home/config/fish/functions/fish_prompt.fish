function fish_prompt
	set -l prompt_bg white

  # colors here are used to match the solarized dynamic-colors scheme
  set_color -b brblue
  set_color $prompt_bg
  echo -n (date '+ %H:%M:%S ')
  set_color -b $prompt_bg
  set_color brblue
  echo -n ⮀
  __fixed_width_number $CMD_SECONDS
  status_glyph
  set_color cyan
  if test (id -u) -eq 0;
    set_color red
  end
  echo -n (whoami)
  echo -n '@'(hostname)' '
  set_color blue
  partial_path
  set -l statusline (confit -c git_prompt -f statusline)
  test $status -lt 128; and echo -n " "(tput setaf 3)"⭠"(tput setaf 4)" "$statusline
  set_color -b $prompt_bg
  set_color brblue
  __git_issue_id__ " [%s]"
  echo -n ' '
  if test -n "$IN_NIX_SHELL"
    set shell_path (echo $out | sed 's#/outputs/out##')
    set expr (echo $shell_path | sed 's/[^-]*-\([^-]*\).*/\1/')
    set expr (basename $expr)

    if test -z $nix_file; or not test -e $nix_file
      set nix_file (realpath ($shell_path/flake.nix))
    end
    if not test -e $nix_file
      set nix_file (realpath ($shell_path/shell.nix))
    end

    set glyph ( lorri_glyph $shell_nix )

    if test -z $expr
      echo -n "<nix-shell $glyph>"
    else
      echo -n "[$expr $glyph]"
    end

  end
  term_reset
  set_color $prompt_bg
  direnv_ps1 ⮀
  term_reset
  echo -n ' '
end

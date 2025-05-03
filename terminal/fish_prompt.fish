  function fish_prompt
      set_color magenta
      echo -n (whoami)
      set_color normal
      echo -n ' '
      
      set_color blue
      echo -n (prompt_pwd)
      set_color normal
      
      # Git status
      if command -v git >/dev/null
          set -l git_branch (git branch 2>/dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
          if test -n "$git_branch"
              set_color green
              echo -n " ($git_branch)"
              set_color normal
          end
      end
      
      set_color yellow
      echo -n ' $ '
      set_color normal
  end
  
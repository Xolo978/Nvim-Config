  # Simple prompt for Neovim terminal
  if [ -n "$SIMPLE_PROMPT" ]; then
    autoload -Uz colors && colors
    PS1="%{$fg[magenta]%}%n%{$reset_color%} %{$fg[blue]%}%~%{$reset_color%} %{$fg[yellow]%}$ %{$reset_color%}"
    
    # Git status in prompt
    autoload -Uz vcs_info
    precmd() { vcs_info }
    zstyle ':vcs_info:git:*' formats ' %{$fg[green]%}(%b)%{$reset_color%}'
    PS1+='${vcs_info_msg_0_} '
    
    # Basic settings
    setopt auto_cd
    setopt interactive_comments
    
    # Keep command history
    HISTSIZE=10000
    SAVEHIST=10000
    HISTFILE=~/.zsh_history
  fi
  
# /etc/skel/.bashrc
git_branch() {
  branch=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)
  if [ ! -z "$branch" ]; then
    if [ -n "$(git status --porcelain)" ]; then
      color="31"  # Red for changes
    elif [ "$(git stash list)" ]; then
      color="33"  # Yellow for stashed changes
    else
      color="32"  # Green for a clean state
    fi
    echo -e "\\e[0;${color}m${branch}\\e[0m"  
  fi
}

PS1="\u <\w> <\$(git_branch)> "

export VISUAL=nvim
export EDITOR="$VISUAL"

# My scripts paths
export PATH="/home/genty/bash_scripts:$PATH"

# doas autocompletion
complete -F _root_command doas

source /usr/share/bash-completion/completions/fzf
source /usr/share/fzf/key-bindings.bash

eval "$(starship init bash)"
eval "$(zoxide init bash)"

# uv
export PATH="/home/genty/.local/bin:$PATH"

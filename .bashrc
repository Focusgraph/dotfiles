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

PS1="\t \u <\w> <\$(git_branch)> "

fastfetch

export ENABLE_HDR_WSI=1

# My scripts paths
export PATH="/home/genty/Sync/scripts:$PATH"
export PATH="/home/genty/Sync/scripts/backup:$PATH"

# Recommended HOME paths
export XDG_DATA_HOME="$HOME/.local/share:$XDG_DATA_HOME"
export XDG_CONFIG_HOME="$HOME/.config:$XDG_CONFIG_HOME"
export XDG_STATE_HOME="$HOME/.local/state:$XDG_STATE_HOME"
export XDG_CACHE_HOME="$HOME/.cache:$XDG_CACHE_HOME"

#export HISTFILE="${XDG_STATE_HOME}"/bash/history
export CARGO_HOME="$XDG_DATA_HOME"/cargo

# doas autocompletion
complete -F _root_command doas

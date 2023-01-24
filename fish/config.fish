if status is-interactive
    # Commands to run in interactive sessions can go here
end

source $HOME/.profile

# Common programs
abbr -a -- vi nvim

# File exploring
abbr -a -- l 'tree -L 1 -a'
abbr -a -- ll 'tree -L 2 -a'

# Git (loaded from completions/git.fish)

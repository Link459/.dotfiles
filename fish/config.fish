set fish_greeting

alias vim=nvim

alias add='git add .'
alias commit='git commit -m'
alias push='git push'
alias branch='git branch'
alias checkout='git checkout'

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/link459/.nix-profile/lib"
export EDITOR=nvim
#export PATH=$PATH:~/.cargo/bin/
fish_add_path ~/.cargo/bin/

if status is-interactive
    # Commands to run in interactive sessions can go here
end

bind \cf '~/.dotfiles/scripts/tmux-sessionizer'

starship init fish | source

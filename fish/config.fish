set fish_greeting

alias vim=nvim

alias add='git add .'
alias commit='git commit -m'
alias push='git push'
alias branch='git branch'
alias checkout='git checkout'

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/link459/.nix-profile/lib"

if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias cat='bat --paging=never'
alias ls='eza'

bind \cf '~/.dotfiles/scripts/tmux-sessionizer'

colorscript -r
starship init fish | source
zoxide init fish --cmd cd | source

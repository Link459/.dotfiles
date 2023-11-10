set fish_greeting

alias vim=nvim

alias add='git add .'
alias commit='git commit -m'
alias push='git push'
alias branch='git branch'
alias checkout='git checkout'

if status is-interactive
    # Commands to run in interactive sessions can go here
end

bind \cf '~/.dotfiles/scripts/tmux-sessionizer'

colorscript -r
starship init fish | source
direnv hook fish | source

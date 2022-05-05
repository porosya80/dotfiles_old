# Theming section  
autoload -U compinit colors zcalc
compinit -d
colors

#export PATH=~/.local/bin:~/.bin:~/.local/lib:$PATH

if [[ ! -f ~/.zpm/zpm.zsh ]]; then
  git clone --recursive https://github.com/zpm-zsh/zpm ~/.zpm
fi
source ~/.zpm/zpm.zsh

zpm load @omz
zpm load @omz/z
zpm load @omz/zsh-autosuggestions
zpm load @omz/zsh-syntax-highlighting
zpm load @omz/zsh-completions
zpm load djui/alias-tips
  
  
export TERM=xterm-256color
export PIPENV_VERBOSITY=-1
export EDITOR='vim'

# Save history so we get auto suggestions
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE
# Options
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.
setopt inc_append_history                                       # save commands are added to the history immediately, otherwise only when shell exits.
setopt histignorespace                                          # Don't save commands that start with space
setopt auto_cd # cd by typing directory name if it's not a command
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt share_history # share history between different instances
#setopt correct_all # autocorrect commands
# Improve autocompletion style
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
WORDCHARS=${WORDCHARS//\/[&.;]} 


if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi
## Keybindings section
#
bindkey -e
bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                     # End key
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
bindkey '^[[5~' history-beginning-search-backward               # Page up key
bindkey '^[[6~' history-beginning-search-forward                # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                                     #
bindkey '^[Od' backward-word                                    #
bindkey '^[[1;5D' backward-word                                 #
bindkey '^[[1;5C' forward-word                                  #
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                                             # Shift+tab undo last action




# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-R

# File and Dir colors for ls and other outputs
export LS_OPTIONS='--color=auto'
eval "$(dircolors -b)"
alias ls='ls $LS_OPTIONS'

#  eval `dircolors /home/porosya/.dir_colors/dircolors'
# Example aliases
alias zshconfig="vim ~/.zshrc"
alias vimconfig="vim ~/.vimrc"
alias i3config="vim ~/.i3/config" 
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias ta="tmux attach -t"
alias ts="tmux new-session -s"
alias tl="tmux list-sessions"

alias djsh='python manage.py shell_plus --ipython' 
alias djm="python3 manage.py"
alias djs="python3 manage.py runserver"
# ls, the common ones I use a lot shortened for rapid fire usage

alias l='ls -lFh --color=auto'     #size,show type,human readable
alias ls='ls --color=auto'
alias la='ls -lAFh --color=auto'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh --color=auto'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh --color=auto'   #long list,sorted by date,show type,human readable
alias ll='ls -l --color=auto'      #long list
alias ldot='ls -ld .* --color=auto'
alias lS='ls -1FSsh --color=auto'
alias lart='ls -1Fcart --color=auto'
alias d='dirs -v | head -10'
alias md='mkdir -p'
alias df='df -h'
alias du='du -h -d 2'
alias lrt='ls -1Fcrt --color=auto'

eval "$(starship init zsh)"

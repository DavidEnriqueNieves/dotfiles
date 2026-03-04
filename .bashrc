# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Color definitions
COLOR_RESET="\[\033[0m\]"
COLOR_USER_HOST="\[\033[1;32m\]"
COLOR_PATH="\[\033[1;34m\]"

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PATH="/home/david/.local/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/Downloads/blender-3.4.1-linux-x64:$PATH"
export PATH="/usr/local/texlive/2025/bin/x86_64-linux/:$PATH"
export MANPATH="/usr/local/texlive/2025/texmf-dist/doc/man:$MANPATH"
export INFOPATH="/usr/local/texlive/2025/texmf-dist/doc/info:$INFOPATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# set -o vi

set show-mode-in-prompt on
set vi-cmd-mode-string "\1\e[2 q\2cmd"
set vi-ins-mode-string "\1\e[6 q\2ins"

export PATH="$HOME/bin:$PATH"

bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

alias dfls='/usr/bin/git --git-dir=/home/david/.cfg/ --work-tree=/home/david'
. "$HOME/.cargo/env"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/david/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/david/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/david/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/david/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export NOTES_DIR=~/Documents/Notes     
alias notes='export date_str=$(date +%Y-%m-%d) && mkdir -p $NOTES_DIR/$date_str && cd $NOTES_DIR/$date_str && nvim $NOTES_DIR/$date_str/$date_str.md '

function timer_now {
    date +%s%N
}

function timer_start {
    timer_start=${timer_start:-$(timer_now)}
}

function timer_stop {
    local delta_us=$((($(timer_now) - $timer_start) / 1000))
    local us=$((delta_us % 1000))
    local ms=$(((delta_us / 1000) % 1000))
    local s=$(((delta_us / 1000000) % 60))
    local m=$(((delta_us / 60000000) % 60))
    local h=$((delta_us / 3600000000))
    # Goal: always show around 3 digits of accuracy
    if ((h > 0)); then timer_show=${h}h${m}m
    elif ((m > 0)); then timer_show=${m}m${s}s
    elif ((s >= 10)); then timer_show=${s}.$((ms / 100))s
    elif ((s > 0)); then timer_show=${s}.$(printf %03d $ms)s
    elif ((ms >= 100)); then timer_show=${ms}ms
    elif ((ms > 0)); then timer_show=${ms}.$((us / 100))ms
    else timer_show=${us}us
    fi
    unset timer_start
}


set_prompt () {
    Last_Command=$? # Must come first!
    Blue='\[\e[01;34m\]'
    White='\[\e[01;37m\]'
    Red='\[\e[01;31m\]'
    Green='\[\e[01;32m\]'
    Reset='\[\e[00m\]'
    FancyX='\342\234\227'
    Checkmark='\342\234\223'
    # Host-specific colors (256-color foreground)
    C_OPTIMUS="\[\033[38;5;202m\]"     # vivid orange
    C_AI_PANTHER="\[\033[38;5;39m\]"   # electric cyan-blue
    C_COCES="\[\033[38;5;178m\]"       # muted amber
    C_NOCTUA="\[\033[38;5;60m\]"       # deep indigo
    C_ORPHEUSASUS="\[\033[38;5;135m\]" # orchid / mythic purple
    C_USER_SOFT_BLUE="\[\033[38;5;110m\]"   # soft steel-blue

    declare -A colorDict=(["optimus"]=$C_OPTIMUS ["ai-panther.fit.edu"]=$C_AI_PANTHER ["coces"]=$C_COCES ["noctua"]=$C_NOCTUA ["orpheusasus"]=$C_ORPHEUSASUS)

    # Add a bright white exit status for the last command
    PS1="$White\$? "
    # If it was successful, print a green check mark. Otherwise, print
    # a red X.
    if [[ $Last_Command == 0 ]]; then
        PS1+="$Green$Checkmark$Reset "
    else
        PS1+="$Red$FancyX$Reset "
    fi

    # Add the ellapsed time and current date
    timer_stop
    PS1+="($timer_show) \t "
    
    # If root, just print the host in red. Otherwise, print the current user
    # and host in green.

    host_color=$Green
    host="$(hostname)"
    host="$(hostname)"
    export HOST_COLOR_ANSI="${colorDict[$host]:-$Green}"

 	if  [[ -z $(compgen -c | grep -oP "^tmux"$) ]]; then

	export HOST_COLOR_NUM=$(echo $HOST_COLOR_ANSI  | grep -oP "(?<=;)(\d+)(?=m)")
	export TMUX_COL_STR="colour$HOST_COLOR_NUM"
	echo "TMUX COLOR NUM is $HOST_COLOR_NUM"
	echo "TMUX COLOR STRING IS $TMUX_COL_STR"
	export TMUX_BG=$TMUX_COL_STR
	export TMUX_FG=$TMUX_COL_STR
	export TMUX_ACCENT=$TMUX_COL_STR

	tmux set -g status-style "bg=${TMUX_BG}"
	tmux set -g pane-border-style "fg=${TMUX_ACCENT}"
	tmux set -g pane-active-border-style "fg=${TMUX_FG}"
	
	fi

    PS1+="$C_USER_SOFT_BLUE\\u$Reset@$HOST_COLOR_ANSI\\h$Reset"
    # Print the working directory and prompt marker in blue, and reset
    # the text color to the default.
    PS1+="$Blue\\w \\\$$Reset "
}


trap 'timer_start' DEBUG
PROMPT_COMMAND='set_prompt'
export GIT_EDITOR=vim

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
RESET_CODE="\e[0m"
ITALIC_CODE="\e[3m"
DIM_CODE="\033[2m"
border_str="$DIM_CODE$ITALIC_CODE───────────────────────────────────────────$RESET_CODE"
pree_fmt=$DIM_CODE$ITALIC_CODE
poste_fmt=$DIM_CODE$ITALIC_CODE

preexec() {

	date_str=$(date -u +"%Y-%m-%dT%H:%M:%S.%3NZ")
	echo -e "\n$pree_fmt S: - $date_str$RESET_CODE\n$border_str"; 

}
precmd() {
	date_str=$(date -u +"%Y-%m-%dT%H:%M:%S.%3NZ")
	echo -e "$border_str\n$poste_fmt E: - $date_str$RESET_CODE";

}


alias gpgaenc="gpg --symmetric -- cipher-algo AES256"


# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash


slast_compgens() {
    local cur startRange jobs

    cur="${COMP_WORDS[COMP_CWORD]}"

    startRange=$(date -d "1 month ago" --iso-8601=date)

    jobs=$(sacct --starttime="$startRange" 2>/dev/null \
        | awk '{print $1}' \
        | grep -oE '^[0-9]+$')

    COMPREPLY=($(compgen -W "$jobs" -- "$cur"))
}


slast_help() {
cat << 'END' 
Usage: 
  slast [JOBID] 

Description:
  Opens the stdout file of a recent Slurm job using 'less'.

  If JOBID is omitted, the most recent job ID from 'sacct' is used.

Arguments:
  JOBID     Numeric Slurm job ID to inspect.

Options:
  -h, --help    Show this help message and exit.

Behavior:
  - Searches jobs from the past month.
  - Resolves the StdOut path via 'scontrol show job'.
  - Opens the output file with 'less'.

Examples:
  slast
      Opens the most recent job's stdout.

  slast 123456
      Opens stdout for job 123456.
END
}


 slast () {                                                                                                                                           

	    case "$1" in
		-h|--help)
		    slast_help
		    return 0
		    ;;
	    esac
                                                                                
         lastJobId=$(sacct | awk '{print $1}' | tail -n 1 | grep -oP "^\d+")    
         if [[ -z $1 ]]; then                                                   
                 selJobid="$lastJobId"                                          
         else                                                                   
                 selJobid="$1"                                                  
         fi                                                                     
                                                                                
         startRange=$(date -d "1 month ago" --iso-8601=date)                    
         lastJobs=$(sacct --starttime=$startRange  | awk '{print $1}' | grep -oP "^\d+$")
                                                                                
                                                                                
         outPath=$(scontrol show job $selJobid | grep -oP "(?<=StdOut=).*")     
         less $outPath                                                          
 } 
complete -F slast_compgens slast

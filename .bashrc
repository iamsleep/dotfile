# set personal information in bashrc
# set command in vim mode
set -o vi

# If not running interactively, don't do anything
if [ -z "$PS1" ]; then
    return
fi

# aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# .titlebar
if [ -f ~/.titlebar ]; then
    . ~/.titlebar
fi

# per-user custom comands go here...
export PATH=/home/y/bin:$HOME/local/bin:/home/y/bin32:/home/y/bin64:/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/bin:/usr/X11R6/bin:/home/mysql/bin
export EDITOR="vim"


# set terminal in 256-color
set xterm-256color


if [[ `uname -a | grep -c Linux` -ne 0 ]]
then
    IS_LINUX=1;
else
    IS_LINUX=0;
fi

if (( $IS_LINUX == 0 ))
then
    res=`which gnuls 2> /dev/null`
    if [ -z $res ]
    then # no gnuls
        alias ls='ls -GF'
        if [ ${BASH_VERSINFO[1]} = "04" ]
        then
            #export LSCOLORS=6x5x2x3x2x464301060203
            export LSCOLORS=gxgx2x3x2x464301060203
        else
            DIR=hx
            SYM_LINK=gx
            SOCKET=Fx
            PIPE=dx
            EXE=Ex
            BLOCK_SP=Dx
            CHAR_SP=Dx
            EXE_SUID=hb
            EXE_GUID=ad
            DIR_STICKY=Ex
            DIR_WO_STICKY=Ex
            export LSCOLORS="$DIR$SYM_LINK$SOCKET$PIPE$EXE$BLOCK_SP$CHAR_SP$EXE_SUID$EXE_GUID$DIR_STICKY$DIR_WO_STICKY"
        fi
    else # got gnuls
        alias ls='gnuls --color=auto'
    fi
else
    LS_COLORS='no=00:fi=38;5;117:di=38;5;218:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;110:*.cmd=01;84:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=38;5;134:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:';
    export LS_COLORS
    alias ls='ls --color=auto'
fi

#------------------------------------------------
# db settings
#------------------------------------------------
billing_oracle()
{
    export ORACLE_SID=btest
    export NLS_LANG=AMERICAN_AMERICA.WE8ISO8859P1
}

c2c_oracle()
{
    export ORACLE_SID=c2c
    export NLS_LANG=AMERICAN_AMERICA.UTF8
}

show_ora_param()
{
    echo "== ORACLE env variable settings =="
    echo "  ORACLE_HOME=$ORACLE_HOME"
    echo "  TNS_ADMIN=$TNS_ADMIN"
    echo "  ORACLE_SID=$ORACLE_SID"
    echo "  NLS_LANG=$NLS_LANG"
    echo "  NLS_DATE_FORMAT=$NLS_DATE_FORMAT"
}


#---------------------------------------------------------------------
# CVS
#---------------------------------------------------------------------
export CVSROOT=cashbox.billing.corp.tpc.yahoo.com:/CVSROOT
export CVS_RSH=/usr/bin/ssh

#---------------------------------------------------------------------
# SVN
#---------------------------------------------------------------------
export SVNROOT=svn+ssh://cashbox.billing.corp.tpc.yahoo.com/SVNROOT/psi/branches
export SVN_SSH=/usr/local/bin/yssh

export AUC_SVNROOT=svn+ssh://svn.corp.yahoo.com/yahoo/auctions/platform/

#---------------------------------------------------------------------
# YINST SETTINGS
#---------------------------------------------------------------------
export YINST_DIST=
export ROOT=/home/y

# test if in yroot
if [ x"$YROOT_NAME" != "x" ]; then
	YROOT=":$YROOT_NAME"
fi

# prompt setting
hostname=`hostname`;
myhost=${hostname%.yahoo.com}

# 2012 12/11
# {{{ not use
#prompt="\[\e[m\]\n\[\033[38;5;244m\][\[\033[38;5;189m\]\u\[\033[38;5;167m\]@\[\033[38;5;200m\]\H:\[\033[38;5;69m\]\w\[\033[38;5;147m\] \${SSH_TTY}:\[\033[38;5;190m\]+\j\[\033[38;5;244m\]${YROOT}\[\033[38;5;244m\]]\[\033[38;5;49m\]\[\033[38;5;190m\] \n>> \[\e[m\]"
# }}}
export PROMPT_COMMAND='echo -en "\n\033[m\033[38;5;244m[\033[38;5;2m"$(( `sed -n "s/MemFree:[\t ]\+\([0-9]\+\) kB/\1/p" /proc/meminfo`/1024))"\033[38;5;22m/"$((`sed -n "s/MemTotal:[\t ]\+\([0-9]\+\) kB/\1/Ip" /proc/meminfo`/1024 ))MB"\t\033[m\033[38;5;2m$(< /proc/loadavg)\033[m\033[38;5;244m]\n"'

# {{{ not use
#prompt="\[\033[38;5;223m\]\342\224\214\342\224\200\342\224\200\342\224\200\[\e[m\]\342\210\253\w\342\210\253\n\[\033[38;5;223m\]\342\224\234\342\224\200\[\e[m\]\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\e[m\]]\342\224\200\")\[\342\210\253\]$(if [[ ${EUID} == 0 ]]; then echo '\[\033[0;31m\]\h\[\e[m\]'; else echo '\[\033[38;5;135m\]\u\[\e[m\]@\[\033[38;5;110m\]\H\[\e[m\]'; fi)\[\e[m\]\[\342\210\253\342\224\200\342\210\253\]\[\033[38;5;222m\]\w\[\e[m\]\[\342\210\253\]$(if [[ x"$YROOT_NAME" != "x" ]]; then echo '\[\342\224\200\342\210\253\e[38;5;74m\]$YROOT_NAME\[\e[m\]\342\210\253'; fi) \n$(echo '\[\033[38;5;223m\]\342\224\224\342\224\200\342\224\200\342\224\200\342\237\262\[\e[m\]') \[\e[m\] "
#prompt="\[\033[38;5;223m\]\342\224\214\342\224\200\342\224\200\[\e[m\]\342\210\253\[\033[38;5;110m\]\w\[\e[m\]\342\210\253\n\[\033[38;5;223m\]\342\224\234\342\224\200\342\224\200\[\e[m\]\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\e[m\]]\342\224\200\")\[\342\210\253\]$(if [[ ${EUID} == 0 ]]; then echo '\[\033[0;31m\]\h\[\e[m\]'; else echo '\[\033[38;5;135m\]\u\[\e[m\]@\[\033[38;5;110m\]\H\[\e[m\]'; fi)\342\210\253\[\e[m\]$(if [[ x"$YROOT_NAME" != "x" ]]; then echo '\[\342\224\200\342\210\253\e[38;5;74m\]$YROOT_NAME\[\e[m\]\342\210\253'; fi) \n$(echo '\[\033[38;5;223m\]\342\224\224\342\224\200\342\224\200\342\237\262\[\e[m\]') \[\e[m\] "
# }}}

#
# ANSI Color
#
#    \e[ or \033[ : 代表顏色宣告的開始
#    x;ym : x,y 為顏色值
#    \e[m or \033[m : 顏色宣告結束
#
# ANSI 256 Color
#    如果要用到 ANSI 256 color, 可以先下載 colortest 了解想要的顏色編號.
#    \e[38;5; or \033[38;5; : 顏色宣告
#    xm : x 為顏色編號
#    \e[m or \033[m : 顏色宣告結束
#prompt="\[\033[38;5;223m\]\342\224\214\342\224\200\[\e[m\]\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\e[m\]]\342\224\200\")\[\342\210\253\]$(if [[ ${EUID} == 0 ]]; then echo '\[\033[0;31m\]\h\[\e[m\]'; else echo '\[\033[38;5;135m\]\u\[\e[m\]@\[\033[38;5;110m\]\H\[\e[m\]'; fi)\342\210\253\342\224\200\342\210\253\[\033[38;5;222m\]\w\[\e[m\]\342\210\253$(if [[ x"$YROOT_NAME" != "x" ]]; then echo '\[\342\224\200\342\210\253\[\033[38;5;74m\]$YROOT_NAME\[\e[m\]\342\210\253'; fi) \n$(echo '\[\033[38;5;223m\]\342\224\224\342\224\200\342\224\200\342\224\200\342\237\262\[\e[m\]')  "

prompt="\[\033[38;5;223m\]\342\224\214\342\224\200\[\e[m\]\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\e[m\]]\342\224\200\")\[\342\210\253\]$(if [[ ${EUID} == 0 ]]; then echo '\[\033[0;31m\]\h\[\e[m\]'; else echo '\[\033[38;5;135m\]\u\[\e[m\]@\[\033[38;5;110m\]\H\[\e[m\]'; fi)\342\210\253\342\224\200\342\210\253\[\033[38;5;222m\]\w\[\e[m\]\342\210\253$(if [[ x"$YROOT_NAME" != "x" ]]; then echo '\[\342\224\200\342\210\253\[\033[38;5;74m\]$YROOT_NAME\[\e[m\]\342\210\253'; fi) \n$(echo '\342\224\224\342\224\200\342\224\200\342\224\200\342\237\262')  "
case $TERM in
	xterm*)
		export PS1=$prompt
                eval `tset -e "^?" -sQI xterm-256color`

		# test if in gnu-screen
		if [ x"$WINDOW" != "x" ]; then
		    GNUSCREEN="\[\033k\h:\W\033\134\]"
		    export PS1="$GNUSCREEN$prompt"
		fi
		;;
	screen*)
                #GNUSCREEN="\[\033k\h\033\134\]"
                #SCREENTITLE='\[\ek\W\e\\\]'
		#export PS1="$GNUSCREEN$prompt"
		export PS1='\[\033k\033\\\]'$prompt
		;;
	linux)
		export PS1=$prompt
		;;
	*)
		export PS1="\u@\h:\w:\j\$ "
		;;
esac

#export TERMCAP="xterm-256color:Co#256:AB=\E[48;5;%dm:AF=\E[38;5;%dm:ti@:te@:tc=xterm-xfree86:"


#alias ssh host
alias screen='screen -U'
alias sl='screen -ls'
alias sr='screen -r'

man_color_1()
{
# colorful man page
export PAGER="`which less` -s"
export BROWSER="$PAGER"
export LESS_TERMCAP_mb=$'\E[38;5;167m'
export LESS_TERMCAP_md=$'\E[38;5;39m'
export LESS_TERMCAP_me=$'\E[38;5;231m'
export LESS_TERMCAP_se=$'\E[38;5;231m'
export LESS_TERMCAP_so=$'\E[38;5;167m'
export LESS_TERMCAP_ue=$'\E[38;5;231m'
export LESS_TERMCAP_us=$'\E[38;5;133m'

}

man_color_2()
{
# colorful man page
export PAGER="`which less` -s"
export BROWSER="$PAGER"

export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
}

# set default man color
man_color_1

# {{{ history

#Remove duplicate history command
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTIGNORE="pwd:ls:ls -ltr:ls -alrt:ls:ll:hist*:clear:q:exit:vim .bashrc:source*:svn up:k:fg:bg"
export HISTTIMEFORMAT='%F %T '
export HISTFILE=~/.myhistory

#Make sure all terminals save history
if [ X"" = X`lsb_release -a | awk '{print $2}' | grep "^6.4"` ]; then
#PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND "
PROMPT_COMMAND="history -a; history -r; $PROMPT_COMMAND "
else
PROMPT_COMMAND="history -a; history -r; $PROMPT_COMMAND "
fi

# }}}

# history using up and down key
bind '"\x1b\x5b\x41":history-search-backward'
bind '"\x1b\x5b\x42":history-search-forward'

# automatically correct mistyped directory names on cd
shopt -s cdspell

#将一个多行命令的所有行保存在同一个历史项中
shopt -s cmdhist
shopt -s checkwinsize

#Will only ignore directories that have something before the period.
export FIGNORE=.svn

# Add bash completion for ssh: it tries to complete the host to which you
# want to connect from the list of the ones contained in ~/.ssh/known_hosts
__ssh_known_hosts() {
    if [[ -f ~/.ssh/known_hosts ]]; then
        cut -d " " -f1 ~/.ssh/known_hosts | cut -d "," -f1
    fi
}
_ssh() {
    local cur known_hosts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    known_hosts="$(__ssh_known_hosts)"
    if [[ ! ${cur} == -* ]] ; then
        if [[ ${cur} == *@* ]] ; then
            COMPREPLY=( $(compgen -W "${known_hosts}" -P ${cur/@*/}@ -- ${cur/*@/}) )
        else
            COMPREPLY=( $(compgen -W "${known_hosts}" -- ${cur}) )
        fi
    fi
    return 0
}
complete -o bashdefault -o default -o nospace -F _ssh yssh 2>/dev/null || complete -o default -o nospace -F _ssh yssh
complete -o bashdefault -o default -o nospace -F _ssh yinst 2>/dev/null || complete -o default -o nospace -F _ssh yinst
complete -o bashdefault -o default -o nospace -F _ssh scp 2>/dev/null || complete -o default -o nospace -F _ssh scp

# delete bad commnad in history
PROMPT_COMMAND="mypromptcommand; $PROMPT_COMMAND"
function mypromptcommand {
local exit_status=$?
# If the exit status was 127, the command was not found. Let's remove it from history
local number=$(history 1| awk '{print $1}')
if [ -n "$number" ]; then
    if [ $exit_status -eq 127 ] && ([ -z $HISTLASTENTRY ] || [ $HISTLASTENTRY -lt $number ]); then
        history -d $number
    else
        HISTLASTENTRY=$number
    fi
fi
}

# change title
function title {
    echo -ne "\033]0;"$*"\007"
}

if [[ -z $INYROOT ]]; then
    if [[ 'AUC_RELEASE' == $YROOT_NAME ]]; then
    export INYROOT=true
    cd source/auctions.git; screen -d -R auc;
    fi

    if [[ 'PSI_RELEASE' == $YROOT_NAME ]]; then
    export INYROOT=true
    cd ~/source/ecpayment.git; screen -d -R psi;
    fi

    if [[ 'newauction' == $YROOT_NAME ]]; then
    export INYROOT=true
    cd ~/SVN/; screen -d -R auc;
    fi

fi

export SprintTicket="6911199"



# history log rotate
logrotate (){
    KEEP=3000
    BASH_HIST=~/.myhistory
    mkdir -p ~/historyback
    BACKUP_PATH=~/historyback/
    BACKUP=${BACKUP_PATH}myhistory.$(date +%F)

    if [ -s "$BASH_HIST" -a "$BASH_HIST" -nt "$BACKUP" ]; then
      # history file is newer then backup
      if [[ -f $BACKUP ]]; then
        # there is already a backup
        cp -f $BASH_HIST $BACKUP
      else
        # create new backup, leave last few commands and reinitialize
        mv -f $BASH_HIST $BACKUP
        tail -n$KEEP $BACKUP > $BASH_HIST
        history -r
      fi
    fi
}

logrotate




pushd . >/dev/null

# Find base of git directory
while [ ! -d .git ] && [ ! `pwd` = "/" ]; do cd ..; done

# Show various information about this git directory
if [ -d .git ]; then
  echo "== Remote URL: `git remote -v`"

  echo "== Remote Branches: "
  git branch -r
  echo

  echo "== Local Branches:"
  git branch
  echo

  echo "== Configuration (.git/config)"
  cat .git/config
  echo

  echo "== Most Recent Commit"
  git log --max-count=1
  echo

  echo "Type 'git log' for more commits, or 'git show' for full commit details."
else
  echo "Not a git repository."
fi

popd >/dev/null

export PATH=$PATH:/home/iamsleep/.rvm/bin/

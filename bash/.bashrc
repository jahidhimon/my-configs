# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

[ -f "/home/imon/.ghcup/env" ] && source "/home/imon/.ghcup/env" # ghcup-env
. "$HOME/.cargo/env"

source ~/scripts/bash_prompt.sh 

export EDITOR=runemacs
export GUI_EDITOR=runemacs

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# export NVIM_GTK_NO_HEADERBAR=1
# export NVIM_GTK_NO_WINDOW_DECORATION=1
export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*,build/*,.dart_tool/*,ios/*,android/*}"'

#menike mange hite, hutuhe nura hai gumyabi, abilevi, terie numbe nake, makene neha meya yabi, si bebi,
#ma, telanga ma dewete na, uru peme ke pete le na, tu anari monhari, suku mali numbe ta ma,

# source ~/.bash_profile
eval OPAM_SWITCH_PREFIX='/home/imon/.opam/4.12.0'; export OPAM_SWITCH_PREFIX; CAML_LD_LIBRARY_PATH='/home/imon/.opam/4.12.0/lib/stublibs:/home/imon/.opam/4.12.0/lib/ocaml/stublibs:/home/imon/.opam/4.12.0/lib/ocaml'; export CAML_LD_LIBRARY_PATH; OCAML_TOPLEVEL_PATH='/home/imon/.opam/4.12.0/lib/toplevel'; export OCAML_TOPLEVEL_PATH; PKG_CONFIG_PATH='/home/imon/.opam/4.12.0/lib/pkgconfig'; export PKG_CONFIG_PATH; MANPATH=':/home/imon/.opam/4.12.0/man'; export MANPATH; PATH='/home/imon/.opam/4.12.0/bin:/home/imon/.local/bin:/home/imon/bin:/usr/local/gradle/bin:/home/imon/.cargo/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/var/lib/snapd/snap/bin:/home/imon/.cabal/bin:/home/imon/.ghcup/bin:/home/imon/.fzf/bin:/home/imon/.cabal/bin:/home/imon/.ghcup/bin'; export PATH;

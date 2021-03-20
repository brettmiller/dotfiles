#!/usr/bin/bash
#
# https://github.com/tfmalt/bash-completion-virtualbox 
# Raw github file - https://raw.github.com/tfmalt/bash-completion-virtualbox/master/vboxmanage_completion.bash
# changed 'vboxmanage' to 'VBoxManage' so any called to the program run correctly - bm 2013-07-01


_VBoxManage_realopts() {
    echo $(VBoxManage|grep -i VBoxManage|cut -d' ' -f2|grep '\['|tr -s '[\[\|\]\n' ' ')
    echo " "
}

__VBoxManage_startvm() {
    RUNNING=$(VBoxManage list runningvms | cut -d' ' -f1 | tr -d '"')
    TOTAL=$(VBoxManage list vms | cut -d' ' -f1 | tr -d '"')

    AVAILABLE=""
    for VM in $TOTAL; do
	MATCH=0;
	for RUN in $RUNNING "x"; do
	    if [ "$VM" == "$RUN" ]; then
		MATCH=1
	    fi
	done
	(( $MATCH == 0 )) && AVAILABLE="$AVAILABLE $VM "
    done
    echo $AVAILABLE
}

__VBoxManage_list() {
    INPUT=$(VBoxManage list | tr -s '[\[\]\|\n]' ' ' | cut -d' ' -f4-)
    
    PRUNED=""
    if [ "$1" == "long" ]; then
	for WORD in $INPUT; do
	    [ "$WORD" == "-l" ] && continue;
	    [ "$WORD" == "--long" ] && continue;
	    
	    PRUNED="$PRUNED $WORD"
	done
    else 
	PRUNED=$INPUT
    fi

    echo $PRUNED
}


__VBoxManage_list_vms() {
    VMS=""
    if [ "x$1" == "x" ]; then
	SEPARATOR=" "
    else
	SEPARATOR=$1
    fi
    
    for VM in $(VBoxManage list vms | cut -d' ' -f1 | tr -d '"'); do
	[ "$VMS" != "" ] && VMS="${VMS}${SEPARATOR}"
	VMS="${VMS}${VM}"
    done

    echo $VMS
}

__VBoxManage_list_runningvms() {
    VMS=""
    if [ "$1" == "" ]; then
	SEPARATOR=" "
    else
	SEPARATOR=$1
    fi
    
    for VM in $(VBoxManage list runningvms | cut -d' ' -f1 | tr -d '"'); do
	[ "$VMS" != "" ] && VMS="${VMS}${SEPARATOR}"
	VMS="${VMS}${VM}"
    done

    echo $VMS

}

__VBoxManage_controlvm() {
    echo "pause resume reset poweroff savestate acpipowerbutton"
    echo "acpisleepbutton keyboardputscancode guestmemoryballoon"
    echo "gueststatisticsinterval usbattach usbdetach vrde vrdeport"
    echo "vrdeproperty vrdevideochannelquality setvideomodehint"
    echo "screenshotpng setcredentials teleport plugcpu unplugcpu"
    echo "cpuexecutioncap"

# setlinkstate<1-N> 
# nic<1-N> null|nat|bridged|intnet|hostonly|generic
#                                      [<devicename>] |
                          # nictrace<1-N> on|off
                          #   nictracefile<1-N> <filename>
                          #   nicproperty<1-N> name=[value]
                          #   natpf<1-N> [<rulename>],tcp|udp,[<hostip>],
                          #                 <hostport>,[<guestip>],<guestport>
                          #   natpf<1-N> delete <rulename>

}

__VBoxManage_default() {
    realopts=$(_VBoxManage_realopts)
    opts=$realopts$(VBoxManage | grep -i VBoxManage | cut -d' ' -f2 | grep -v '\[' | sort | uniq)
    pruned=""

    # echo ""
    # echo "DEBUG: cur: $cur, prev: $prev"
    # echo "DEBUG: default: |$p1|$p2|$p3|$p4|"
    case ${cur} in
 	-*)
	    echo $opts
 	    # COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
 	    return 0
 	    ;;
    esac;

    for WORD in $opts; do
	MATCH=0
	for OPT in ${COMP_WORDS[@]}; do
		    # opts=$(echo ${opts} | grep -v $OPT);
	    if [ "$OPT" == "$WORD" ]; then
		MATCH=1
		break;
	    fi
	    if [ "$OPT" == "-v" ] && [ "$WORD" == "--version" ]; then
		MATCH=1
		break;
	    fi
	    if [ "$OPT" == "--version" ] && [ "$WORD" == "-v" ]; then
		MATCH=1
		break;
	    fi
	    if [ "$OPT" == "-q" ] && [ "$WORD" == "--nologo" ]; then
		MATCH=1
		break;
	    fi
	    if [ "$OPT" == "--nologo" ] && [ "$WORD" == "-q" ]; then
		MATCH=1
		break;
	    fi
	done
	(( $MATCH == 1 )) && continue;
	pruned="$pruned $WORD"
	
    done
    
    # COMPREPLY=($(compgen -W "${pruned}" -- ${cur}))
    echo $pruned
    return 0
}

_VBoxManage() {
    # VBoxManage | grep -i VBoxManage | cut -d' ' -f2 | sort | uniq
    local cur p1 p2 p3 p4 opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # echo "cur: |$cur|"
    # echo "prev: |$prev|"

    # In case current is complete command
    case $cur in
	startvm|list|controlvm)	    
	    COMPREPLY=($(compgen -W "$cur "))
	    return 0
	    ;;
    esac

    case $prev in 
	-v|--version)
	    return 0
	    ;;

	-l|--long)
	    opts=$(__VBoxManage_list "long")
	    COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
	    return 0	    
	    ;;
	startvm|list)
	    opts=$(__VBoxManage_$prev)
	    COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
	    return 0	    
	    ;;	
	--type)
	    COMPREPLY=($(compgen -W "gui headless" -- ${cur}))
	    return 0
	    ;;
	gui|headless)
	    # Done. no more completion possible
	    return 0
	    ;;
	VBoxManage|-q|--nologo)
	    # echo "Got VBoxManage"
	    opts=$(__VBoxManage_default)
	    COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
	    return 0
	    ;;
	controlvm)
	    opts=$(__VBoxManage_list_vms)
	    COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
	    return 0
	    ;;
    esac

    for VM in $(__VBoxManage_list_vms); do
	if [ "$VM" == "$prev" ]; then
	    pprev=${COMP_WORDS[COMP_CWORD-2]}
	    # echo "previous: $pprev"
	    case $pprev in
		startvm)
 		    opts="--type"	    
		    COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
		    return 0
		    ;;
		controlvm)
		    opts=$(__VBoxManage_controlvm)
		    COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
		    return 0;
		    ;;
	    esac
	fi
    done

    # echo "Got to end withoug completion"
}
#complete -F _vboxmanage vboxmanage
complete -F _VBoxManage VBoxManage
complete -F _VBoxManage vboxmanage

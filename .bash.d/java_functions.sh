#!/usr/bin/env sh

### Java Environment Functions ###
# http://homepage.mac.com/shawnce/misc/java_functions_bashrc.txt
#
# 2014-02-10 -bm - edits to use /usr/libexec/java_home instead of JAVA_VERSION_DIRECTORY since 1.6 and 1.7 are in
#					different location in Mavricks
# 2014-08-19 - only run on macs moved alias here instead of separate file b/c they aren't useful on linux  

# only run on macs
if [ `uname -s` == "Darwin" ] ; then

# aliases to set java version (don't error if the version doesn't exist)
alias java6='export JAVA_HOME=`/usr/libexec/java_home -v1.6` && java -version' 
alias java7='export JAVA_HOME=`/usr/libexec/java_home -v1.7` && java -version' 
#alias java7='export JAVA_HOME=/Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home && java -version' 
alias java8='export JAVA_HOME=`/usr/libexec/java_home -v1.8` && java -version' 


JAVA_HOMECMD="/usr/libexec/java_home"
#JAVA_VERSIONS_DIRECTORY="/Library/Java/JavaVirtualMachines"
J_COMMANDS_SUBPATH="Commands"
J_BIN_SUBPATH="bin"
#J_HOME_SUBPATH="Home"

function availableJVMs()
{
	${JAVA_HOMECMD} -X | grep -A1 JVMVersion | grep string | cut -d\> -f2 | cut -d\< -f1 | cut -d. -f1-2 | tr "\n" ' ' && echo ""
}

function listJava()
{
	local jvms=$(availableJVMs)
		echo "Available JVMs: "$jvms

		echo "Current Java:"
		java -version
}

function setJava()
{
	local target_jvm=""
		local jvms=$(availableJVMs)

# Validate that the user requested an available JVM present on the system

		for jvm in $jvms ; do
			if [ "$jvm" == "$@" ]; then
				target_jvm=$@	
					fi
					done

					if [ "$target_jvm" == "" ]; then
						echo "Unsupported Java version requested"
							return;
	fi

		echo "Configuring Shell Environment for Java "$@

		echo "Unsetting current Java version"
		_unsetJava

# Generate the paths needed for the JVM requested
		local jcmd="$(${JAVA_HOMECMD} -v $1)/${J_BIN_SUBPATH}"
		local jhome="$(${JAVA_HOMECMD} -v $1)"

# We save the original path so we can toggle back if unset
		ORIGINAL_PATH="$PATH"
		PATH="$jcmd:${PATH}"

# We save the original JAVA_HOME so we can toggle back if unset
		ORIGINAL_JAVA_HOME="$JAVA_HOME"
		JAVA_HOME="$jhome"

# Update command prompt mode tag to note JVM setting
		CURRENT_MODE_STRING="J$@"

		echo "Current Java:"
		java -version
}

function _unsetJava()
{
	if [ "$CURRENT_MODE_STRING" != "" ]; then
		PATH="$ORIGINAL_PATH"
			JAVA_HOME="$ORIGINAL_JAVA_HOME"
			CURRENT_MODE_STRING=""
			fi
}

function unsetJava()
{
	echo "Configuring Shell Environment for default Java"
		_unsetJava

		echo "Current Java:"
		java -version
}

# List the functions this script creates
function javaFuncts()
{
	grep "function " ~/.bash.d/java_functions.sh | awk '/function/ && !/_/ {print substr($2, 0, length($2)-2)}'
}

fi

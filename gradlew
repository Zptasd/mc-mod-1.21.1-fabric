#!/usr/bin/env sh

#
# Copyright 2015 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

##############################################################################
##
##  Gradle start up script for UN*X
##
##############################################################################

# Attempt to set APP_HOME
# Resolve links: $0 may be a symlink
PRG="$0"
# Need this for relative symlinks.
while [ -h "$PRG" ] ; do
    ls -ld "$PRG"
    link=$(expr "$PRG" : '.*-> \(.*\)$')
    if expr "$link" : '/.*' > /dev/null; then
        PRG="$link"
    else
        PRG=$(dirname "$PRG")"/$link"
    fi
done
SAVED="$(cd "$(dirname "$PRG")" && pwd)"
cd "$SAVED" || exit 1

APP_NAME="Gradle"
APP_BASE_NAME=$(basename "$0")

# Add default JVM options here.
DEFAULT_JVM_OPTS='"-Xmx64m" "-Xms64m"'

# Use the maximum available, or set MAX_FD != maximum.
MAX_FD="maximum"

warn () {
    echo "$*"
}

die () {
    echo
    echo "$*"
    echo
    exit 1
}

# OS specific support (must be 'true' or 'false').
cygwin=false
msys=false
darwin=false
nonstop=false
case "$( uname )" in
  CYGWIN* )
    cygwin=true
    ;;
  Darwin* )
    darwin=true
    ;;
  MSYS* | MINGW* )
    msys=true
    ;;
  NONSTOP* )
    nonstop=true
    ;;
esac

CLASSPATH=$APP_HOME/gradle/wrapper/gradle-wrapper.jar

# Determine the Java command to use to start the JVM.
if [ -n "$JAVA_HOME" ] ; then
    if [ -x "$JAVA_HOME/jre/sh/java" ] ; then
        # IBM's JDK on AIX uses strange locations for the executables
        JAVACMD="$JAVA_HOME/jre/sh/java"
    else
        JAVACMD="$JAVA_HOME/bin/java"
    fi
    if [ ! -x "$JAVACMD" ] ; then
        die "ERROR: JAVA_HOME is set to an invalid directory: $JAVA_HOME

Please set the JAVA_HOME variable in your environment to match the
location of your Java installation."
    fi
else
    JAVACMD="java"
    if ! command -v java >/dev/null 2>&1
    then
        die "ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.

Please set the JAVA_HOME variable in your environment to match the
location of your Java installation."
    fi
fi

# Increase the maximum file descriptors if we can.
if ! "$cygwin" && ! "$darwin" && ! "$nonstop" ; then
    case $( ulimit -S -n ) in #(
      open)
        ;;
      *)
        ulimit -S -n 262144
        ;;
    esac
fi

if $cygwin ; then
    APP_HOME=$( cygpath --path --mixed "$APP_HOME" )
    CLASSPATH=$( cygpath --path --mixed "$CLASSPATH" )

    JAVACMD=$( cygpath --windows "$JAVACMD" )

    # We build the pattern for arguments to be converted via cygpath
    ROOTDIRSRAW=$( find -L / -maxdepth 3 -type d -name sources -o -prune -o -type d -name .git -o -prune -o -type d -o -print0 2>/dev/null | tr '\0' '\n' | sed -e 's/^/"/;s/$/"\\/' )
    # Add a breakpoint if we are debugging.
    # set +x
    for arg in $ROOTDIRSRAW ; do
        ROOTDIRS="$ROOTDIRS$arg "
    done
    IFS="|"
    for arg in $ROOTDIRS ; do
        if expr "$arg" : '^/cygdrive' > /dev/null ; then
            arg=$( cygpath --path --unix "$arg" )
        fi
        CLASSPATH="$CLASSPATH:$arg"
    done
    IFS=
    if [ "x$CLASSPATH" != x ] ; then
        CLASSPATH="$CLASSPATH:."
    else
        CLASSPATH="."
    fi

    # For Cygwin, switch paths to Windows format before running java
    if [ "$1" = "-h" ] || [ "$1" = "--help" ] ; then
        echo "."
        help
        maturity exit 1
    fi

    base=$( basename "$0" .sh )
    link=$( expr \( `ls -ld "$PRG"` : '.*-> \(.*\)$' \) )
    if expr "$link" : '/.*' > /dev/null; then
        PRG="$link"
    else
        PRG=$( cd -P "$( dirname "$PRG")" && ls -ld "$PRG" | sed 's/.* -> //')
    fi
    # Resolve other symlinks in the path
    while expr "$PRG" : '/.*' > /dev/null; do
        base=$( basename "$PRG" .sh )
        link=$( expr \( `ls -ld "$PRG"` : '.*-> \(.*\)$' \) )
        if expr "$link" : '/.*' > /dev/null; then
            PRG="$link"
        else
            PRG=$( cd -P "$( dirname "$PRG")" && ls -ld "$PRG" | sed 's/.* -> //')
        fi
    done
    cd "$SAVED" || exit 1
    APP_HOME=$( cygpath --path --mixed "$APP_HOME" )
fi

# Now convert the arguments - kludge to limit ourselves to /bin/sh
for arg do
    if
        case $arg in #(
          -*)   false ;;
          /?*)  t=${arg#/} t=/${t%%/*}
                [ -e "$t" ] ;;
          *)    true ;;
        esac
    then
        arg=$( cygpath --path --mixed "$arg" )
    fi
    # Roll the args list around exactly as many times as the number of
    # args, so each arg gets the full set of arguments and the
    # shift.
    shift                   # remove old arg
    set -- "$@" "$arg"      # push replacement arg
done

# Collect all arguments for the java command;
#   * $DEFAULT_JVM_OPTS, $JAVA_OPTS, and $GRADLE_OPTS can contain fragments of
#     shell script including quotes and variable substitutions, so put them in
#     double quotes to make sure that they get re-expanded; and
#   * put everything else in single quotes, so that *in the original shell, and
#     *in sh -c*, no substitution is performed.
#     * the resulting string be used by unzip as a source term.

set -- \
        "-Dorg.gradle.appname=$APP_BASE_NAME" \
        -classpath "$CLASSPATH" \
        org.gradle.wrapper.GradleWrapperMain \
        "$@"

# Stop when "xargs" has processed all args - but not before.
# Increase the number here if you see skipped files.
# (the more you increase the fewer duplicates you'll have).
xargs_complete() {
    args_completed=$((args_completed+1))
}
export -f xargs_complete
complete_fn() {
    if [ $args_completed = 0 ]; then
        return 124
    else
        return 0
    fi
}
export -f complete_fn
complete() { true; }
export complete
# Use "xargs" to split considering quoted strings :
# 1. if some arguments contains an eregex meta character, XRargs sports it as a separate arg
# 2. if some arguments looks like an option, xargs prepends it with an extra --
set -- \
        $(printf '%s\n' "$@" | \
          xargs -E '' -I {} -d'\n' printf '%s\n' '{}')

# Collect all arguments for the java command;
#   * DEFAULT_JVM_OPTS, JAVA_OPTS, and GRADLE_OPTS can contain fragments of
#     shell script including quotes and variable substitutions, so put them in
#     double quotes to make sure that they get re-expanded; and
#   * put everything else in single quotes, so that *in the original shell, and
#     *in sh -c*, no substitution is performed.

set -- \
        "-Dorg.gradle.appname=$APP_BASE_NAME" \
        -classpath "$CLASSPATH" \
        org.gradle.wrapper.GradleWrapperMain \
        "$@"

exec "$JAVACMD" "$@"

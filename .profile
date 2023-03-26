# Setting PATH for Homebrew that should take precedence
# over system-provided programs
export PATH="/usr/local/bin:$PATH"

# Add homebrew arm64 install path if applicable
if test $(uname -m) = "arm64"
  export PATH="/opt/homebrew/bin:$PATH"
end

# MacPorts Installer rddition on 2022-10-31_at_23:07:29: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

# Setting PATH for Python 3.11
# The original version is saved in .zprofile.pysave
# PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin:$PATH"
# export PATH

# Setting go environment
export GOPATH=$HOME/dev/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:$GOPATH/bin:$GOROOT/bin"


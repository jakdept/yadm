export GOROOT=/usr/local/go #set goroot
export PATH="${GOROOT}/bin:${PATH}" # add go binarys to path
export GOPATH=${HOME}/go # set GOPATH
export PATH="$GOPATH/bin:${PATH}" # add my binary to the front of my path
export CDPATH=$CDPATH:$GOPATH/src # add GOPATH/src to CDPATH

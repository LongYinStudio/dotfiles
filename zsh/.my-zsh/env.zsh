# node 使用的nvm
bin="/home/longyinstudio/bin"
go="/home/longyinstudio/dev-tools/go/bin"
export JAVA_HOME=/home/longyinstudio/dev-tools/jdk1.8.0_351
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export JRE_HOME=$JAVA_HOME/jre 

export PATH="$node:$JAVA_HOME/bin:$bin:$go:$PATH"

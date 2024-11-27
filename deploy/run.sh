#!/bin/sh

export JAVA_HOME=/home/user/.sdkman/candidates/java/current
JAVA_EXE=$JAVA_HOME/bin/java

function check_command() {
    if ! command -v $1 > /dev/null
    then
        echo "WARN: $1 could not be found"
        echo "install $1 using your package manager (apt install $1)"
    fi
}

NEED_BUILD="n"
WATCH_LOG="y"
DETACH="y"

tolower() {
   echo $1 | awk '{print tolower($0)}'
}

function interactive() {
    read -p "Target service dir: " TARGET_PROJ
    read -p "Target jar (should be empty if service dir provided): " TARGET_JAR
    read -p "Debug port (e.g. 5005): " DEBUG_PORT 
    read -p "Active sring profile (can be empty): " SPRING_PROFILE
    read -p "Env file (can be empty): " ENV_FILE
    read -p "Need build ? (n/y) (n): " NEED_BUILD
    read -p "Watch log? (n/y) (n): " WATCH_LOG
    read -p "Detach process? (n/y) (n): " DETACH
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -i|--interactive) interactive; break ;;
        -p|--spring-profile) SPRING_PROFILE=$2; shift ;;
        -d|--service-dir) TARGET_PROJ=$2; shift ;;
        -j|--target-jar) TARGET_JAR=$2; shift ;;
        -e|--env-file) ENV_FILE=$2; shift ;;
        -c|--debug_port) DEBUG_PORT=$2; shift ;;
        -b|--build) NEED_BUILD="$2"; shift;;
        -m|--watch-log) WATCH_LOG="$2"; shift;;
        -x|--detach) DETACH="$2"; shift;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

NEED_BUILD=$(tolower $NEED_BUILD)
WATCH_LOG=$(tolower $WATCH_LOG)
DETACH=$(tolower $DETACH)

function build() {
   # change dir to target project root
   cd $1
   if ! command -v mvn > /dev/null; then
        if ! [[ -x "./mvnw" ]]
        then
            echo "Local 'mvnw' is not executable. Changing permissions"
            chmod +x ./mvnw
        fi
        MAVEN_EXE="$(pwd)/mvnw (wrapper)"
        ./mvnw clean package
   else 
       MAVEN_EXE="$(which mvn)"
       mvn clean package 
   fi
   echo "Running maven build with maven: $MAVEN_EXE"
}

function prepare_jar() {
   echo "Preparing jar"
   if [ -z $TARGET_PROJ ]; then
      FULL_JAR_NAME="${TARGET_JAR##*/}"
      RUN_JAR=$TARGET_JAR
   else
      echo "Provided project: $TARGET_PROJ"
      echo "Build needed: $NEED_BUILD"
      if [[ "$NEED_BUILD" == "y" || "$NEED_BUILD" == "yes" ]]; then
         echo "Building project: $TARGET_PROJ"
         build $TARGET_PROJ
         build_status=$?
         if [[ $build_status -ne 0 ]]; then
            echo "Error while building project"
            exit $build_status
         fi
      fi

      BUILD_DIR=$TARGET_PROJ/target
      FULL_JAR_NAME="$(ls $BUILD_DIR | grep -m1 .jar)"
      RUN_JAR="$BUILD_DIR/$FULL_JAR_NAME"
   fi
   echo "Detected jar $RUN_JAR"
}

prepare_jar

JVM_OPTS="-Dserver.tomcat.protocol-header=x-forwarded-proto -agentlib:jdwp=transport=dt_socket,address=*:$DEBUG_PORT,server=y,suspend=n -Duser.timezone=Europe/Moscow -Dfile.encoding=UTF8 -Dorg.freemarker.loggerLibrary=SLF4J -Djava.security.egd=file:/dev/./urandom $JVM_OPTS_ADD"
JAR_OPTS="--spring.profiles.active=$SPRING_PROFILE"

ROOT_DIR="$HOME/ocrv/run"

JAR_NAME="$(echo $FULL_JAR_NAME | cut -d'-' -f1)"
SERVICE_DIR="$ROOT_DIR/$JAR_NAME"
mkdir -p $SERVICE_DIR 2>/dev/null

LOG_DIR="$SERVICE_DIR/logs"
mkdir $LOG_DIR 2> /dev/null

# single file
LOG_FILE="$LOG_DIR/$JAR_NAME.log"

# each startup file
#LOG_FILE="$LOG_DIR/$(date +%Y%m%d%H%M%S)_$JAR_NAME.log"

if ! [ -z "$ENV_FILE" ]; then 
    echo "Exporting enviroments from: $ENV_FILE"
    export $(grep -rhv '^#' $ENV_FILE | xargs)
    echo "Enviroment variables exported:"
    echo "$(grep -rhv '^#' $ENV_FILE)"
fi

echo "Killng last proccess of project: $PROJ"
kill -9 $(ps -axu | grep java | grep $PROJ | awk '{print $2}') 2> /dev/null

function run_jar_async() {
   echo "Running jar file in async mode"
   nohup $JAVA_EXE $JVM_OPTS -jar $RUN_JAR $JAR_OPTS &> $LOG_FILE &
}

function run_jar() {
   echo "Running jar in sync mode"
   $JAVA_EXE $JVM_OPTS -jar $RUN_JAR $JAR_OPTS
}

export -f run_jar
export -f run_jar_async

echo "Running with JVM OPTS: $JVM_OPTS"
echo "Running jar file: $RUN_JAR"
echo "Running with java arguments: $JAR_OPTS"
echo "Loaded project: $JAR_NAME"
echo "Need build: $NEED_BUILD"
echo "Detach: $DETACH"
echo "Enviroment file: $ENV_FILE"
echo "Debug port opened: $DEBUG_PORT"

if [ "$DETACH" == "y" ]; then
   echo "Watch log: $WATCH_LOG"
   echo "Log file created at: $LOG_FILE"
   PID_FILE="$SERVICE_DIR/$JAR_NAME.pid"
   run_jar_async
   echo $! > "$PID_FILE"
   echo "Pid file created: $PID_FILE"
   if [[ "$WATCH_LOG" == "y" || "$WATCH_LOG" == "yes" ]]; then
      check_command multitail
   	multitail -cT ansi -i $LOG_FILE
   fi
else
   run_jar
fi

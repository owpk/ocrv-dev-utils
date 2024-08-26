#!/bin/sh

function check_command() {
    if ! command -v $1 > /dev/null
    then
        echo "$1 could not be found"
        echo "install $1 using your package manager (apt install $1)"
        exit 1
    fi
}

check_command multitail

NEED_BUILD="N"
MULTITAIL="Y"

function interactive() {
    read -p "Target service dir: " TARGET_PROJ
    read -p "Debug port (e.g. 5005): " DEBUG_PORT 
    read -p "Active sring profile (can be empty): " SPRING_PROFILE
    read -p "Env file (can be empty): " ENV_FILE
    read -p "Need build ? (n/y) (n default, can be empty): " NEED_BUILD
    read -p "Watch log? (n/y) (n default, can be empty): " MULTITAIL
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -i|--interactive) interactive; break;;
        -p|--spring-profile) SPRING_PROFILE=$2; shift ;;
        -d|--service-dir) TARGET_PROJ=$2; shift ;;
        -e|--env-file) ENV_FILE=$2; shift ;;
        -e|--debug_port) DEBUG_PORT=$2; shift ;;
        -b|--build) NEED_BUILD="Y" ;;
        -m|--watch-log) MULTITAIL=$2; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

echo "NEED BUILD=$NEED_BUILD"

if [[ "$NEED_BUILD" == "Y" || "$NEED_BUILD" == "y" || "$NEED_BUILD" == "yes" ]]; then
    echo "Running maven build"
    cd $TARGET_PROJ
    if ! command -v mvn > /dev/null; then
         if ! [[ -x "./mvnw" ]]
         then
             echo "Local 'mvnw' is not executable. Changing permissions"
             chmod +x ./mvnw
         fi
         ./mvnw clean package
    else 
        mvn clean package 
    fi
fi

JVM_OPTS="-Dserver.tomcat.protocol-header=x-forwarded-proto -agentlib:jdwp=transport=dt_socket,address=*:$DEBUG_PORT,server=y,suspend=n -Duser.timezone=Europe/Moscow -Dfile.encoding=UTF8 -Dorg.freemarker.loggerLibrary=SLF4J -Djava.security.egd=file:/dev/./urandom"
JAR_OPTS="--spring.profiles.active=$SPRING_PROFILE"
echo "Running with java arguments: $JAR_OPTS"

BUILD_DIR="$TARGET_PROJ/target"
TARGET_JAR="$BUILD_DIR/*.jar"

ROOT_DIR="$HOME/ocrv/run"

FULL_JAR_NAME="$(ls $BUILD_DIR | grep -m1 .jar)"
JAR_NAME="$(echo $FULL_JAR_NAME | cut -d'-' -f1)"

echo "Loading project: $JAR_NAME"

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
    export $(grep -v '^#' $ENV_FILE | xargs)
fi

RUN_JAR="$BUILD_DIR/$FULL_JAR_NAME"

echo "Killng last proccess of project: $PROJ"
kill -9 $(ps -axu | grep java | grep $PROJ | awk '{print $2}') 

echo "Running jar file: $RUN_JAR"
nohup java $JVM_OPTS -jar $RUN_JAR $JAR_OPTS &> $LOG_FILE &

PID_FILE="$JAR_NAME.pid"
echo $! > "$SERVICE_DIR/$PID_FILE"

echo "Log file created at: $LOG_FILE"
echo "Pid file created at: $PID_FILE"
echo "Debug port opened: $DEBUG_PORT"

if [[ "$MULTITAIL" == "Y" || "$MULTITAIL" == "y" || "$MULTITAIL" == "yes" ]]; then
	multitail -cT ansi -i $LOG_FILE
fi

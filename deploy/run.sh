#!/bin/sh

function check_command() {
    if ! command -v $1 > /dev/null
    then
        echo "WARN: $1 could not be found"
        echo "install $1 using your package manager (apt install $1)"
    fi
}

check_command multitail

NEED_BUILD="n"
MULTITAIL="y"

tolower() {
   echo $1 | awk '{print tolower($0)}'
}

function interactive() {
    read -p "Target service dir: " TARGET_PROJ
    read -p "Target build dir (should be empty if service dir provided): " BUILD_DIR
    read -p "Debug port (e.g. 5005): " DEBUG_PORT 
    read -p "Active sring profile (can be empty): " SPRING_PROFILE
    read -p "Env file (can be empty): " ENV_FILE
    read -p "Need build ? (n/y) (n): " NEED_BUILD
    read -p "Watch log? (n/y) (n): " MULTITAIL

    NEED_BUILD=$(tolower $NEED_BUILD)
    MULTITAIL=$(tolower $MULTITAIL)
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -i|--interactive) interactive; break ;;
        -p|--spring-profile) SPRING_PROFILE=$2; shift ;;
        -d|--service-dir) TARGET_PROJ=$2; shift ;;
        -j|--build-dir) BUILD_DIR=$2; shift ;;
        -e|--env-file) ENV_FILE=$2; shift ;;
        -c|--debug_port) DEBUG_PORT=$2; shift ;;
        -b|--build) NEED_BUILD="y"; ;;
        -m|--watch-log) MULTITAIL="y"; ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

if [ -z $BUILD_DIR ]; then
   BUILD_DIR="$TARGET_PROJ/target"
fi

if [[ "$NEED_BUILD" == "y" || "$NEED_BUILD" == "yes" ]]; then
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

TARGET_JAR="$BUILD_DIR/*.jar"

ROOT_DIR="$HOME/ocrv/run"

FULL_JAR_NAME="$(ls $BUILD_DIR | grep -m1 .jar)"
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
    export $(grep -v '^#' $ENV_FILE | xargs)
fi

RUN_JAR="$BUILD_DIR/$FULL_JAR_NAME"

echo "Killng last proccess of project: $PROJ"
kill -9 $(ps -axu | grep java | grep $PROJ | awk '{print $2}') 

echo "Running jar file: $RUN_JAR"
nohup java $JVM_OPTS -jar $RUN_JAR $JAR_OPTS &> $LOG_FILE &

PID_FILE="$JAR_NAME.pid"
echo $! > "$SERVICE_DIR/$PID_FILE"

echo "Running with java arguments: $JAR_OPTS"
echo "Loaded project: $JAR_NAME"
echo "Need build: $NEED_BUILD"
echo "Enviroment file: $ENV_FILE"
echo "Debug port opened: $DEBUG_PORT"
echo "Log file created at: $LOG_FILE"

if [[ "$MULTITAIL" == "y" || "$MULTITAIL" == "yes" ]]; then
	multitail -cT ansi -i $LOG_FILE
fi

NAMES=("auth" "gateway" "pn-backend" "fs-backend")

RED='\033[0;31m'
GR='\033[0;32m'
PR='\033[0;36m'
YL='\033[0;33m'
NC='\033[0m' # No Color

color=$YL

for i in ${NAMES[@]}; do
   status=$(systemctl is-active $i)
   if [ "$status" == "active" ]; then
      color=$GR
   elif [ "$status" == "inactive" ]; then
      color=$RED
   fi
   printf "${PR}$i${NC} service status ${color}$status${NC}\n"
done

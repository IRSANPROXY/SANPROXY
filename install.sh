RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

clear
echo -e "${GREEN}Installing Proxy...${ENDCOLOR}"
echo -e "${RED}CODE SUPPORT BY IRSAN...${ENDCOLOR}"
sleep 1
if [ -f "proxy" ]; then
    echo -e "${RED}Deleting old proxy...${ENDCOLOR}"
    rm proxy
    sleep 1
    echo -e "${GREEN}Getting proxy...${ENDCOLOR}"
fi
wget -q https://github.com/JoakimTheCoder/AJTermux/raw/main/proxy
sleep 1
echo -e "${GREEN}AJproxy is now Installed.${ENDCOLOR}"
echo -e "${RED}if you lose the code just chat to irsan.${ENDCOLOR}"
echo -e "${BLUE}don't trust Luckyproxy.${ENDCOLOR}"
echo -e "${GREEN}Execute proxy with this command: ./proxy${ENDCOLOR}"
chmod +x proxy

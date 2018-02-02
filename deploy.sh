#!/bin/bash
#ROKU_DEV_TARGET=192.168.1.25   # Roku 2XS
#ROKU_DEV_TARGET=10.0.0.242   #Desktop TV
#ROKU_DEV_TARGET=10.168.141.226 #4K TV
ROKU_DEV_TARGET=10.0.0.66 #HOME



# wake up/interrupt Roku - workaround for fw5.4 crash
curl -sS -d '' http://$ROKU_DEV_TARGET:8060/keypress/Home
curl -sS -d '' http://$ROKU_DEV_TARGET:8060/keypress/Home

# build. zip _must_ change for Roku to accept re-deploy (grr!)
cd -- "$(dirname "$0")"
touch timestamp
zip -FS -9 -r bundle * -x run extras

# deploy
curl -f -sS --user rokudev:cheese --anyauth -F "mysubmit=Install" -F "archive=@bundle.zip" -F "passwd=" http://$ROKU_DEV_TARGET/plugin_install  \
| python -c 'import sys, re; print "\n".join(re.findall("<font color=\"red\">(.*?)</font>", sys.stdin.read(), re.DOTALL))'
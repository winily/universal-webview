set -e
sh ./scripts/build.sh

cd ./build
./uw ../uw.config.json

set -e
sh ./scripts/build.sh

cd ./build
./universal-webview
# ./universal-webview-test
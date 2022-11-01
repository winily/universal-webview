set -e
sh ./scripts/build.sh

cp -r ./resource ./build/test
cd ./build
ctest 
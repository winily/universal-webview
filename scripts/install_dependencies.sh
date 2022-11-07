set -e

if [ ! -d "./lib" ]; then
  mkdir ./lib
fi

cd ./lib

# 存在编译好的 yaml 就不编译了
if [ -f "./jsoncpp-1.9.5/build/lib/libjsoncpp.a" ]; then
  echo "------------------依赖存在------------------"
  exit
fi

echo "------------------下载编译依赖------------------"
# 安装 yaml-cpp
# 下载依赖
if [ ! -f "./1.9.5.zip" ]; then
  wget https://github.com/open-source-parsers/jsoncpp/archive/refs/tags/1.9.5.zip
fi

# 解压依赖
if [ ! -d "./jsoncpp-1.9.5" ]; then
  unzip ./1.9.5.zip
fi

cd ./jsoncpp-1.9.5

# 解压依赖
if [ -d "./build" ]; then
  rm -fr ./build
fi
mkdir build
cd build

cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build .
echo "------------------编译完成------------------"

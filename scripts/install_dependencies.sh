set -e

if [ ! -d "./lib" ]; then
  mkdir ./lib
fi

cd ./lib

# 存在编译好的 yaml 就不编译了
if [ -f "./yaml-cpp-yaml-cpp-0.6.3/build/libyaml-cpp.a" ]; then
  echo "------------------依赖存在------------------"
  exit
fi

echo "------------------下载编译依赖------------------"
# 安装 yaml-cpp
# 下载依赖
if [ ! -f "./yaml-cpp-0.6.3.zip" ]; then
  wget https://github.com/jbeder/yaml-cpp/archive/refs/tags/yaml-cpp-0.6.3.zip
fi

# 解压依赖
if [ ! -d "./yaml-cpp-yaml-cpp-0.6.3" ]; then
  unzip ./yaml-cpp-0.6.3.zip
fi

cd ./yaml-cpp-yaml-cpp-0.6.3

# 解压依赖
if [ -d "./build" ]; then
  rm -fr ./build
fi
mkdir build
cd build

cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build .
echo "------------------编译完成------------------"

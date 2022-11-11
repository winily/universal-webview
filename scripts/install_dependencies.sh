set -e

if [ ! -d "./lib" ]; then
  mkdir ./lib
fi

cd ./lib

# 存在编译好的 jsoncpp 就不编译了
if [ ! -f "./jsoncpp-1.9.5/build/lib/libjsoncpp.a" ]; then
  echo "------------------jsoncpp 依赖存在------------------"

  echo "------------------下载 jsoncpp 编译依赖------------------"
  # 安装 jsoncpp
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

  cd ..
fi

# 存在编译好的 quickjs 就不编译了
if [ ! -f "/usr/local/lib/quickjs/libquickjs.a" ]; then
  # 安装 quickjs
  # 下载依赖
  if [ ! -f "./quickjs-2021-03-27.tar.xz" ]; then
    echo "------------------下载 quickjs 编译依赖------------------"
    wget https://bellard.org/quickjs/quickjs-2021-03-27.tar.xz
  fi

  # 解压依赖
  if [ ! -d "./quickjs-2021-03-27" ]; then
    echo "----------------------解压 quickjs----------------------"
    tar -xvf ./quickjs-2021-03-27.tar.xz
  fi

  cd ./quickjs-2021-03-27
  make
  make install
fi

echo "------------------安装完成------------------"

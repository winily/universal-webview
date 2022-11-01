# set -e
if [ -d "./build" ]; then
  rm -fr ./build
fi

get_cpu_count() {
  cpu=2
  if [ "$(uname)" == 'Darwin' ]; then
    cpu=$(sysctl -n machdep.cpu.thread_count)
  elif [ "$(expr substr $(uname -s) 1 5)"=="Linux" ]; then
    cpu=$(cat /proc/cpuinfo | grep processor | wc -l)
  fi
  return $cpu
}

mkdir ./build
cd build
cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=1
# cmake -H. -Bbuild

get_cpu_count
cpu=$?
# make -j ${cpu}
cmake --build .

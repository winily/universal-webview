#pragma once

#include "../config/config.hpp"
#include <cstddef>
#include <cstring>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <memory>
#include <quickjs/quickjs-libc.h>
#include <thread>

namespace UW::JS {
class JS {
public:
  JS(Config::Config &config) : config_(config) {}

  void operator()() {
    JSRuntime *runtime_ = JS_NewRuntime();
    JSContext *context_ = JS_NewContext(runtime_);

    JS_SetModuleLoaderFunc(runtime_, nullptr, js_module_loader, nullptr);
    js_std_add_helpers(context_, 0, NULL);
    js_init_module_std(context_, "std");
    js_init_module_os(context_, "os");

    auto js = readJs();
    std::cout << js << std::endl;
    JSValue result = JS_Eval(context_, js.data(), js.length(), "main", 0);
  }

private:
  std::string readJs() {
    auto current_path = std::filesystem::current_path();
    current_path /= config_.main_path_;

    std::fstream infile;
    infile.open(current_path); //将文件流对象与文件连接起来
    assert(infile.is_open()); //若失败,则输出错误消息,并终止程序运行

    std::string js = "";
    std::string jsLine;
    while (getline(infile, jsLine)) {
      js.append(jsLine);
      js.append("\n");
    }
    infile.close();
    return js;
  }

private:
  JSRuntime *runtime_;
  JSContext *context_;
  Config::Config &config_;
};

inline auto asyncRunJS(Config::Config &config) {
  // 拉起一个线程运行 js 后端
  return std::thread(JS(config));
}

} // namespace UW::JS
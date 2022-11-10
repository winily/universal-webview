#pragma once

#include "../../container/buffer.hpp"
#include <string>

namespace UW::SysApi::Clipboard {
// 清空剪贴板
void Clear();
// 读取剪贴板
Buffer Read(std::string format);
// 写入剪贴板
bool Write(std::string format_str, std::string buffer);
} // namespace UW::SysApi::Clipboard
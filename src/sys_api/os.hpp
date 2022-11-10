#pragma once

#include <string>
namespace UW::SysApi::OS {
#if defined __aarch64__
#define Arch "aarch64";
#elif defined __arm__
#define Arch "arm";
#elif defined __x86_64__
#define Arch "x86_64";
#elif defined __i386__
#define Arch "x86";
#elif defined __thumb__
#define Arch "thumb";
#endif
} // namespace UW::SysApi::OS

#pragma once

#include <iostream>
#include <json/json.h>
#include <string>
#include <vector>

namespace UW::Config {
struct MenuItem {
  MenuItem(Json::Value item) {
    name = item["name"].asString();
    key = item["key"].asString();
    auto childrenList = item["children"];
    for (int index = 0; index < childrenList.size(); ++index)
      children.push_back(MenuItem(childrenList[index]));
  }
  std::string name;
  std::string key;
  std::vector<MenuItem> children;
};

struct Menu {
  Menu() = default;
  Menu(Json::Value menu) {
    auto navigationMenuList = menu["navigation"];
    for (int index = 0; index < navigationMenuList.size(); ++index)
      navigation.push_back(MenuItem(navigationMenuList[index]));
  }

  std::vector<MenuItem> navigation;
};
} // namespace UW::Config
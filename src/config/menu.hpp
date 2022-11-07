#pragma once

#include <iostream>
#include <json/json.h>
#include <string>
#include <vector>

namespace UW::Config {
class MenuItem {
public:
  MenuItem(Json::Value item) {
    name_ = item["name"].asString();
    key_ = item["key"].asString();
    auto childrenList = item["children"];
    for (int index = 0; index < childrenList.size(); ++index)
      children_.push_back(MenuItem(childrenList[index]));
  }
  std::string name_;
  std::string key_;
  std::vector<MenuItem> children_;
};

class Menu {
public:
  Menu() = default;
  Menu(Json::Value menu) {
    auto navigationMenuList = menu["navigation"];
    for (int index = 0; index < navigationMenuList.size(); ++index)
      navigation_.push_back(MenuItem(navigationMenuList[index]));
  }

  std::vector<MenuItem> navigation_;
};
} // namespace UW::Config
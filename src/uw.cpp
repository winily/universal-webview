#include "yaml-cpp/yaml.h"

int main() {
  YAML::Node node = YAML::Load("[1, 2, 3]");
  assert(node.Type() == YAML::NodeType::Sequence);
  assert(node.IsSequence()); // a shortcut!
}
import 'package:flutter/material.dart';

enum TabItem { red, green, blue } // TabItem 을 만들어놓고

const Map<TabItem, String> tabName = { // 그 TabItem 으로 맵을 통해서 탭 이름을 알아내고
  TabItem.red: 'red',
  TabItem.green: 'green',
  TabItem.blue: 'blue',
};

const Map<TabItem, MaterialColor> activeTabColor = { // 그 TabItem 으로 맵을 통해서 탭 칼러를 정하고
  TabItem.red: Colors.red,
  TabItem.green: Colors.green,
  TabItem.blue: Colors.blue,
};

import 'package:flutter/material.dart';
import 'package:nested_navigation_demo_flutter/color_detail_page.dart';
import 'package:nested_navigation_demo_flutter/colors_list_page.dart';
import 'package:nested_navigation_demo_flutter/tab_item.dart';

class TabNavigatorRoutes {
  static const String root = '/'; // 이렇게 루트를 static 으로 정하고
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState>? navigatorKey;
  final TabItem tabItem;

  void _push(BuildContext context, {int materialIndex: 500}) { // 말그대로 detail 로 가는 함수이다.
    var routeBuilders = _routeBuilders(context, materialIndex: materialIndex); // 이런식으로 materialIndex 를 넣어서 루트를 다시 만들었다.

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            routeBuilders[TabNavigatorRoutes.detail]!(context),
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {int materialIndex: 500}) {
    return {
      TabNavigatorRoutes.root: (context) => ColorsListPage(
            color: activeTabColor[tabItem]!,
            title: tabName[tabItem]!,
            onPush: (materialIndex) =>
                _push(context, materialIndex: materialIndex),
          ),
      TabNavigatorRoutes.detail: (context) => ColorDetailPage(
            color: activeTabColor[tabItem]!,
            title: tabName[tabItem]!,
            materialIndex: materialIndex,
          ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context); // 루트 빌더 가지고 있으면서
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root, // 맨처음에는 root 로 시작한다.
      onGenerateRoute: (routeSettings) { // initialRoute 의 TabNavigatorRoutes.root 를 routeSettings 로 넘겨준다. 아규먼트도 설정가능하다.
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name!]!(context),
          // builder: (context) => routeBuilders[TabNavigatorRoutes.root]!(context), // 이거랑 똑같았네.
        );
      },
    );
  }
}

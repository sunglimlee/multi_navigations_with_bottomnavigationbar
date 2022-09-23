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

  // 만약 리스트에다가 이걸 만들어버리면 나중에 디테일에서 이걸 또 만들어야 하는거잖아.. 파라미터를 던져주면 이렇게 상위 라우팅을 띠로 모을 수 있는데..
  void _push(BuildContext context, {int materialIndex: 500}) { // 말그대로 detail 로 가는 함수이다.
    var routeBuilders = _routeBuilders(context, materialIndex: materialIndex); // 이런식으로 materialIndex 를 넣어서 루트를 다시 만들었다.

    Navigator.push( // 그냥 함수가 밖에 나와 있다고 생각하자.. 왜 그래야 하는데? 안에서 값을 받았지만 정작 라우트를 하는거는 밖에서 하는게 좋지.
      // 왜냐하면 밖에 여기에서 라우트 할 수 있는 맵 함수를 쓸 수 있고 실지로 라우팅을 할 수 있으니깐..
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
      // 들어오는 루트에 대해서 리스트페이지를 보여주는 거잖아.. 어떻게
      TabNavigatorRoutes.root: (context) => ColorsListPage(
            color: activeTabColor[tabItem]!,
            title: tabName[tabItem]!,
            onPush: (materialIndex) => // callback 함수를 넣어주라는 거지..
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
      onGenerateRoute: (Settings) { // initialRoute 의 TabNavigatorRoutes.root 를 routeSettings 로 넘겨준다. 아규먼트도 설정가능하다.
        return MaterialPageRoute(
          builder: (context) => routeBuilders[Settings.name!]!(context),
          // builder: (context) => routeBuilders[TabNavigatorRoutes.root]!(context), // 이거랑 똑같았네.
        );
      },
    );
  }
}

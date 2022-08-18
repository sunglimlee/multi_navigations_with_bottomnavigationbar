import 'package:flutter/material.dart';
import 'package:nested_navigation_demo_flutter/bottom_navigation.dart';
import 'package:nested_navigation_demo_flutter/tab_item.dart';
import 'package:nested_navigation_demo_flutter/tab_navigator.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  var _currentTab = TabItem.red;
  final _navigatorKeys = { // 이것도 맵으로 만들어놨고
    TabItem.red: GlobalKey<NavigatorState>(),
    TabItem.green: GlobalKey<NavigatorState>(),
    TabItem.blue: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      // isFirst 를 통해서 true 가 될때가지 전체
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
      // 값이 그대로다. 안바뀐다. 오마이캇
      print("_currentTab 값은 계속 setState 할때 변경될까? ${_currentTab.hashCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentTab != TabItem.red) {
            // select 'main' tab
            _selectTab(TabItem.red);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[ // 전체로 되나????
          _buildOffstageNavigator(TabItem.red),
          _buildOffstageNavigator(TabItem.green),
          _buildOffstageNavigator(TabItem.blue),
        ]),
        bottomNavigationBar: _bottomNavigation(),
      ),
    );
  }

  Widget _bottomNavigation() {
    var bN = BottomNavigation(
      currentTab: _currentTab,
      onSelectTab: _selectTab,
    );
    return bN;

  }
  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage( // OffState 가 Navigator 를 자식으로 가지고 있고 Navigator build 가 가야할 곳을 정한다.
      // 그런데 GlobalKey 를 가지고 있기 때문에 다른데로 갔다가 오더라도 값이 유지되고 있는거다.
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        // NavigatorKey has type GlobalKey<NavigatorState>. We need this to uniquely identify the navigator across the entire app
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}

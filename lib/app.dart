import 'package:flutter/material.dart';
import 'package:nested_navigation_demo_flutter/bottom_navigation.dart';
import 'package:nested_navigation_demo_flutter/buttom_navigation_stateful.dart';
import 'package:nested_navigation_demo_flutter/tab_item.dart';
import 'package:nested_navigation_demo_flutter/tab_navigator.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  var _currentTab = TabItem.red; // StatefulWidget 이고 그래서 _currentTab 값은 유지가 되고 있구나.
  final _navigatorKeys = { // 이것도 맵으로 만들어놨고
    TabItem.red: GlobalKey<NavigatorState>(),
    TabItem.green: GlobalKey<NavigatorState>(),
    TabItem.blue: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      // isFirst 를 통해서 true 가 될때가지 전체
      // 현재 네비게이터의 가장 첫번째 이냐 일때까지 popUntil 해라.
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
      // 값이 그대로다. 안바뀐다. 오마이캇
      print("_currentTab 값은 계속 setState 할때 변경될까? ${_currentTab.hashCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    // 여차하면 현재화면 pop 할건데
    return WillPopScope(
      onWillPop: () async { // pop 할때 일단
        final isFirstRouteInCurrentTab =
            // 현재 GlobalKey 를 가진 Naviagtor 의 NavigateState 가 pop 이가능하나? (maybePop)
            // true 를 리턴하면 첫번째 페이지가 아니라는 거지.. 그래서 ! 느낌표를 넣은거고
            !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
        // pop 이 가능하지 않아서 즉 첫번째 페이지라서 ifFirstRouteInCurrentTab 이 true 라면
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          // 빨간탭이 아니라면 빨간탭으로 보내고
          if (_currentTab != TabItem.red) {
            // select 'main' tab
            _selectTab(TabItem.red);
            // back button handled by app
            return false; // 여기서 false 가 리턴되는 뜻은 WillPopScope 을 실행하지 말라는뜻
            // Flutter WillPopScope class 설명에도 나와 있듯이 true 면 ModalRoute 를 종료하겠다는 뜻
          }
        }
        //
        // let system handle back button if we're on the first route
        // 만약에 true 라면 이제는 시스템에 제어권을 넘겨서 ModalRoute 를 종료하겠다는 거지.
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
      key: const ValueKey(1),
      currentTab: _currentTab,
      onSelectTab: _selectTab,
    );
    return bN;
  }

  Widget _bottomNavigationStateful() {
    var bN = BottomNavigationStateful(
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

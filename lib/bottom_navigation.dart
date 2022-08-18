import 'package:flutter/material.dart';
import 'package:nested_navigation_demo_flutter/tab_item.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({required this.currentTab, required this.onSelectTab}); // 현재 설정값 vs 선택한 값
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    var bN = BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // width 즉 가로가 정해져 있다는 뜻
      items: [
        _buildItem(TabItem.red),
        _buildItem(TabItem.green),
        _buildItem(TabItem.blue),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index], // 야! 이걸 몰라서 찾아봤었는데 enum values[index] 로 한다고? // QnADartGrammar
      ),
      currentIndex: currentTab.index, // 야! 이것도 index 를 이용했구나. // QnADartGrammar
      selectedItemColor: activeTabColor[currentTab]!, // 여기 보이지 Map 함수 사용하고 있는거 // QnADartGrammar
    );
    // 누를때마다 값이 바뀐다. 그말은 계속 새롭게 만들어진다는 뜻이고.. 그래서 이 객체를 만들때 현재값과 선택한 값을 받아서 다시 그려주는거구나.
    print("BottomNavigation의 값은 ${bN.hashCode} 입니다.");
    return bN;
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.layers, // 그렇구나. layers 를 사용하고 있구나. 괜찮은 아이디어다.
        color: _colorTabMatching(tabItem),
      ),
      label: tabName[tabItem],
    );
  }

  Color _colorTabMatching(TabItem item) {
    return currentTab == item ? activeTabColor[item]! : Colors.grey; // 이것도 아주 괞찮은 방법이다. 필요없는 것들은 Colors.grey 로 처리한다.
  }
}

import 'package:boravaleno/designSytem/components/BottomTabBar/bottom_tab_bar_view_model.dart';
import 'package:boravaleno/designSytem/shared/colors.dart';
import 'package:boravaleno/views/MapPage/map.dart';
import 'package:boravaleno/views/ProfilePage/profile.dart';
import 'package:boravaleno/views/RankingPage/ranking.dart';
import 'package:flutter/material.dart';
class BottomTabBar extends StatelessWidget {
  final BottomTabBarViewModel viewModel;
  final int currentIndex;

  const BottomTabBar._({super.key, required this.viewModel, required this.currentIndex});

  static Widget instantiate({required BottomTabBarViewModel viewModel, required int currentIndex}) {
    return BottomTabBar._(viewModel: viewModel, currentIndex: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const MapPage(),
      const RankingPage(),
      ProfilePage(),
    ];

    return BottomNavigationBar(
      items: viewModel.bottomTabs,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: darkPrimaryBrandColor,
      unselectedItemColor: darkPrimaryBaseColorLight,
      showUnselectedLabels: true,
      currentIndex: currentIndex,
      onTap: (index) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => pages[index]),
        );
      },
    );
  }
}
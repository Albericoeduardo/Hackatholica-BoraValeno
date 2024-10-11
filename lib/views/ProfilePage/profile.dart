import 'package:boravaleno/designSytem/components/BottomTabBar/bottom_tab_bar.dart';
import 'package:boravaleno/designSytem/components/BottomTabBar/bottom_tab_bar_view_model.dart';
import 'package:boravaleno/designSytem/shared/styles.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final List functions = [
    'Edit Name',
    'Shipping Info',
    'Notification',
    'Terms & Conditions',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Title(
                  color: Colors.black,
                  child: const Text(
                    'Perfil',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Image.asset(
                    'assets/AvatarProfile.png',
                    width: 64,
                    height: 64,
                  ),
                  const SizedBox(width: 20),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Amanda Doe',
                          style: button1Bold,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                                    IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                    ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 40),
              const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                    children: [
                      Text("Partidas Jogadas", style: TextStyle(fontSize:20)),
                      const SizedBox(height: 8),
                      Text("100", style: TextStyle(fontSize: 46)),
                    ],
                    ),
                    Column(
                    children: [
                      Text("% Vitórias", style: TextStyle(fontSize: 20)),
                      const SizedBox(height: 8),
                      Text("31", style: TextStyle(fontSize: 46)),
                    ],
                    ),
                  ],
                ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomTabBar.instantiate(
        currentIndex: 2,
        viewModel: BottomTabBarViewModel(
          bottomTabs: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: "Ranking",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            )
          ],
        )
      ),
    );
  }
}
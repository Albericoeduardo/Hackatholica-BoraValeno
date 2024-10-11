import 'package:boravaleno/designSytem/components/BottomTabBar/bottom_tab_bar.dart';
import 'package:boravaleno/designSytem/components/BottomTabBar/bottom_tab_bar_view_model.dart';
import 'package:flutter/material.dart';

class Player {
  final String name;
  final int score;
  final int position;

  Player({
    required this.name,
    required this.score,
    required this.position,
  });
}

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  // Lista de jogadores fictícios no ranking
  final List<Player> players = [
    Player(name: "John Doe", score: 1500, position: 1),
    Player(name: "Jane Smith", score: 1400, position: 2),
    Player(name: "Mike Johnson", score: 1300, position: 3),
    Player(name: "Emily Davis", score: 1250, position: 4),
    Player(name: "Chris Lee", score: 1200, position: 5),
    Player(name: "Sara Wilson", score: 1150, position: 6),
  ];

  // Supondo que o jogador atual seja o Mike Johnson (posição 3)
  final int currentPlayerIndex = 2;

  @override
  Widget build(BuildContext context) {
    Player currentPlayer = players[currentPlayerIndex];

    return Scaffold(
      bottomNavigationBar: BottomTabBar.instantiate(
        currentIndex: 1,
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
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Title(
                  color: Colors.black,
                  child: const Text(
                    'Ranking de Tênis de Mesa',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
            // Exibe a posição do jogador atual no ranking
            Card(
              color: Colors.blueAccent.withOpacity(0.2),
              elevation: 3,
              shadowColor: Colors.blueAccent,
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text(
                  "${currentPlayer.name} (Você)",
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text("Posição: ${currentPlayer.position} - Pontuação: ${currentPlayer.score}"),
              ),
            ),

            const SizedBox(height: 16),

            // Exibe a lista completa de jogadores
            Expanded(
              child: ListView.builder(
                itemCount: players.length,
                itemBuilder: (context, index) {
                  final player = players[index];

                  // Cores das bordas para os primeiros colocados
                  Color? borderColor;
                  if (index == 0) {
                    borderColor = Colors.amber; // Ouro
                  } else if (index == 1) {
                    borderColor = Colors.grey; // Prata
                  } else if (index == 2) {
                    borderColor = Colors.brown; // Bronze
                  }

                  return Card(
                    shape: borderColor != null
                        ? RoundedRectangleBorder(
                            side: BorderSide(color: borderColor, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          )
                        : RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey.shade800,
                        child: Text(
                          player.position.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        player.name,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: index == currentPlayerIndex
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      subtitle: Text("Pontuação: ${player.score}"),
                      tileColor: index == currentPlayerIndex
                          ? Colors.blueAccent.withOpacity(0.1)
                          : null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
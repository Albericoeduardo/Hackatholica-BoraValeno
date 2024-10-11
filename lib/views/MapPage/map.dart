import 'package:boravaleno/designSytem/components/BottomTabBar/bottom_tab_bar.dart';
import 'package:boravaleno/designSytem/components/BottomTabBar/bottom_tab_bar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();

  final LatLng _initialPosition = const LatLng(-10.2491, -48.3243); // Coordenadas de Palmas, Tocantins, Centro Universitário Católica do Tocantins
  final List<Map<String, dynamic>> _eventos = [
    {
      'nome': 'Corrida 10K',
      'local': 'Parque Cesamar',
      'data': '2024-10-20',
      'gratuidade': true,
      'participantes': ['João', 'Maria', 'Carlos'],
      'latLng': const LatLng(-10.172810, -48.325666), // Coordenadas corrigidas para Palmas, Tocantins
    },
    {
      'nome': 'Copa de Futebol',
      'local': 'Estádio Nilton Santos',
      'data': '2024-11-05',
      'gratuidade': false,
      'participantes': ['Paulo', 'Ana', 'Felipe'],
      'latLng': const LatLng(-10.282333, -48.330906),
    },
    {
      'nome': 'Maratona de Palmas',
      'local': 'Praça dos Girassóis',
      'data': '2024-12-01',
      'gratuidade': true,
      'participantes': ['Lucas', 'Fernanda', 'Gabriel'],
      'latLng': const LatLng(-10.315480, -48.325794),
    },
    {
      'nome': 'Festival de Música',
      'local': 'Parque Cesamar',
      'data': '2024-12-15',
      'gratuidade': false,
      'participantes': ['Mariana', 'Pedro', 'Juliana'],
      'latLng': const LatLng(-10.1844, -48.3336),
    },
    {
      'nome': 'Feira de Artesanato',
      'local': 'Centro de Convenções Arnaud Rodrigues',
      'data': '2024-12-20',
      'gratuidade': true,
      'participantes': ['Rafael', 'Sofia', 'Bruno'],
      'latLng': const LatLng(-10.2128, -48.3603),
    },
    {
      'nome': 'Show de Talentos',
      'local': 'Teatro Fernanda Montenegro',
      'data': '2024-12-25',
      'gratuidade': false,
      'participantes': ['Clara', 'Miguel', 'Alice'],
      'latLng': const LatLng(-10.252893, -48.346203),
    },
    {
      'nome': 'Corrida de Rua',
      'local': 'Avenida JK',
      'data': '2025-01-10',
      'gratuidade': true,
      'participantes': ['Thiago', 'Beatriz', 'Eduardo'],
      'latLng': const LatLng(-10.222565, -48.320693),
    },
    {
      'nome': 'Campeonato de Vôlei',
      'local': 'Ginásio Ayrton Senna',
      'data': '2025-01-20',
      'gratuidade': false,
      'participantes': ['Isabela', 'Henrique', 'Laura'],
      'latLng': const LatLng(-10.2491, -48.3243),
    },
    {
      'nome': 'Festival de Cinema',
      'local': 'Cine Cultura',
      'data': '2025-02-05',
      'gratuidade': true,
      'participantes': ['Marcos', 'Luiza', 'Ricardo'],
      'latLng': const LatLng(-10.1847, -48.3333),
    },
    {
      'nome': 'Exposição de Arte',
      'local': 'Palácio Araguaia',
      'data': '2025-02-15',
      'gratuidade': false,
      'participantes': ['Gustavo', 'Camila', 'Renata'],
      'latLng': const LatLng(-10.1847, -48.3333),
    }
  ];

  List<Marker> _createMarkers() {
    return _eventos.map((evento) {
      return Marker(
        width: 50,
        height: 50,
        point: evento['latLng'],
        builder: (ctx) => GestureDetector(
          onTap: () => _showEventModal(evento),
          child: const Icon(
            Icons.location_on,
            size: 40,
            color: Colors.red,
          ),
        ),
      );
    }).toList();
  }

  void _showEventModal(Map<String, dynamic> evento) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    evento['nome'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Local: ${evento['local']}',
                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                Text(
                  'Data: ${evento['data']}',
                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                Text(
                  'Gratuito: ${evento['gratuidade'] ? "Sim" : "Não"}',
                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                ),
                const SizedBox(height: 16),
                Text(
                  'Participantes: ${evento['participantes'].join(", ")}',
                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _confirmarPresenca(evento['nome']);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Confirmar Presença',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

void _confirmarPresenca(String eventoNome) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            "Conversa no evento: $eventoNome",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Cor do texto do título
            ),
          ),
        ),
        content: SizedBox(
          width: double.maxFinite, // Para ocupar toda a largura disponível
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 200, // Altura fixa para a área de mensagens
                child: ListView(
                  children: [
                    // Exemplo de mensagens
                    _buildMessageBubble("João", "Estou animado para o evento!"),
                    _buildMessageBubble("Maria", "Eu também!"),
                    _buildMessageBubble("Carlos", "Vamos nos encontrar lá."),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Escreva sua mensagem...",
                    hintStyle: const TextStyle(color: Colors.grey), // Estilo do texto de dica
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.teal),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.tealAccent),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.teal, // Cor do texto do botão
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Enviar'),
            ),
          ),
        ],
      );
    },
  );
}

Widget _buildMessageBubble(String sender, String message) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          child: Text(sender[0]),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sender,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.teal[100], // Cor de fundo das mensagens
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: _initialPosition,
          zoom: 15.0,
        ),
        children: [
            TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
            ),
          MarkerLayer(
            markers: _createMarkers(),
          ),
        ],
      ),
      bottomNavigationBar: BottomTabBar.instantiate(
        currentIndex: 0,
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

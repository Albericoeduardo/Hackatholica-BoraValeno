import 'package:flutter/material.dart';

class Event {
  final String name;
  final String location;
  final String date;
  final String imageUrl;
  bool isExpanded;
  List<String> confirmedAttendees;

  Event({
    required this.name,
    required this.location,
    required this.date,
    required this.imageUrl,
    this.isExpanded = false,
    this.confirmedAttendees = const [],
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Event> events = [
    Event(
      name: 'Campeonato de Futebol',
      location: 'Estádio Municipal',
      date: '20/11/2024',
      imageUrl: 'assets/football_championship.jpg',
    ),
    Event(
      name: 'Corrida de Rua',
      location: 'Avenida Principal',
      date: '25/11/2024',
      imageUrl: 'assets/street_race.jpeg',
    ),
    Event(
      name: 'Torneio de Tênis',
      location: 'Clube de Tênis',
      date: '30/11/2024',
      imageUrl: 'assets/tennis_tournament.jpg',
    ),
    Event(
      name: 'Maratona Aquática',
      location: 'Lago Municipal',
      date: '05/12/2024',
      imageUrl: 'assets/swimming_marathon.jpg',
    ),
    Event(
      name: 'Campeonato de Vôlei',
      location: 'Ginásio Poliesportivo',
      date: '10/12/2024',
      imageUrl: 'assets/volleyball_championship.png',
    ),
  ];

  void confirmPresence(Event event) {
    setState(() {
      if (!event.confirmedAttendees.contains('Você')) {
        event.confirmedAttendees.add('Você');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('Eventos'),
      backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) => Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        elevation: 5,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        ),
        child: ExpansionTile(
        title: Text(
          events[index].name,
          style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          ),
        ),
        subtitle: Text(
          events[index].location,
          style: const TextStyle(
          color: Colors.grey,
          ),
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
          events[index].imageUrl,
          width: 64,
          height: 64,
          fit: BoxFit.cover,
          ),
        ),
        children: [
          Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
              children: [
              const Text(
                'Data: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(events[index].date),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              ),
              onPressed: () => confirmPresence(events[index]),
              child: const Text('Confirmar Presença'),
            ),
            const SizedBox(height: 16),
            Text(
              'Confirmados: ${events[index].confirmedAttendees.join(', ')}',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 16),
            const Text(
              'Chat:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              height: 200,
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
              itemCount: 10, // Replace with actual message count
              itemBuilder: (context, chatIndex) => ListTile(
                title: Text('User $chatIndex'),
                subtitle: Text('Message from user $chatIndex'),
              ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
              const Expanded(
                child: TextField(
                decoration: InputDecoration(
                  hintText: 'Digite sua mensagem...',
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Colors.teal),
                onPressed: () {
                // Implement send message functionality
                },
              ),
              ],
            ),
            ],
          ),
          ),
        ],
        ),
      ),
      ),
    );
  }
}
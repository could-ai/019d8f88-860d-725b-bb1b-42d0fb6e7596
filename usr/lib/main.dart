import 'package:flutter/material.dart';

void main() {
  runApp(const FriendsVsFamilyApp());
}

class FriendsVsFamilyApp extends StatelessWidget {
  const FriendsVsFamilyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Friends vs Family',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const ExplorationScreen(),
    );
  }
}

class ExplorationScreen extends StatefulWidget {
  const ExplorationScreen({super.key});

  @override
  State<ExplorationScreen> createState() => _ExplorationScreenState();
}

class _ExplorationScreenState extends State<ExplorationScreen> {
  String? _userVote;
  
  // Mock statistics
  int _friendsVotes = 42;
  int _familyVotes = 38;
  int _bothVotes = 20;

  void _castVote(String choice) {
    if (_userVote != null) return; // Already voted

    setState(() {
      _userVote = choice;
      if (choice == 'Friends') _friendsVotes++;
      if (choice == 'Family') _familyVotes++;
      if (choice == 'Both') _bothVotes++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Are Friends Better Than Family?'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'A Tale of Two Bonds',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'The debate between the importance of friends versus family is as old as human society. '
              'Family represents our roots, our blood, and our unconditional beginnings. '
              'Friends represent our choices, our shared interests, and the family we build along the way. '
              'Explore the perspectives below and cast your vote.',
              style: TextStyle(fontSize: 16, height: 1.5),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 32),
            
            // The Case for Family
            _buildPerspectiveCard(
              context,
              title: 'The Case for Family',
              icon: Icons.family_restroom,
              color: Colors.blue.shade100,
              points: [
                'Unconditional Support: Family is often there for you no matter what mistakes you make.',
                'Shared History: You share a deep, foundational history and cultural background.',
                'Lifelong Bond: Family ties are permanent and often outlast many friendships.',
                'Duty and Care: There is a built-in societal and biological safety net.'
              ],
            ),
            
            const SizedBox(height: 16),
            
            // The Case for Friends
            _buildPerspectiveCard(
              context,
              title: 'The Case for Friends',
              icon: Icons.people,
              color: Colors.green.shade100,
              points: [
                'The Family We Choose: You select friends based on mutual respect, interests, and values.',
                'Less Judgment: Friendships often lack the complex baggage and expectations of family dynamics.',
                'Evolving Support: Friends adapt to who you are now, not just who you were growing up.',
                'Equality: Friendships are typically built on equal footing without hierarchical family structures.'
              ],
            ),

            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),

            // Voting Section
            const Text(
              'What do you think?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            
            if (_userVote == null) ...[
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 16,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _castVote('Family'),
                    icon: const Icon(Icons.family_restroom),
                    label: const Text('Family First'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _castVote('Friends'),
                    icon: const Icon(Icons.people),
                    label: const Text('Friends First'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _castVote('Both'),
                    icon: const Icon(Icons.balance),
                    label: const Text('Equally Important'),
                  ),
                ],
              ),
            ] else ...[
              Card(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Thanks for voting! You chose: $_userVote',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      _buildStatBar('Family', _familyVotes, Colors.blue),
                      const SizedBox(height: 8),
                      _buildStatBar('Friends', _friendsVotes, Colors.green),
                      const SizedBox(height: 8),
                      _buildStatBar('Both', _bothVotes, Colors.purple),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildPerspectiveCard(BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required List<String> points,
  }) {
    return Card(
      elevation: 2,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 32),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...points.map((point) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Expanded(child: Text(point, style: const TextStyle(fontSize: 15))),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBar(String label, int votes, Color color) {
    final total = _friendsVotes + _familyVotes + _bothVotes;
    final percentage = total == 0 ? 0.0 : votes / total;
    
    return Row(
      children: [
        SizedBox(width: 80, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500))),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                widthFactor: percentage,
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 40,
          child: Text('${(percentage * 100).toStringAsFixed(1)}%'),
        ),
      ],
    );
  }
}

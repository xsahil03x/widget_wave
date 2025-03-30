import 'package:flutter/material.dart';
import 'package:flex_grid/flex_grid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flex Grid Example',
      theme: ThemeData.light(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flex Grid Example'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Basic Grid (2x2)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: FlexGrid(
              pattern: const [
                [1, 1],
                [1, 1],
              ],
              spacing: 8,
              runSpacing: 8,
              children: const [
                ColoredContainer(color: Colors.red),
                ColoredContainer(color: Colors.blue),
                ColoredContainer(color: Colors.green),
                ColoredContainer(color: Colors.yellow),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Custom Pattern (1x2, 2x1)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: FlexGrid(
              pattern: const [
                [1, 1],
                [2],
              ],
              spacing: 8,
              runSpacing: 8,
              children: const [
                ColoredContainer(color: Colors.purple),
                ColoredContainer(color: Colors.orange),
                ColoredContainer(color: Colors.teal),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'With Max Children (Shows +2 overlay)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: FlexGrid(
              pattern: const [
                [1, 1],
                [1, 1],
                [1, 1],
              ],
              spacing: 8,
              runSpacing: 8,
              maxChildren: 4,
              children: const [
                ColoredContainer(color: Colors.red),
                ColoredContainer(color: Colors.blue),
                ColoredContainer(color: Colors.green),
                ColoredContainer(color: Colors.yellow),
                ColoredContainer(color: Colors.purple),
                ColoredContainer(color: Colors.orange),
              ],
              overlayBuilder: (context, remaining) {
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '+$remaining',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'With Row Flex (3:1 ratio)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: FlexGrid(
              pattern: const [
                [1, 1],
                [1, 1],
              ],
              spacing: 8,
              runSpacing: 8,
              runPattern: const [3, 1],
              children: const [
                ColoredContainer(color: Colors.red),
                ColoredContainer(color: Colors.blue),
                ColoredContainer(color: Colors.green),
                ColoredContainer(color: Colors.yellow),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ColoredContainer extends StatelessWidget {
  const ColoredContainer({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

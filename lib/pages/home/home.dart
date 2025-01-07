import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bem-vindo'),
      ),
      body: const Center(
        child: Text(
          'Bem-vindo ao Kumbuz App!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

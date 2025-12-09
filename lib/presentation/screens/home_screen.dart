import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            Text('Welcome to the Home Screen!'),
        
            ElevatedButton(
              onPressed: () => context.go('/project'),
              child: const Text('Go to Project Screen'),
            ),
        
          ]
        ),
      )
    );
  }

}
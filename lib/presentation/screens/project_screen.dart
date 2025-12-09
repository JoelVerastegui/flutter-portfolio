import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class ProjectScreen extends StatelessWidget {

  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            Text('Welcome to the Project Screen!'),
        
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go to Home Screen'),
            ),
        
          ]
        ),
      )
    );
  }

}
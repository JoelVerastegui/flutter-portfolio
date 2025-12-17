import 'package:flutter/material.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [

        Image.asset(
          'assets/images/mt-fuji.jpeg',
          fit: BoxFit.cover,
          width: size.width,
          height: size.height,
        ),

        Positioned.fill(
          child: Container(
            color: Colors.black45,
          ),
        ),

      ],
    );
  }
}
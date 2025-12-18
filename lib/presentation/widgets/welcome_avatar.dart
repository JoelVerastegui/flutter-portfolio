import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

class WelcomeAvatar extends StatefulWidget {

  const WelcomeAvatar({ super.key });

  @override
  State<WelcomeAvatar> createState() => _WelcomeAvatarState();

}

class _WelcomeAvatarState extends State<WelcomeAvatar> {

  BorderRadius borderRadiusAnimation = BorderRadius.circular(20.0);
  bool triggerPulse = false;
  List<Color> colors = [
    Color(0xFF0C9092),
    Color(0xFF1F9C92),
    Color(0xFF32A892),
    Color(0xFF45B492),
    Color(0xFF59C191),
    Color(0xFF6CCD91),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 50.0),
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
        
            ...colors.asMap().entries.map((entry) {
              return _AnimatedSquares(
                index: entry.key,
                color: entry.value,
              )
              .pulse(
                animate: triggerPulse,
                duration: const Duration(milliseconds: 200),
                from: 1.0,
                to: 1.1,
                onFinish: (_) => setState(() => triggerPulse = false),
              );
            }).toList().reversed,
          
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 20.0,
              height: 20.0,
              decoration: BoxDecoration(
                color: Color(0xFFE8EAED),
                borderRadius: borderRadiusAnimation,
              ),
            )
            .zoomIn(
              duration: const Duration(milliseconds: 400),
            )
            .pulse(
              duration: const Duration(milliseconds: 600),
              onFinish: (_) {
                setState(() => borderRadiusAnimation = BorderRadius.circular(5.0));
              }
            )
            .spinPerfect(
              delay: const Duration(milliseconds: 1200),
              curve: Curves.easeOutQuint,
              duration: const Duration(milliseconds: 3000),
            ),
        
            GestureDetector(
              onTap: triggerPulseAnimation,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(190.0),
                child: Image.asset(
                  'assets/images/face.jpg',
                  width: 190.0,
                ),
              )
              .zoomIn(
                delay: const Duration(milliseconds: 1500),
              ),
            ),
        
          ],
        ),
      ),
    );
  }

  Future<void> triggerPulseAnimation() async {
    if (triggerPulse) return;
    setState(() => triggerPulse = true);
  }

}

class _AnimatedSquares extends StatelessWidget {

  final int index;
  final Color color;

  const _AnimatedSquares({
    required this.index,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 20.0 * index,
      child: Container(
        width: 20.0 * (index + 10),
        height: 20.0 * (index + 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5.0),
        ),
      )
      .zoomIn(
        delay: const Duration(milliseconds: 1200),
        duration: const Duration(milliseconds: 1500),
      )
      .spinPerfect(
        curve: Curves.easeOutQuint,
        duration: const Duration(milliseconds: 3000),
      )
      .spinPerfect(
        duration: const Duration(minutes: 5),
        infinite: true
      ),
    );
  }

}
import 'package:flutter/material.dart';

class AnimatedAvatars extends StatefulWidget {
  final List<Person> participants;

  AnimatedAvatars({required this.participants});

  @override
  _AnimatedAvatarsState createState() => _AnimatedAvatarsState();
}

class _AnimatedAvatarsState extends State<AnimatedAvatars> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Stack(
        clipBehavior: Clip.none,
        children: List.generate(widget.participants.length, (index) {
          final person = widget.participants[index];
          final offset = index * 20.0;

          return Positioned(
            left: offset,
            child: ScaleTransition(
              scale: _animation,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xffff7f50),
                    width: 2.0,
                  ),
                ),
                child: CircleAvatar(
                  backgroundImage: AssetImage(person.imageUrl),
                  radius: 20,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class Person {
  final String name;
  final String imageUrl;

  Person(this.name, this.imageUrl);
}

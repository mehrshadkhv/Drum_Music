import 'package:flutter/material.dart';

void main() {
  runApp(Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return getApplication();
  }
}

Widget getApplication() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Assets/Images/drum.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
          position: DecorationPosition.background,
          child: Center(child: Text('Mehrshad Khodavirdizadeh'),),
        ),
      ),
    ),
  );
}

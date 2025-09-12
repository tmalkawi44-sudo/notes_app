import 'package:flutter/material.dart';

class FirstnotePage extends StatelessWidget {
  const FirstnotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Create your own list', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}

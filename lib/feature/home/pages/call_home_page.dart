import 'package:flutter/material.dart';

class CallHomePage extends StatelessWidget {
  const CallHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Call Home Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.call),
      ),
    );
  }
}

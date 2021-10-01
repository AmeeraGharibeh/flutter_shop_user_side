import 'package:flutter/material.dart';

class errorPage extends StatefulWidget {
  @override
  _errorPageState createState() => _errorPageState();
}

class _errorPageState extends State<errorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Not Found'),
      ),
    );
  }
}

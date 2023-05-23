import 'package:flutter/material.dart';
class DetailScreen extends StatefulWidget {


  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(data.toString() ?? "Test"),
      ),
      body:  Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context,true);
          },
          child: Text("Pop"),
        ),
      ),
    );
  }
}

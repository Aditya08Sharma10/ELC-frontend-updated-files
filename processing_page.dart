import 'package:flutter/material.dart';
import 'form_page.dart'; // replace this with the correct path if needed

class ProcessingPage extends StatefulWidget {
  const ProcessingPage({super.key});

  @override
  ProcessingPageState createState() => ProcessingPageState();
}

class ProcessingPageState extends State<ProcessingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyFormInImageApp()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/2.png'), // Replace with your image path
              fit: BoxFit.contain, // Keep image aspect ratio
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DetailNotePage extends StatefulWidget {
  const DetailNotePage({super.key});

  @override
  State<DetailNotePage> createState() => _DetailNotePageState();
}

class _DetailNotePageState extends State<DetailNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // SizedBox(height: 10),
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: const Color(0xffc5c5c5),
                ),
              ),
              child: Image.asset(
                'images/1.png',
                fit: BoxFit.cover,
                height: 100,
                width: double.infinity,
              ),
            )
          ],
        ),
      ),
    );
  }
}

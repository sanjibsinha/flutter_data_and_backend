import 'package:flutter/material.dart';
import 'package:flutter_data_and_backend/view/future_dark.dart';

import 'model/user.dart';

void main() {
  runApp(const MyApp());
}

/// we're now in branch six
///
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'data',
      home: MyAppHome(),
    );
  }
}

class MyAppHome extends StatefulWidget {
  const MyAppHome({Key? key}) : super(key: key);

  @override
  State<MyAppHome> createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<MyAppHome> {
  final List<User> usersList = [];

  final nameController = TextEditingController();

  void addName(String name) {
    final user = User(
      name: name,
    );
    setState(() {
      usersList.add(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('data'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              child: Card(
                elevation: 10,
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'ITEM',
                        suffixStyle: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      controller: nameController,
                    ),
                    TextButton(
                      onPressed: () {
                        addName(
                          nameController.text,
                        );
                      },
                      child: const Text(
                        'SUBMIT',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: usersList.map((e) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 10,
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FutureDark(
                                      name: e.name,
                                    ),
                                  ),
                                );
                              },
                              child: const Text('data'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

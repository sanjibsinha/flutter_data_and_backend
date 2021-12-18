import 'package:flutter/material.dart';

import 'package:flutter_data_and_backend/model/database_handler.dart';

import 'model/user.dart';

void main() {
  runApp(const MyApp());
}

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

class FutureDark extends StatefulWidget {
  const FutureDark({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  State<FutureDark> createState() => _FutureDarkState();
}

class _FutureDarkState extends State<FutureDark> {
  late DatabaseHandler handler;
  @override
  Widget build(BuildContext context) {
    late List<User> usersList = [
      User(name: widget.name),
    ];

    @override
    // ignore: unused_element
    void initState() {
      Future<int> addUsers() async {
        return await handler.insertUser(usersList);
      }

      super.initState();

      handler.initializeDB().whenComplete(() async {
        await addUsers();
        setState(() {});
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('data'),
      ),
      body: FutureBuilder(
        future: handler.retrieveUsers(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    key: ValueKey<int>(snapshot.data![index].id!),
                    contentPadding: const EdgeInsets.all(8.0),
                    title: Text(
                      snapshot.data![index].name,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_data_and_backend/model/database_handler.dart';
import 'package:flutter_data_and_backend/model/user.dart';

class UserFirstPage extends StatefulWidget {
  const UserFirstPage({Key? key}) : super(key: key);

  @override
  _UserFirstPageState createState() => _UserFirstPageState();
}

class _UserFirstPageState extends State<UserFirstPage> {
  final List<User> usersList = [];
  final nameController = TextEditingController();
  late DatabaseHandler handler;

  void addName(String name) {
    final user = User(
      name: name,
    );
    setState(() {
      usersList.add(user);
      usersList;
    });
  }

  @override
  void initState() {
    Future<int> addUsers() async {
      return await handler.insertUser(usersList.toList());
    }

    super.initState();
    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {
      await addUsers();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
    );
  }
}

/**
 * FutureBuilder(
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
    );
 */

/**
 * Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'NAME',
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
    );
 */

import 'package:flutter/material.dart';

import 'package:flutter_data_and_backend/model/database_handler.dart';
import 'package:flutter_data_and_backend/model/user.dart';

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
  void initState() {
    List<User> users = [
      User(name: widget.name.toString()),
    ];
    Future<int> addUsers() async {
      return await handler.insertUser(users);
    }

    super.initState();
    handler = DatabaseHandler();
    handler!.initializeDB().whenComplete(() async {
      await addUsers();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Showing Data'),
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

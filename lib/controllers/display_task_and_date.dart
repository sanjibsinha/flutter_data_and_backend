import 'package:flutter/material.dart';
import 'package:flutter_data_and_backend/model/user.dart';

Column displayTaskAndDate(User e) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          border: Border.all(
            color: Colors.red,
            width: 5,
          ),
        ),
        child: Card(
          child: Text(
            e.name,
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                backgroundColor: Colors.blue[100]),
          ),
        ),
      ),
    ],
  );
}

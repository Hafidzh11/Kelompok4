import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailPage extends StatefulWidget {
  final int userId;
  DetailPage({required this.userId});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Map user = {};

  @override
  void initState() {
    super.initState();
    fetchUserDetail();
  }

  fetchUserDetail() async {
    var response = await http
        .get(Uri.parse('https://reqres.in/api/users/${widget.userId}'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        user = data['data'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Detail')),
      body: user.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${user['first_name']} ${user['last_name']}'),
                  Text('Email: ${user['email']}'),
                  // Tambahkan data lainnya sesuai kebutuhan
                ],
              ),
            ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ayurvan/Authentication/repository/authentication_repo.dart';

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('User List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // Use the logout method from the AuthenticationRepo
              await AuthenticationRepo.instance.logOut();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchuser,
        child: const Icon(Icons.refresh),
      ),
      body: users.isEmpty
          ? const Center(child: Text('No user Found'))
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        '${users[index]['name']['first']} ${users[index]['name']['last']}',
                        style: const TextStyle(color: Colors.blue),
                      ),
                      subtitle: Text(users[index]['email']),
                      tileColor: const Color.fromARGB(255, 252, 169, 196),
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/auth.png'),
                        radius: 35,
                      ),
                    ),
                    const Divider(height: 0, thickness: 1, color: Colors.white),
                  ],
                );
              },
            ),
    );
  }

  void fetchuser() async {
    print('userfetched');
    const url = 'https://randomuser.me/api/?results=5000';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    setState(() {
      users = json['results'];
    });
    print('userfetched completed');
  }
}

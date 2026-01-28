import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_ad_2/vieew/task_screen_ui.dart';
import 'package:sqlite_ad_2/view_model/user_view_model.dart';

import '../data/models/user_model.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<UserViewModel>().fetchUsers();
  }

  void _addUser() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();

    if (name.isEmpty || email.isEmpty) return;

    context.read<UserViewModel>().addUser(User(name: name, email: email));

    _nameController.clear();
    _emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final userVM = context.watch<UserViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task Management App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff116b98),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add member by entering his details:',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    hintStyle: TextStyle(fontSize: 13),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(fontSize: 13),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.topRight,
                  child: MaterialButton(
                    color: Colors.blue,
                    onPressed: _addUser,
                    child: const Text('Add'),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: userVM.users.length,
              itemBuilder: (context, index) {
                final user = userVM.users[index];

                return Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 13),
                  child: ListTile(
                    tileColor: Color(0xff116b98),
                    title: Text(
                      user.name,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      user.email,
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        userVM.removeUser(user.id!);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TaskScreen(user: user),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

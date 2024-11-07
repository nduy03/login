import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

// Màn hình đăng nhập
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login() {
    String email = emailController.text;
    String password = passwordController.text;

    if (!_isValidEmail(email)) {
      _showDialog('Email sai định dạng');
    } else if (email.length<6 || password.length<6) {
      _showDialog('Username hoặc pass không hợp lệ');
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListViewScreen(),
        ),
      );
    }
  }

  bool _isValidEmail(String email) {
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Icon(
                Icons.person,
                size: 100,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Nhập email:',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Nhập password:',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

// Màn hình hiển thị cả ListView tĩnh và động với chức năng hiển thị thông tin người dùng
class ListViewScreen extends StatelessWidget {
  final List<Map<String, String>> dynamicUsers = [
    {'name': 'User A', 'email': 'userA@gmail.com'},
    {'name': 'User B', 'email': 'userB@gmail.com'},
    {'name': 'User C', 'email': 'userC@gmail.com'},
  ];

  void _showUserInfo(BuildContext context, String name, String email) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Thông tin người dùng'),
        content: Text('Tên: $name\nEmail: $email'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Tĩnh và Động'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('User 1 (Tĩnh)'),
                  subtitle: Text('Email: user1@gmail.com'),
                  onTap: () {
                    _showUserInfo(context, 'User 1 (Tĩnh)', 'user1@egmail.com');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('User 2 (Tĩnh)'),
                  subtitle: Text('Email: user2@gmail.com'),
                  onTap: () {
                    _showUserInfo(context, 'User 2 (Tĩnh)', 'user2@gmail.com');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('NGUYEN 3 (Tĩnh)'),
                  subtitle: Text('Email: user3@gmail.com'),
                  onTap: () {
                    _showUserInfo(context, 'User 3 (Tĩnh)', 'user3@gmail.com');
                  },
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: dynamicUsers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text(dynamicUsers[index]['name']!),
                  subtitle: Text('Email: ${dynamicUsers[index]['email']}'),
                  onTap: () {
                    _showUserInfo(
                      context,
                      dynamicUsers[index]['name']!,
                      dynamicUsers[index]['email']!,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

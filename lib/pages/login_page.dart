import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/state_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() =>
      _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController =
      TextEditingController();
  final _passwordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đăng nhập')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  labelText: 'Mật khẩu'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final email =
                    _emailController.text.trim();
                final pass =
                    _passwordController.text;
                Provider.of<StateProvider>(
                        context,
                        listen: false)
                    .login(email, pass);
                Navigator.pop(context);
              },
              child: Text('Đăng nhập'),
            ),
          ],
        ),
      ),
    );
  }
}

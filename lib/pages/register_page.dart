import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/state_provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() =>
      _RegisterPageState();
}

class _RegisterPageState
    extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController =
      TextEditingController();
  final _passwordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đăng ký')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                  labelText: 'Họ và tên'),
            ),
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
                final name =
                    _nameController.text.trim();
                final email =
                    _emailController.text.trim();
                final pass =
                    _passwordController.text;
                Provider.of<StateProvider>(
                        context,
                        listen: false)
                    .register(name, email, pass);
                Navigator.pop(context);
              },
              child: Text('Đăng ký'),
            ),
          ],
        ),
      ),
    );
  }
}

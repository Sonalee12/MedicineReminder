import 'package:flutter/material.dart';
import 'package:medicine_reminder/controller/controller.dart';
import 'package:medicine_reminder/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _passwordVisible = false;

  void _register() async {
    if (_formKey.currentState!.validate()) {
      final user = UserModel(
        email: _emailController.text.trim(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Register the user
      final success = await _authController.registerUser(user);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration successful!')),
        );

        // Save login status to shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        Navigator.pushNamed(context, '/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email already exists!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Icon(
                Icons.medical_services,
                size: 50,
                color: Colors.blue,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email, color: Colors.blue),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                ),
                validator: (value) {
                  if (value!.isEmpty) return 'Enter your email';
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  prefixIcon: Icon(Icons.person, color: Colors.blue),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                ),
                validator: (value) => value!.isEmpty ? 'Enter your first name' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  prefixIcon: Icon(Icons.person, color: Colors.blue),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                ),
                validator: (value) => value!.isEmpty ? 'Enter your last name' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _passwordController,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock, color: Colors.blue),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) return 'Enter your password';
                  if (value.length < 6) return 'Password must be at least 6 characters';
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                child: Text('Register'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                child: Text('Already have an account? Sign in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

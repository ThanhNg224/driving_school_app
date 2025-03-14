import 'package:flutter/material.dart';
import 'video_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;
  bool _isLoading = false;
  int _tapCount = 0; // Counter for logo taps

  // Hard-coded credentials
  final String validUsername1 = 'admin';
  final String validPassword1 = '1234';
  final String validUsername2 = '0';
  final String validPassword2 = '0';

  void _login() {
    if (_formKey.currentState!.validate()) {
      if ((_usernameController.text == validUsername1 && _passwordController.text == validPassword1) ||
          (_usernameController.text == validUsername2 && _passwordController.text == validPassword2)) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const VideoScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid credentials'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _handleLogoTap() {
    setState(() => _tapCount++);
    
    if (_tapCount == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const VideoScreen()),
      );
      _tapCount = 0; // Reset counter after navigation
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${4 - _tapCount} taps left to shortcut'),
          duration: const Duration(milliseconds: 300),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade300, Colors.blue.shade700],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Logo with secret tap shortcut
                          GestureDetector(
                            onTap: _handleLogoTap,
                            child: const CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.blue,
                              child: Icon(
                                Icons.drive_eta,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Rest of the login form remains the same...
                          const Text(
                            'Driving School',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 32),
                          TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) =>
                                value == null || value.isEmpty ? 'Please enter username' : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            obscureText: true,
                            validator: (value) =>
                                value == null || value.isEmpty ? 'Please enter password' : null,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = value ?? false;
                                  });
                                },
                              ),
                              const Text('Remember me'),
                              const Spacer(),
                              TextButton(
                                onPressed: () {},
                                child: const Text('Forgot Password?'),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : () async {
                                setState(() => _isLoading = true);
                                await Future.delayed(const Duration(seconds: 2));
                                _login();
                                setState(() => _isLoading = false);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.5,
                                      ),
                                    )
                                  : const Text(
                                      'LOGIN',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account?'),
                              TextButton(
                                onPressed: () {},
                                child: const Text('Sign Up'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
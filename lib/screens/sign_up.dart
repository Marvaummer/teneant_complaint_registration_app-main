import 'package:flutter/material.dart';
import 'package:teneant_complaint_registration_app/screens/sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/signup.jpg', // Add your background image path here
              fit: BoxFit.cover,
            ),
          ),
          // Semi-transparent overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5), // Adjust opacity as needed
            ),
          ),
          // Form content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Sign up to',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // White text for contrast
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Ezdan Real Estate',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // White text for contrast
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  const Text(
                    'Title',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White text for contrast
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Mr.', child: Text('Mr.')),
                      DropdownMenuItem(value: 'Ms.', child: Text('Ms.')),
                      DropdownMenuItem(value: 'Mrs.', child: Text('Mrs.')),
                    ],
                    onChanged: (value) {}, // Implement your logic here
                  ),
                  const SizedBox(height: 20.0),
                  _buildTextField('Full Name'),
                  const SizedBox(height: 20.0),
                  _buildTextField('Phone Number', TextInputType.phone),
                  const SizedBox(height: 20.0),
                  _buildTextField('Email', TextInputType.emailAddress),
                  const SizedBox(height: 20.0),
                  _buildTextField('Contract Number'),
                  const SizedBox(height: 20.0),
                  _buildTextField('Password', TextInputType.text, true),
                  const SizedBox(height: 20.0),
                  _buildTextField('Confirm Password', TextInputType.text, true),
                  const SizedBox(height: 50.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignIn())),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Button color
                        padding: EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 15,
                        ),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 50.0),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignIn()),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            TextSpan(
                              text: 'Sign in',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String labelText, [TextInputType keyboardType = TextInputType.text, bool obscureText = false]) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        fillColor: Colors.white.withOpacity(0.8), // Light background for text fields
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }
}

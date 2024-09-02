import 'package:flutter/material.dart';
import 'package:teneant_complaint_registration_app/screens/sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _obscureText = true;
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

                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8), // Similar to the fill color in InputDecoration
                        borderRadius: BorderRadius.circular(15), // Optional: Add border radius
                       // border: Border.all(color: Colors.grey), // Optional: Add border color
                      ),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          hintText: 'Title',
                          hintStyle: const TextStyle(color: Color(0xFFF27272a),),
                          prefixIcon: Icon(Icons.female_outlined, color: Color(0xFFF27272a),),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none, // Remove the default border
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none, // Remove the focused border
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'Mr.', child: Text('Mr.')),
                          DropdownMenuItem(value: 'Ms.', child: Text('Ms.')),
                          DropdownMenuItem(value: 'Mrs.', child: Text('Mrs.')),
                        ],
                        onChanged: (value) {
                          // Implement your logic here
                        },
                      ),
                    ),
                  ),


                  _buildTextField(
              label: "Full Name",
              icon: Icons.person,
              obscureText: false,
            ),
                  _buildTextField(
                    label: "Phone Number",
                    icon: Icons.phone,
                    obscureText: false,
                  ),

                  _buildTextField(
                    label: "Email",
                    icon: Icons.email,
                    obscureText: false,
                  ),

                  _buildTextField(
                    label: "Contact Number",
                    icon: Icons.phone_android,
                    obscureText: false,
                  ),

             _buildTextField(
              label: "Password",
              icon: Icons.lock,
              obscureText: _obscureText,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: const Color(0xFFF27272a),
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
                  _buildTextField(
                    label: "Confirm Password",
                    icon: Icons.lock,
                    obscureText: _obscureText,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: const Color(0xFFF27272a),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
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
  Widget _buildTextField({
    required String label,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextFormField(
          obscureText: obscureText,
          style: const TextStyle(color: Color(0xFFF27272a),),
          decoration: InputDecoration(
            hintText: label,
            hintStyle: const TextStyle(color: Color(0xFFF27272a),),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Icon(icon, color: Color(0xFFF27272a),),
            ),
            suffixIcon: suffixIcon,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

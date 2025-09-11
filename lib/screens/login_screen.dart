import 'package:my_app/screens/login_email_password_screen.dart';
import 'package:my_app/screens/phone_screen.dart';
import 'package:my_app/screens/signup_email_password_screen.dart';
import 'package:my_app/services/firebase_auth_methods.dart';
import 'package:my_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6D5DF6), Color(0xFF42A5F5), Color(0xFF00BFAE)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 12,
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.lock_outline, size: 64, color: Color(0xFF6D5DF6)),
                    SizedBox(height: 16),
                    Text('Login to Your Account', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 24),
                    CustomButton(
                      onTap: () {
                        Navigator.pushNamed(context, EmailPasswordSignup.routeName);
                      },
                      text: 'Sign Up with Email',
                      icon: Icons.email,
                    ),
                    SizedBox(height: 12),
                    CustomButton(
                      onTap: () {
                        Navigator.pushNamed(context, EmailPasswordLogin.routeName);
                      },
                      text: 'Login with Email',
                      icon: Icons.login,
                    ),
                    SizedBox(height: 12),
                    CustomButton(
                      onTap: () {
                        Navigator.pushNamed(context, PhoneScreen.routeName);
                      },
                      text: 'Sign In with Phone',
                      icon: Icons.phone,
                    ),
                    SizedBox(height: 12),
                    CustomButton(
                      onTap: () {
                        context.read<FirebaseAuthMethods>().signInWithGoogle(context);
                      },
                      text: 'Sign In with Google',
                      icon: Icons.g_mobiledata,
                    ),
                    SizedBox(height: 12),
                    CustomButton(
                      onTap: () {
                        context.read<FirebaseAuthMethods>().signInAnonymously(context);
                      },
                      text: 'Anonymous Sign In',
                      icon: Icons.person_outline,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

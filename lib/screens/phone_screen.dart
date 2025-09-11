import 'package:my_app/services/firebase_auth_methods.dart';
import 'package:my_app/widgets/custom_button.dart';
import 'package:my_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneScreen extends StatefulWidget {
  static String routeName = '/phone';
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final TextEditingController phoneController = TextEditingController();

  String? errorText;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            controller: phoneController,
            hintText: 'Enter phone number',
            keyboardType: TextInputType.number,
            maxLength: 10,
            errorText: errorText,
          ),
          CustomButton(
            onTap: () {
              String phone = phoneController.text.trim();
              if (phone.length != 10 || int.tryParse(phone) == null) {
                setState(() {
                  errorText = 'Please enter a valid 10 digit mobile number';
                });
                return;
              }
              setState(() {
                errorText = null;
              });
              String formattedPhone = '+91$phone';
              context
                  .read<FirebaseAuthMethods>()
                  .phoneSignIn(context, formattedPhone);
            },
            text: 'OK',
          ),
        ],
      ),
    );
  }
}

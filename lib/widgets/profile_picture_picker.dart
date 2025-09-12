// lib/widgets/profile_picture_picker.dart

import 'package:flutter/material.dart';

class ProfilePicturePicker extends StatelessWidget {
  const ProfilePicturePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/images/user.png'), // Add a default user image here
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  // TODO: Implement image picking logic
                },
                icon: const Icon(Icons.camera_alt),
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
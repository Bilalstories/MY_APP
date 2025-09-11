import 'package:flutter/material.dart';

class OnboardingTips extends StatefulWidget {
  final VoidCallback onFinish;
  const OnboardingTips({Key? key, required this.onFinish}) : super(key: key);

  @override
  State<OnboardingTips> createState() => _OnboardingTipsState();
}

class _OnboardingTipsState extends State<OnboardingTips> {
  int _current = 0;
  final List<Map<String, dynamic>> tips = [
    {
      'title': 'Welcome!',
      'desc': 'Yahan se aap government aur online services le sakte hain.',
      'icon': Icons.verified_user,
    },
    {
      'title': 'Categories',
      'desc': 'Home screen par sabhi categories milengi. Kisi bhi category par click karein.',
      'icon': Icons.category,
    },
    {
      'title': 'Services',
      'desc': 'Category select karne par uske andar ki services, fees aur form milenge.',
      'icon': Icons.miscellaneous_services,
    },
    {
      'title': 'Form Fill',
      'desc': 'Service select karne ke baad form fill karein. Sabhi details sahi se bharna zaruri hai.',
      'icon': Icons.edit_document,
    },
    {
      'title': 'Tracking ID',
      'desc': 'Form submit karte hi aapko ek unique Tracking ID milegi. Isse aap apna status check kar sakte hain.',
      'icon': Icons.qr_code,
    },
    {
      'title': 'WhatsApp Share',
      'desc': 'Form submit hone ke baad WhatsApp khulega, jisme sari details prefill hongi. Bas send karna hai.',
      'icon': Icons.message,
    },
    {
      'title': 'Payment',
      'desc': 'Har service ke form ke niche UPI payment option milega. Payment karne ke baad process complete ho jayega.',
      'icon': Icons.payment,
    },
    {
      'title': 'Profile',
      'desc': 'Profile section me apni details dekh/safe/edit kar sakte hain.',
      'icon': Icons.person,
    },
    {
      'title': 'Help & Policy',
      'desc': 'Menu bar se Help, Privacy Policy, Terms, aur Helpline access kar sakte hain.',
      'icon': Icons.help_outline,
    },
  ];

  void _next() {
    if (_current < tips.length - 1) {
      setState(() {
        _current++;
      });
    } else {
      widget.onFinish();
    }
  }

  void _skip() {
    widget.onFinish();
  }

  @override
  Widget build(BuildContext context) {
    final tip = tips[_current];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(tip['icon'], size: 48, color: Colors.deepPurple),
                  SizedBox(height: 16),
                  Text(tip['title']!, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  Text(tip['desc']!, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: _skip,
                        child: Text('Skip'),
                      ),
                      ElevatedButton(
                        onPressed: _next,
                        child: Text(_current < tips.length - 1 ? 'Next' : 'Finish'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

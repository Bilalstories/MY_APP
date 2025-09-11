import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  final Function(int) onTap;
  final int selectedIndex;
  const MainMenu({Key? key, required this.onTap, required this.selectedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.miscellaneous_services), label: 'Services'),
        BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'Schemes'),
        BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: 'Govt Services'),
        BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Banks'),
        BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Wallet'),
      ],
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    );
  }
}

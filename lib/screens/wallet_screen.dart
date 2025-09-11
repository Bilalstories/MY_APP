import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double _balance = 0;
  List<String> _history = [];
  String? _pin;

  @override
  void initState() {
    super.initState();
    _loadWallet();
  }

  Future<void> _loadWallet() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _balance = prefs.getDouble('wallet_balance') ?? 0;
      _history = prefs.getStringList('wallet_history') ?? [];
      _pin = prefs.getString('wallet_pin');
    });
  }

  Future<void> _addMoney(double amount) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _balance += amount;
      _history.add('Wallet Top-up: ₹$amount on ${DateTime.now()}');
    });
    await prefs.setDouble('wallet_balance', _balance);
    await prefs.setStringList('wallet_history', _history);
  }

  Future<void> _setPin() async {
    final pinController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Set Wallet PIN'),
        content: TextField(
          controller: pinController,
          keyboardType: TextInputType.number,
          maxLength: 4,
          decoration: InputDecoration(hintText: 'Enter 4-digit PIN'),
        ),
        actions: [
          TextButton(
            child: Text('Save'),
            onPressed: () async {
              if (pinController.text.length == 4) {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('wallet_pin', pinController.text);
                setState(() {
                  _pin = pinController.text;
                });
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  Future<bool> _verifyPin() async {
    final pinController = TextEditingController();
    bool verified = false;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Enter Wallet PIN'),
        content: TextField(
          controller: pinController,
          keyboardType: TextInputType.number,
          maxLength: 4,
          decoration: InputDecoration(hintText: 'Enter 4-digit PIN'),
        ),
        actions: [
          TextButton(
            child: Text('Verify'),
            onPressed: () {
              if (pinController.text == _pin) {
                verified = true;
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
    return verified;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Wallet')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Wallet Balance', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('₹${_balance.toStringAsFixed(2)}', style: TextStyle(fontSize: 28, color: Colors.deepPurple, fontWeight: FontWeight.bold)),
                    ElevatedButton.icon(
                      icon: Icon(Icons.add_circle),
                      label: Text('Add Money'),
                      onPressed: () async {
                        // Show QR/UPI payment for wallet top-up
                        // For demo, add ₹100 after payment
                        await _addMoney(100);
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            _pin == null
                ? ElevatedButton(
                    child: Text('Set Wallet PIN'),
                    onPressed: _setPin,
                  )
                : SizedBox.shrink(),
            SizedBox(height: 24),
            Text('Transaction History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: _history.map((e) => ListTile(
                  leading: Icon(Icons.account_balance_wallet, color: Colors.deepPurple),
                  title: Text(e),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

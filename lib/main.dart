import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shared Preferences Demo',
      home: const UsernamePage(),
      
    );
  }
}
class UsernamePage extends StatefulWidget {
  const UsernamePage({super.key});

  @override
  State<UsernamePage> createState() => _UsernamePageState();
}
class _UsernamePageState extends State<UsernamePage> {
  final TextEditingController _controller =
      TextEditingController();
  String _savedUsername = '';
    @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

 Future<void> _saveUsername() async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString(
    'username',
    _controller.text,
  );

  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Username saved successfully!'),
    ),
  );
}
  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();

    final username = prefs.getString('username') ?? '';

    if (!mounted) return;

    setState(() {
      _savedUsername = username;
      _controller.text = username;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preferences Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveUsername,
              child: const Text('Save Username'),
            ),
          ],
        ),
      ),
    );
  }
}
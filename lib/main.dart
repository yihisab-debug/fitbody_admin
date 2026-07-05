import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'src/auth_gate.dart';
import 'src/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    runApp(const FitBodyAdminApp());
  } catch (e, s) {
    runApp(_ErrorApp(error: '$e', stack: '$s'));
  }
}

class FitBodyAdminApp extends StatelessWidget {
  const FitBodyAdminApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitBody Admin',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const AuthGate(),
    );
  }
}

class _ErrorApp extends StatelessWidget {
  final String error;
  final String stack;
  const _ErrorApp({required this.error, required this.stack});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.red.shade900,
          title: const Text('Ошибка запуска Firebase'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Firebase не инициализировался. Проверь google-services.json, '
                  'flutterfire configure и gradle-плагин.\n',
                  style: TextStyle(color: Colors.orangeAccent, fontSize: 14),
                ),
                Text(error,
                    style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Text(stack,
                    style: const TextStyle(color: Colors.white54, fontSize: 11)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

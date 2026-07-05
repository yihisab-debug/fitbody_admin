import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthService();
  bool _loading = false;
  String? _error;

  Future<void> _signIn() async {
    setState(() { _loading = true; _error = null; });
    try {
      await _auth.signInWithGoogle();
    } catch (e) {
      setState(() => _error = 'Не удалось войти. Попробуйте ещё раз.\n($e)');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(fontSize: 42, fontWeight: FontWeight.w900),
                  children: [
                    TextSpan(text: 'F', style: TextStyle(color: AppColors.purple)),
                    TextSpan(text: 'B', style: TextStyle(color: AppColors.lime)),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              const Text('FITBODY · ADMIN',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textSecondary,
                      letterSpacing: 3, fontWeight: FontWeight.bold)),
              const SizedBox(height: 48),
              const Text('Панель администратора',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 15)),
              const SizedBox(height: 40),
              if (_loading)
                const Center(child: CircularProgressIndicator())
              else
                ElevatedButton.icon(
                  onPressed: _signIn,
                  icon: const Icon(Icons.admin_panel_settings),
                  label: const Text('Войти через Google'),
                ),
              if (_error != null) ...[
                const SizedBox(height: 20),
                Text(_error!, textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.redAccent)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

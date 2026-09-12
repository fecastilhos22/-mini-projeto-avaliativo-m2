import 'package:flutter/material.dart';
import '../data/repositories/session_repository.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SessionRepository _sessionRepository = SessionRepository();

  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    final hasSession = await _sessionRepository.hasSession();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, hasSession ? '/home' : '/login');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
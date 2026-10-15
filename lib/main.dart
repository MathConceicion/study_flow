import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'screens/auth_gate.dart';
import 'screens/splash_page.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const StudyFlowApp());
}

class StudyFlowApp extends StatefulWidget {
  const StudyFlowApp({super.key});
  @override
  State<StudyFlowApp> createState() => _StudyFlowAppState();
}

class _StudyFlowAppState extends State<StudyFlowApp> {
  late Future<void> _inicio;

  @override
  void initState() {
    super.initState();
    _inicio = _inicializar();
  }

  Future<void> _inicializar() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudyFlow',
      debugShowCheckedModeBanner: false,
      theme: criarTema(),
      home: FutureBuilder<void>(
        future: _inicio,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const SplashPage();
          }
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: FilledButton(
                  onPressed: () => setState(() => _inicio = _inicializar()),
                  child: const Text('Falha ao iniciar. Tentar novamente'),
                ),
              ),
            );
          }
          return const AuthGate();
        },
      ),
    );
  }
}

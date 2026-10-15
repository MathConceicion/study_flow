import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'acesso_page.dart';
import 'home_page.dart';
import 'splash_page.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  late final Stream<User?> _sessao;

  @override
  void initState() {
    super.initState();
    _sessao = AuthService().usuario;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _sessao,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashPage();
        }
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('Falha na sessão. Reinicie o aplicativo.'),
            ),
          );
        }
        final usuario = snapshot.data;
        if (usuario == null) return const AcessoPage();
        return _AreaAutenticada(
          key: ValueKey('${usuario.uid}:${usuario.displayName ?? ''}'),
          usuario: usuario,
        );
      },
    );
  }
}

class _AreaAutenticada extends StatefulWidget {
  final User usuario;
  const _AreaAutenticada({super.key, required this.usuario});

  @override
  State<_AreaAutenticada> createState() => _AreaAutenticadaState();
}

class _AreaAutenticadaState extends State<_AreaAutenticada> {
  final _navigator = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler<Object?>(
      onPopWithResult: (resultado) {
        _navigator.currentState!.pop(resultado);
      },
      child: Navigator(
        key: _navigator,
        onGenerateRoute: (settings) => MaterialPageRoute<void>(
          settings: settings,
          builder: (context) => HomePage(usuario: widget.usuario),
        ),
      ),
    );
  }
}

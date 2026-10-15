import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'enem_page.dart';
import 'revisao_page.dart';

class HomePage extends StatelessWidget {
  final User usuario;
  const HomePage({super.key, required this.usuario});

  Future<void> _sair(BuildContext context) async {
    try {
      await AuthService().sair();
    } catch (erro) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Não foi possível sair. Tente novamente.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final nome = usuario.displayName?.trim();
    final saudacao = nome == null || nome.isEmpty ? 'estudante' : nome;
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudyFlow'),
        actions: [
          IconButton(
            tooltip: 'Sair da conta',
            onPressed: () => _sair(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Text(
                'Olá, $saudacao!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              const Text('Como você quer estudar hoje?'),
              const SizedBox(height: 28),
              _Destino(
                titulo: 'Praticar ENEM',
                descricao:
                    'Escolha ano e área. Responda e acompanhe seus acertos.',
                icone: Icons.quiz_outlined,
                aoTocar: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EnemPage()),
                ),
              ),
              const SizedBox(height: 16),
              _Destino(
                titulo: 'Revisar conteúdos',
                descricao: 'Encontre assuntos por matéria e nível.',
                icone: Icons.menu_book_outlined,
                aoTocar: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RevisaoPage()),
                ),
              ),
              const SizedBox(height: 28),
              Text(
                usuario.email ?? '',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Destino extends StatelessWidget {
  final String titulo;
  final String descricao;
  final IconData icone;
  final VoidCallback aoTocar;
  const _Destino({
    required this.titulo,
    required this.descricao,
    required this.icone,
    required this.aoTocar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        leading: Icon(icone, size: 30),
        title: Text(titulo, style: Theme.of(context).textTheme.titleLarge),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(descricao),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: aoTocar,
      ),
    );
  }
}

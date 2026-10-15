import 'package:flutter/material.dart';
import '../data/dados_estudo.dart';
import '../widgets/materia_card.dart';
import 'materia_page.dart';

class RevisaoPage extends StatelessWidget {
  const RevisaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Revisar conteúdos')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: materias.length,
            itemBuilder: (context, index) {
              final materia = materias[index];
              return MateriaCard(
                materia: materia,
                aoTocar: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MateriaPage(materia: materia),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

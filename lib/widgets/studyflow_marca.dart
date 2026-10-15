import 'package:flutter/material.dart';

class StudyFlowMarca extends StatelessWidget {
  const StudyFlowMarca({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Icon(
            Icons.auto_stories_rounded,
            size: 44,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        Text('StudyFlow', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 6),
        const Text('Uma etapa de cada vez.'),
      ],
    );
  }
}

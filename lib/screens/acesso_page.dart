import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/studyflow_marca.dart';

class AcessoPage extends StatefulWidget {
  const AcessoPage({super.key});

  @override
  State<AcessoPage> createState() => _AcessoPageState();
}

class _AcessoPageState extends State<AcessoPage> {
  final _form = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _confirmacao = TextEditingController();
  final _auth = AuthService();
  bool _cadastro = false;
  bool _enviando = false;
  bool _ocultar = true;
  String? _erro;

  @override
  void dispose() {
    _nome.dispose();
    _email.dispose();
    _senha.dispose();
    _confirmacao.dispose();
    super.dispose();
  }

  Future<void> _enviar() async {
    if (_enviando || !_form.currentState!.validate()) return;
    setState(() {
      _enviando = true;
      _erro = null;
    });
    try {
      if (_cadastro) {
        await _auth.cadastrar(_nome.text, _email.text, _senha.text);
      } else {
        await _auth.entrar(_email.text, _senha.text);
      }
      // O AuthGate muda a tela quando a sessão muda.
    } on FirebaseAuthException catch (erro) {
      if (mounted) setState(() => _erro = _auth.mensagem(erro));
    } catch (erro) {
      if (mounted) {
        setState(() => _erro = 'Não foi possível concluir a operação.');
      }
    } finally {
      if (mounted) setState(() => _enviando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Form(
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const StudyFlowMarca(),
                    const SizedBox(height: 28),
                    Text(
                      _cadastro ? 'Crie sua conta' : 'Bem-vindo de volta',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    if (_cadastro) ...[
                      TextFormField(
                        controller: _nome,
                        enabled: !_enviando,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(labelText: 'Nome'),
                        validator: (valor) => (valor ?? '').trim().length < 2
                            ? 'Informe seu nome.'
                            : null,
                      ),
                      const SizedBox(height: 12),
                    ],
                    TextFormField(
                      controller: _email,
                      enabled: !_enviando,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      decoration: const InputDecoration(labelText: 'E-mail'),
                      validator: (valor) {
                        final email = (valor ?? '').trim();
                        return RegExp(
                              r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
                            ).hasMatch(email)
                            ? null
                            : 'Informe um e-mail válido.';
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _senha,
                      enabled: !_enviando,
                      obscureText: _ocultar,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        suffixIcon: IconButton(
                          tooltip: _ocultar ? 'Mostrar senha' : 'Ocultar senha',
                          onPressed: () => setState(() => _ocultar = !_ocultar),
                          icon: Icon(
                            _ocultar ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                      ),
                      validator: (valor) {
                        if ((valor ?? '').isEmpty) return 'Informe a senha.';
                        if (_cadastro && valor!.length < 6) {
                          return 'Use pelo menos 6 caracteres.';
                        }
                        return null;
                      },
                    ),
                    if (_cadastro) ...[
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _confirmacao,
                        enabled: !_enviando,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Confirmar senha',
                        ),
                        validator: (valor) => valor != _senha.text
                            ? 'As senhas precisam ser iguais.'
                            : null,
                      ),
                    ],
                    if (_erro != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        _erro!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: _enviando ? null : _enviar,
                      child: Text(
                        _enviando
                            ? 'Aguarde...'
                            : _cadastro
                            ? 'Criar conta'
                            : 'Entrar',
                      ),
                    ),
                    TextButton(
                      onPressed: _enviando
                          ? null
                          : () {
                              setState(() {
                                _cadastro = !_cadastro;
                                _erro = null;
                                _senha.clear();
                                _confirmacao.clear();
                              });
                              _form.currentState?.reset();
                            },
                      child: Text(
                        _cadastro
                            ? 'Já tenho uma conta'
                            : 'Quero criar uma conta',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

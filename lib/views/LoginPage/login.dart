import 'package:boravaleno/designSytem/components/ActionButton/action_button.dart';
import 'package:boravaleno/designSytem/components/ActionButton/action_button_view_model.dart';
import 'package:boravaleno/designSytem/components/InputField/input_text.dart';
import 'package:boravaleno/designSytem/components/InputField/input_text_view_model.dart';
import 'package:boravaleno/designSytem/components/LinkedLabel/linked_label.dart';
import 'package:boravaleno/designSytem/components/LinkedLabel/linked_label_view_model.dart';
import 'package:boravaleno/views/ProfilePage/profile.dart';
import 'package:boravaleno/views/SignupPage/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        print("Login realizado com sucesso");
      }
    } on FirebaseAuthException catch (e) {
      print("Erro de login: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 64),
              Container(
                margin: const EdgeInsets.only(bottom: 32),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.asset(
                  'assets/148x148.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 64),
              StyledInputField.instantiate(
                viewModel: InputTextViewModel(
                  controller: emailController,
                  placeholder: 'E-mail',
                  password: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Esse campo é obrigatório';
                    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}').hasMatch(value)) {
                      return 'Por favor, insira um e-mail válido!';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              StyledInputField.instantiate(
                viewModel: InputTextViewModel(
                  controller: passwordController,
                  placeholder: 'Password',
                  password: true,
                  suffixIcon: const Icon(Icons.remove_red_eye),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Esse campo é obrigatório';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 24),
              ActionButton.instantiate(
                viewModel: ActionButtonViewModel(
                  style: ActionButtonStyle.primary,
                  size: ActionButtonSize.large,
                  text: 'Login',
                  onPressed: login,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LinkedLabel.instantiate(
                    viewModel: LinkedLabelViewModel(
                      fullText: 'Forgot Password?',
                      linkedText: 'Clique aqui',
                      onLinkTap: () {
                        print('Esqueceu a senha?');
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Don\'t Have An Account?',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 73,
                child: ActionButton.instantiate(
                  viewModel: ActionButtonViewModel(
                    style: ActionButtonStyle.primary,
                    size: ActionButtonSize.small,
                    text: 'Sign Up',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpPage()),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 96),
            ],
          ),
        ),
      ),
    );
  }
}

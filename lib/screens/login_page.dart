import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_daily_notes/bloc/auth/auth_bloc.dart';
import 'package:flutter_daily_notes/models/user.dart';
import 'package:flutter_daily_notes/extensions/router.dart';
import 'package:flutter_daily_notes/screens/home_page.dart';
import 'package:flutter_daily_notes/screens/sign_up_page.dart';
import 'package:flutter_daily_notes/widgets/custom_account_text.dart';
import 'package:flutter_daily_notes/widgets/custom_button.dart';
import 'package:flutter_daily_notes/widgets/custom_ilustration.dart';
import 'package:flutter_daily_notes/widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (_, state) {
          final success = state.status == AuthStatus.success;

          if (success) context.offAll(const HomePage());
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: CustomIlustration(
                    imagePath: 'assets/images/schedule_meeting.png',
                    width: double.infinity,
                    height: 300,
                  ),
                ),
                const SizedBox(height: 50),
                CustomTextfield(
                  controller: _usernameController,
                  focusNode: _usernameFocusNode,
                  hintText: "Username",
                  icon: Icons.person,
                ),
                const SizedBox(height: 10),
                CustomTextfield(
                  obscureText: true,
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  hintText: "Password",
                  icon: Icons.password,
                ),
                const SizedBox(height: 8),
                CustomAccountText(
                  questionText: "Don't have an account?",
                  actionText: "Sign Up",
                  onActionTap: () => context.to(const SignUpPage()),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomButton(
                    text: "Login",
                    onPressed: () {
                      final user = User(
                        username: _usernameController.text,
                        password: _passwordController.text,
                      );
                      context.read<AuthBloc>().add(AuthLogin(user));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

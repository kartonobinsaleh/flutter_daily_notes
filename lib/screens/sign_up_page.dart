import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_daily_notes/bloc/auth/auth_bloc.dart';
import 'package:flutter_daily_notes/models/user.dart';
import 'package:flutter_daily_notes/extensions/router.dart';
import 'package:flutter_daily_notes/screens/login_page.dart';
import 'package:flutter_daily_notes/widgets/custom_account_text.dart';
import 'package:flutter_daily_notes/widgets/custom_button.dart';
import 'package:flutter_daily_notes/widgets/custom_ilustration.dart';
import 'package:flutter_daily_notes/widgets/custom_textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _passwordConfirmFocusNode = FocusNode();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernameFocusNode.addListener(() {
      setState(() {});
    });
    _passwordFocusNode.addListener(() {
      setState(() {});
    });
    _passwordConfirmFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          final success = state.status == AuthStatus.success;

          if (success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }

          if (success) context.offAll(const LoginPage());
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const CustomIlustration(
                  imagePath: 'assets/images/schedule_meeting.png',
                  height: 300,
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
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  obscureText: true,
                  hintText: "Password",
                  icon: Icons.password,
                ),
                const SizedBox(height: 10),
                CustomTextfield(
                  controller: passwordConfirmController,
                  focusNode: _passwordConfirmFocusNode,
                  obscureText: true,
                  hintText: "Password Confirm",
                  icon: Icons.password,
                ),
                const SizedBox(height: 8),
                CustomAccountText(
                  questionText: "Do you have an account?",
                  actionText: "Login",
                  onActionTap: () => Navigator.pop(context),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomButton(
                    text: "Sign Up",
                    onPressed: () {
                      final newUser = User(
                        username: _usernameController.text,
                        password: _passwordController.text,
                      );
                      context.read<AuthBloc>().add(AuthSignup(newUser, passwordConfirmController.text));
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

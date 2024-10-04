import 'package:flutter/material.dart';
import 'package:flutter_todo_list/widgets/custom_account_text.dart';
import 'package:flutter_todo_list/widgets/custom_button.dart';
import 'package:flutter_todo_list/widgets/custom_ilustration.dart';
import 'package:flutter_todo_list/widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback show;
  const LoginPage(this.show, {super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();

  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    _focusNode2.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: CustomIlustration(
                  imagePath: 'images/schedule_meeting.png',
                  width: double.infinity,
                  height: 300,
                ),
              ),
              const SizedBox(height: 50),
              CustomTextfield(
                controller: email,
                focusNode: _focusNode1,
                hintText: "Email",
                icon: Icons.email,
              ),
              const SizedBox(height: 10),
              CustomTextfield(
                controller: password,
                focusNode: _focusNode2,
                hintText: "Password",
                icon: Icons.password,
              ),
              const SizedBox(height: 8),
              CustomAccountText(
                questionText: "Don't have an account?",
                actionText: "Sign Up",
                onActionTap: () => widget.show(),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomButton(
                  text: "Login",
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_todo_list/widgets/custom_account_text.dart';
import 'package:flutter_todo_list/widgets/custom_button.dart';
import 'package:flutter_todo_list/widgets/custom_ilustration.dart';
import 'package:flutter_todo_list/widgets/custom_textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();
  final _focusNode3 = FocusNode();

  final email = TextEditingController();
  final password = TextEditingController();
  final passwordConfirm = TextEditingController();

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
    _focusNode3.addListener(() {
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
              const CustomIlustration(
                imagePath: 'images/schedule_meeting.png',
                height: 300,
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
              const SizedBox(height: 10),
              CustomTextfield(
                controller: passwordConfirm,
                focusNode: _focusNode3,
                hintText: "Password Confirm",
                icon: Icons.password,
              ),
              const SizedBox(height: 8),
              CustomAccountText(
                questionText: "Do you have an account?",
                actionText: "Login",
                onActionTap: () {},
              ),
              const SizedBox(height: 20),
              const CustomButton(text: "Sign Up"),
            ],
          ),
        ),
      ),
    );
  }
}

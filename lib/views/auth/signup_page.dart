import 'package:bayshore_task_frontend/utils/constants.dart';
import 'package:bayshore_task_frontend/utils/ui_helper.dart';
import 'package:bayshore_task_frontend/view_model/auth_view_model.dart';
import 'package:bayshore_task_frontend/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  Future<void> _register(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      try {
        await Provider.of<AuthViewModel>(context, listen: false)
            .register(email, password);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } catch (e) {
        // Handle login error
        UIHelper.showErrorSnackBar(context: context, message: e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up as Patron'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Let’s get started as a Patron!",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: defaultPadding / 2),
            const Text(
              "Join us as a patron by filling in the following details.",
            ),
            const SizedBox(height: defaultPadding),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    onSaved: (value) {
                      email = value ?? '';
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email address';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email address",
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  TextFormField(
                    onChanged: (value) {
                      password = value;
                    },
                    onSaved: (newValue) => password = newValue ?? '',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a confirm password';
                      }
                      if (value != password) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: defaultPadding),
            ElevatedButton(
              onPressed: () {
                _register(context);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.maxFinite, 50),
                backgroundColor: primaryColor,
              ),
              child: const Text(
                "Continue",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: whiteColor,
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),
          ],
        ),
      ),
    );
  }
}

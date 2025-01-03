import 'package:bayshore_task_frontend/models/user_model.dart';
import 'package:bayshore_task_frontend/utils/constants.dart';
import 'package:bayshore_task_frontend/view_model/auth_view_model.dart';
import 'package:bayshore_task_frontend/views/auth/login_page.dart';
import 'package:bayshore_task_frontend/views/auth/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatelessWidget {
  final UserModel? user;
  const NavDrawer({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: primaryColor,
            ),
            child: Text(
              'Library App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          user == null
              ? Column(
                  children: [
                    ListTile(
                      title: const Text('Login'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text('Sign Up as Patron'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupPage(),
                          ),
                        );
                      },
                    ),
                  ],
                )
              : ListTile(
                  title: const Text('Logout'),
                  onTap: () {
                    final authViewModel =
                        Provider.of<AuthViewModel>(context, listen: false);
                    authViewModel.logout();
                  },
                ),
        ],
      ),
    );
  }
}

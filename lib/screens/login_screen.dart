import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth_bloc/auth_bloc_bloc.dart';
import 'product_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthBlocBloc, AuthBlocState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const ProductListPage()),
                (route) => false, 
              );
            } else if (state is AuthError) {
             
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Invalid email or password. Please try again.")),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            String errorMessage = '';
            if (state is AuthError) {
              errorMessage = 'Invalid email or password. Please try again.';
            }

            return Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    errorText: errorMessage.isNotEmpty ? errorMessage : null,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    errorText: errorMessage.isNotEmpty ? errorMessage : null, 
                  ),
                  obscureText: true, 
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final email = emailController.text;
                    final password = passwordController.text;

                    context.read<AuthBlocBloc>().add(
                          LoginRequested(email: email, password: password),
                        );
                  },
                  child: const Text("Login"),
                ),
                ElevatedButton(
                  onPressed: () {

                    context.read<AuthBlocBloc>().add(
                          const LoginRequested(email: "admin@admin.com", password:"supersecret"),
                        );
                  },
                  child: const Text("Bypass"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}


/*
ElevatedButton(
                  onPressed: () {
                    final email = emailController.text;
                    final password = passwordController.text;

                    context.read<AuthBlocBloc>().add(
                          LoginRequested(email: email, password: password),
                        );
                  },
                  child: const Text("Login"),
                ),

"email": "admin@admin.com", "password": "supersecret"
*/
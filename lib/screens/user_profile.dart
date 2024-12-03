import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth_bloc/auth_bloc_bloc.dart';
import 'login_screen.dart';


class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('User Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
          
              context.read<AuthBlocBloc>().add(LogoutRequested());
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false, 
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<AuthBlocBloc, AuthBlocState>(
        builder: (context, state) {
          if (state is AuthError) {
            return const Center(child: Text("An error occurred."));
          }

          if (state is AuthSuccess) {
            var user = state.user;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                  const Center(
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(
                          'https://www.w3schools.com/w3images/avatar2.png'),
                      
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  ListTile(
                    title: const Text('Name'),
                    subtitle: Text(user.firstName),
                  ),
                  ListTile(
                    title: const Text('Email'),
                    subtitle: Text(user.email),
                  ),
                  ListTile(
                    title: const Text('Role'),
                    subtitle: Text(user.role),
                  ),
                  
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<AuthBlocBloc>().add(LogoutRequested());
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      child: const Text('Logout'),
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

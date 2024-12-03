import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'blocs/auth_bloc/auth_bloc_bloc.dart';
import 'blocs/product/bloc/product_bloc_bloc.dart';
import 'screens/login_screen.dart';
import 'theme/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBlocBloc()),
        BlocProvider(
            create: (context) => ProductBlocBloc()), 
      ],
      child: MaterialApp(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        home: LoginScreen(),
      ),
    );
  }
}

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
            // AuthService.login("admin@admin.com", "supersecret");
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}

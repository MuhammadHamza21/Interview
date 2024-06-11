import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/controller/app_cubit.dart';
import 'package:interview/screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..connectToDataBase(),
        ),
      ],
      child: const MaterialApp(
        title: 'Material App',
        home: HomeScreen(),
      ),
    );
  }
}

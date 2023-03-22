import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_test/words_bloc.dart';
import 'package:otp_test/home_screen.dart';
import 'package:otp_test/scoreboard_screen.dart';

void main() {
  final allEnglishWords = <String, String>{};

  File('words_alpha.txt')
      .openRead()
      .map(utf8.decode)
      .transform(const LineSplitter())
      .forEach((word) => allEnglishWords.putIfAbsent(word, () => word));
  runApp(BlocProvider(create: (BuildContext context) => WordsBloc(allEnglishWords), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OTP Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        HomeScreen.routeName: (ctx) => HomeScreen(),
        ScoreboardScreen.routeName: (ctx) => const ScoreboardScreen()
      },
      home: HomeScreen(),
    );
  }
}

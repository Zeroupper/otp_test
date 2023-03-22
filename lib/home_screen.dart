import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_test/words_bloc.dart';
import 'package:otp_test/scoreboard_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  final textController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final wordsBloc = context.watch<WordsBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: 800,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: textController,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                ],
                decoration: const InputDecoration(hintText: 'Write your input here'),
              ),
              const SizedBox(
                height: 12.0,
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<WordsBloc>().add(AddWordEvent(textController.text));
                  },
                  child: const Text('Add input'),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              ...wordsBloc.state.entries.map(
                (entry) => Text(
                  entry.key,
                  style: theme.textTheme.bodyMedium?.copyWith(color: entry.value ? Colors.red : Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.star),
        onPressed: () {
          Navigator.of(context).popAndPushNamed(ScoreboardScreen.routeName);
        },
      ),
    );
  }
}

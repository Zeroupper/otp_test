import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_test/words_bloc.dart';
import 'package:otp_test/home_screen.dart';

class ScoreboardScreen extends StatelessWidget {
  static const routeName = '/scoreboard';

  const ScoreboardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final wordsBloc = context.watch<WordsBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Scoreboard"),
        centerTitle: true,
      ),
      body: wordsBloc.words.isNotEmpty
          ? Center(
              child: SizedBox(
                width: 800,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Your total score is: ${context.read<WordsBloc>().score} pt",
                      style: theme.textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    ListView(
                      shrinkWrap: true,
                      children: wordsBloc.words
                          .map(
                            (word) => Text(
                              "$word --> ${word.length} pt",
                              style: theme.textTheme.bodyLarge,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: Text(
                "No words have been added yet.",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.home),
        onPressed: () {
          Navigator.of(context).popAndPushNamed(HomeScreen.routeName);
        },
      ),
    );
  }
}

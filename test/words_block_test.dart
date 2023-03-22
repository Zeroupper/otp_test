import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otp_test/words_bloc.dart';

void main() {
  group('Testing WordsBloc...', () {
    late WordsBloc wordsBloc;

    const String apple = "apple";
    const String brother = "brother";
    const String notExistingWord = "not existing word";

    final allEnglishWordsForTest = {apple: apple, brother: brother};

    setUp(() {
      wordsBloc = WordsBloc(allEnglishWordsForTest);
    });

    test('initial state is empty map', () {
      expect(wordsBloc.state, {});
      expect(wordsBloc.words, []);
      expect(wordsBloc.score, 0);
    });

    blocTest<WordsBloc, Map<String, bool>>(
      'emits {"apple": false} when AddWordEvent("apple") is added',
      build: () => wordsBloc,
      act: (bloc) => bloc.add(AddWordEvent(apple)),
      expect: () => [
        {apple: false}
      ],
    );

    blocTest<WordsBloc, Map<String, bool>>(
      'emits {} when AddWordEvent("not existing word") is added',
      build: () => wordsBloc,
      act: (bloc) => bloc.add(AddWordEvent(notExistingWord)),
      expect: () => [],
    );

    blocTest<WordsBloc, Map<String, bool>>(
      'emits {"brother": true} when AddWordEvent("brother") is added twice',
      build: () => wordsBloc,
      act: (bloc) {
        bloc.add(AddWordEvent(brother));
        bloc.add(AddWordEvent(brother));
      },
      expect: () => [
        {brother: true},
        {brother: true}
      ],
    );
    blocTest<WordsBloc, Map<String, bool>>(
      'expects words to equal ["apple"] and score to equal apple.length',
      build: () => wordsBloc,
      act: (bloc) => bloc.add(AddWordEvent(apple)),
      verify: (bloc) {
        expect(wordsBloc.words, [apple]);
        expect(wordsBloc.score, apple.length);
      },
    );
  });
}

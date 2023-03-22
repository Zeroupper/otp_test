import 'package:flutter_bloc/flutter_bloc.dart';

class AddWordEvent {
  final String word;

  AddWordEvent(this.word);
}

class WordsBloc extends Bloc<AddWordEvent, Map<String, bool>> {
  final Map<String, String> allEnglishWords;

  WordsBloc(this.allEnglishWords) : super({}) {
    on<AddWordEvent>(_addWord);
  }

  void _addWord(AddWordEvent event, Emitter<Map<String, bool>> emit) {
    final word = event.word;

    if (word.length > "pneumonoultramicroscopicsilicovolcanoconiosis".length ||
        word.isEmpty ||
        allEnglishWords[word.toLowerCase()] == null) return;

    state.update(word, (_) => true, ifAbsent: () => false);
    emit({...state});
  }

  int get score {
    return state.keys.fold(0, (previousValue, element) => previousValue + element.length);
  }

  List<String> get words => state.keys.toList();
}

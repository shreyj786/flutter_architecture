import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/number_trivia.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTrivia> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTrivia trivia);
}

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl(this.sharedPreferences);
  // final NumberTriviaDatabase database;

  @override
  Future<void> cacheNumberTrivia(NumberTrivia trivia) {
    return sharedPreferences.setString(
      CACHED_NUMBER_TRIVIA,
      json.encode(trivia.toJson()),
    );
  }

  @override
  Future<NumberTrivia> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    if (jsonString != '') {
      return Future.value(NumberTrivia.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}

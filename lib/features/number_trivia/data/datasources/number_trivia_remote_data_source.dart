import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/number_trivia.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTrivia> getConcreteNumberTrivia(int number);
  Future<NumberTrivia> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl(this.client);

  @override
  Future<NumberTrivia> getConcreteNumberTrivia(int number) async =>
      _getTriviaFromUrl('$number');

  @override
  Future<NumberTrivia> getRandomNumberTrivia() async =>
      _getTriviaFromUrl('random');

  Future<NumberTrivia> _getTriviaFromUrl(String url) async {
    final http.Response response = await client.get(
        'http://numbersapi.com/$url',
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return NumberTrivia.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}

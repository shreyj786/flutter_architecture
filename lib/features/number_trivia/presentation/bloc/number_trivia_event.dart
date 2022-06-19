part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent {
  NumberTriviaEvent();
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String numberString;

  GetTriviaForConcreteNumber(this.numberString);
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {
  GetTriviaForRandomNumber();
}

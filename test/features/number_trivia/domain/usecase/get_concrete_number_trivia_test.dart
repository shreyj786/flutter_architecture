import 'package:dartz/dartz.dart';
import 'package:flutter_practice/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_practice/features/number_trivia/domain/repositories/number_trivia_repo.dart';
import 'package:flutter_practice/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetConcreteNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository =
      MockNumberTriviaRepository();

  usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  // setUp(() {

  // });

  const tNumber = 1;
  final tNumberTrivia = NumberTrivia(number: 1, text: 'test');

  test('should get trivia for the number passed', () async {
//arange

    when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
        .thenAnswer((_) async => Right(tNumberTrivia));
//act

    final result = await usecase(Params(number: tNumber));

//assert

    expect(result, Right(tNumberTrivia));

    verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}

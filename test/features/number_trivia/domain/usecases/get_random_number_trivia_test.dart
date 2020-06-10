import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/usecase/usecase.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetRandomNumberTrivia usecase;
  MockNumberTriviaRepository mockRandomTriviaRepository;

  setUp(() {
    mockRandomTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockRandomTriviaRepository);
  });

  final tNumberTrivia = NumberTrivia(number: 1, text: 'test text');

  test(
    'should get trivia from the repository',
    () async {
      // arrange
      when(mockRandomTriviaRepository.getRandomNumberTrivia()).thenAnswer(
        (_) async => Right(tNumberTrivia),
      );
      // act
      final result = await usecase.call(NoParams());
      // assert
      expect(result, Right(tNumberTrivia));
      verify(mockRandomTriviaRepository.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockRandomTriviaRepository);
    },
  );
}

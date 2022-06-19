import 'package:flutter_practice/core/error/exceptions.dart';

import '../../../../core/network/network_info.dart';
import '../datasources/number_trivia_local_data_source.dart';
import '../../domain/entities/number_trivia.dart';
import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/number_trivia_repo.dart';

import '../datasources/number_trivia_remote_data_source.dart';

typedef Future<NumberTrivia> _ConcreteOrRandomChooser();

class NumberTriviaRepoImpl implements NumberTriviaRepository {
  final NetworkInfo networkInfo;
  final NumberTriviaLocalDataSource localDataSource;
  final NumberTriviaRemoteDataSource remoteDataSource;

  NumberTriviaRepoImpl(
      {required this.networkInfo,
      required this.localDataSource,
      required this.remoteDataSource});

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(number) async {
    return await _getTrivia(
        () => remoteDataSource.getConcreteNumberTrivia(number));
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() => remoteDataSource.getRandomNumberTrivia());
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
      _ConcreteOrRandomChooser numberTrivia) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await numberTrivia();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}

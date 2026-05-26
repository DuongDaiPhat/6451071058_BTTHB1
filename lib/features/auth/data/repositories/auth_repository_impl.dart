import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async {
    try {
      final userModel = await remoteDataSource.login(email, password);
      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message ?? 'Authentication error'));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(String email, String password) async {
    try {
      final userModel = await remoteDataSource.signUp(email, password);
      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message ?? 'Registration error'));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred'));
    }
  }
}

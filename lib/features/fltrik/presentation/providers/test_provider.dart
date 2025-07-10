import 'package:filtrek_app/features/fltrik/core/class/crud.dart';
import 'package:filtrek_app/features/fltrik/data/datasources/remote/test_remote_datasource.dart';
import 'package:filtrek_app/features/fltrik/data/repositories/test_repositorie_Implement.dart';
import 'package:filtrek_app/features/fltrik/domain/repositories/test_repository.dart';
import 'package:filtrek_app/features/fltrik/domain/usecases/get_test_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final remoteDataProvider =
    Provider<TestRemoteDatasource>((ref) => TestRemoteDatasource(crud: Crud()));

final RepositoryProvider = Provider<TestRepository>((ref) =>
    TestRepositorieImplement(remoteDatasource: ref.read(remoteDataProvider)));

//then add all the use cases

final getTestDataProvider = Provider<GetTestData>(
    (ref) => GetTestData(repository: ref.read(RepositoryProvider)));

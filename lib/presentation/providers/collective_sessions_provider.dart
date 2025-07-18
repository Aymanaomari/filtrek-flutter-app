import 'package:filtrek_app/core/class/crud.dart';
import 'package:filtrek_app/data/datasources/remote/collective_sessions_remote_ds.dart';
import 'package:filtrek_app/data/repositories/collective_sessions_repository_imp.dart';
import 'package:filtrek_app/domain/usecases/collective_sessions/get_recent_collective_sessions_usecase.dart';
import 'package:filtrek_app/presentation/providers/membership_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var collectiveSessionsRemoteDsProvider =
    Provider((ref) => CollectiveSessionsRemoteDs(crud: Crud()));

var collectiveSessionsRepositoryProvider = Provider((ref) =>
    CollectiveSessionsRepositoryImp(
        remoteDs: ref.read(collectiveSessionsRemoteDsProvider),
        localDs: ref.read(authLocalDataSourceProvider)));

var getRecentCollectiveSessionsUsecaseProvider = Provider((ref) =>
    GetRecentCollectiveSessionsUsecase(
        collectiveSessionsRepository:
            ref.read(collectiveSessionsRepositoryProvider)));

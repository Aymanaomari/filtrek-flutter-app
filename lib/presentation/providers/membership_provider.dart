import 'package:filtrek_app/core/class/crud.dart';
import 'package:filtrek_app/features/authentication/data/datasources/local/auth_local_datasource.dart';
import 'package:filtrek_app/data/datasources/remote/membership_remote_ds.dart';
import 'package:filtrek_app/data/repositories/membership_repository_imp.dart';
import 'package:filtrek_app/domain/repositories/memeber_ship_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final memberShipRemoteDsProvider =
    Provider<MembershipRemoteDs>((ref) => MembershipRemoteDs(crud: Crud()));

final authLocalDataSourceProvider =
    Provider<AuthLocalDataSource>((ref) => AuthLocalDataSource());

final memebrShipReppositoryProvider = Provider<MemeberShipRepository>((ref) =>
    MembershipRepositoryImp(
        membershipRemoteDs: ref.read(memberShipRemoteDsProvider),
        authlocalDs: ref.read(authLocalDataSourceProvider)));

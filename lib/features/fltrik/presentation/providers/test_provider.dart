import 'package:filtrek_app/features/fltrik/core/class/crud.dart';
import 'package:filtrek_app/features/fltrik/data/datasources/remote/test_remote_ds.dart';
import 'package:filtrek_app/features/fltrik/data/repositories/test_repository_imp.dart';
import 'package:filtrek_app/features/fltrik/domain/entities/test.dart';
import 'package:filtrek_app/features/fltrik/domain/repositories/test_repository.dart';
import 'package:filtrek_app/features/fltrik/domain/usecases/test/get_test_data.dart';
import 'package:filtrek_app/features/fltrik/domain/usecases/test/post_test_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final testRemoteDsProvider = Provider<TestRemoteDs>((ref) {
  return TestRemoteDs(crud: Crud());
});

final testRepositoryProvider = Provider<TestRepository>((ref) {
  return TestRepositoryImp(remoteDs: ref.read(testRemoteDsProvider));
});

final getTestDataProvider = Provider<GetTestData>((ref) {
  return GetTestData(testRepository: ref.read(testRepositoryProvider));
});

final postTestDataProvider = Provider<PostTestData>((ref) {
  return PostTestData(testRepository: ref.read(testRepositoryProvider));
});

// ...existing code...

final testNotifierProvider =
    StateNotifierProvider<TestNotifier, AsyncValue<Test>>((ref) {
  final getTestData = ref.read(getTestDataProvider);
  final postTestData = ref.read(postTestDataProvider);

  return TestNotifier(getTestData, postTestData);
});

class TestNotifier extends StateNotifier<AsyncValue<Test>> {
  final GetTestData _getTestData;
  final PostTestData _postTestData;

  TestNotifier(this._getTestData, this._postTestData)
      : super(const AsyncValue.loading()) {
    // Automatically load data when notifier is created
    getTestData();
  }

  // Get test data
  Future<void> getTestData() async {
    state = const AsyncValue.loading();
    try {
      final test = await _getTestData.call();
      state = AsyncValue.data(test);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Post test data
  Future<void> postTestData(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      await _postTestData.call();
      // After posting, refresh the data
      await getTestData();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Refresh data
  Future<void> refresh() async {
    await getTestData();
  }
}

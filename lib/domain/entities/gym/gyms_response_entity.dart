import 'package:filtrek_app/domain/entities/gym/gym_entity.dart';

class GymsResponseEntity {
  final List<GymEntity> data;
  final int total;
  final int page;
  final int limit;
  final bool hasNextPage;

  const GymsResponseEntity({
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
    required this.hasNextPage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GymsResponseEntity &&
        other.data == data &&
        other.total == total &&
        other.page == page &&
        other.limit == limit &&
        other.hasNextPage == hasNextPage;
  }

  @override
  int get hashCode {
    return data.hashCode ^
        total.hashCode ^
        page.hashCode ^
        limit.hashCode ^
        hasNextPage.hashCode;
  }

  @override
  String toString() {
    return 'GymsResponseEntity{data: ${data.length} gyms, total: $total, page: $page, limit: $limit, hasNextPage: $hasNextPage}';
  }
}

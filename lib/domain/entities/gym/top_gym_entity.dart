import 'package:filtrek_app/domain/entities/gym/gym_entity.dart';

class TopGymEntity {
  final List<GymEntity> data;

  const TopGymEntity({
    required this.data,
  });

  @override
  String toString() {
    return 'TopGymEntity(gyms: ${data.length})';
  }
}

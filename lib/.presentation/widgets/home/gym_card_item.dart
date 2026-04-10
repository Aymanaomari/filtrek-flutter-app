import 'package:filtrek_app/core/constant/end_points.dart';
import 'package:filtrek_app/core/constant/image_assets.dart';
import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/domain/entities/gym/gym_entity.dart';
import 'package:flutter/material.dart';

class GymCardItem extends StatelessWidget {
  final GymEntity gym;

  const GymCardItem({super.key, required this.gym});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: 220,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colors.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    "${EndPoints.getGymImage}/${gym.imageUrl}",
                    width: double.infinity,
                    height: 110,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.limeAccent,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(gym.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.body2.copyWith(
                      color: colors.onSecondary, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              // Address row with proper text wrapping
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      gym.address,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              // Rating row
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    "${gym.rating ?? 'N/A'}",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              // Price row commented out
              /*              
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Start from',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "${gym.price} Dhs",
                    style: TextStyle(
                      color: Colors.limeAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              */
            ],
          ),
        ],
      ),
    );
  }
}

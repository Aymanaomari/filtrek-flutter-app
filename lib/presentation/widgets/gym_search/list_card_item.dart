import 'package:filtrek_app/end_points.dart';
import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/domain/entities/gym/gym_entity.dart';
import 'package:flutter/material.dart';

class ListCardItem extends StatelessWidget {
  final GymEntity gym;

  const ListCardItem({
    super.key,
    required this.gym,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final ratingStr = (gym.rating ?? 0).toStringAsFixed(1);
    final priceStr = gym.price != null ? gym.price!.toStringAsFixed(2) : '--';

    return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: colors.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Gym image
          Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: gym.imageUrl != null
                    ? DecorationImage(
                        image: NetworkImage(
                            "${EndPoints.getGymImage}/${gym.imageUrl}"),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: Stack(
                children: [
                  // Gradient overlay for better text visibility
                  Positioned(
                    bottom: 8,
                    left: 8,
                    right: 0,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.black.withOpacity(0.3),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.6, 1.0],
                        ),
                      ),
                    ),
                  ),
                  // Rating text
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star_sharp,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  ratingStr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  gym.name,
                  style:
                      AppTypography.body1.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Text(
            gym.address,
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.body2
                .copyWith(color: colors.tertiary, fontWeight: FontWeight.w300),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Start From',
                style: AppTypography.bodySmall.copyWith(color: colors.outline),
              ),
              const SizedBox(width: 4),
              Text(
                '$priceStr Dhs',
                style: AppTypography.body1.copyWith(
                    color: colors.primary, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ]));
  }
}

import 'package:filtrek_app/end_points.dart';
import 'package:filtrek_app/core/constant/image_assets.dart';
import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/domain/entities/gym/gym_entity.dart';
import 'package:filtrek_app/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GridCardItem extends StatelessWidget {
  final GymEntity gym;

  const GridCardItem({
    super.key,
    required this.gym,
  });

  bool get _hasValidImage => gym.imageUrl != null && gym.imageUrl!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 600;
    final imageHeight = isWide ? 130.0 : 110.0; // Responsive image height

    final priceStr = gym.price != null ? gym.price!.toStringAsFixed(2) : null;
    final ratingStr =
        gym.rating != null ? gym.rating!.toStringAsFixed(1) : null;

    Widget buildImage() {
      if (_hasValidImage) {
        return Image.network(
          "${EndPoints.getGymImage}/${gym.imageUrl}",
          width: double.infinity,
          height: imageHeight,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Image.asset(
            ImageAssets.homeGymCardItemTest,
            width: double.infinity,
            height: imageHeight,
            fit: BoxFit.cover,
          ),
        );
      }
      return Image.asset(
        ImageAssets.homeGymCardItemTest,
        width: double.infinity,
        height: imageHeight,
        fit: BoxFit.cover,
      );
    }

    return GestureDetector(
      onTap: () {
        context.pushNamed(RouteNames.singleGymScreen,
            queryParameters: {"gymId": gym.id});
      },
      child: Container(
        padding: const EdgeInsets.all(8),
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
                    child: buildImage(),
                  ),
                ),
                // Linear gradient overlay at bottom
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ),
                // Rating positioned at bottom
                if (ratingStr != null)
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: isWide ? 16 : 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          ratingStr,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: isWide ? 12 : 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                // Heart icon at top right (placeholder interaction)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(isWide ? 6 : 4),
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.limeAccent,
                      size: isWide ? 20 : 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      gym.name,
                      style: AppTypography.body1.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: isWide ? 14 : 13,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      gym.address,
                      style: AppTypography.caption.copyWith(
                        color: colors.onSecondary,
                        fontSize: isWide ? 12 : 11,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    // if (priceStr != null)
                    //   Row(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         'Start From',
                    //         style: AppTypography.caption.copyWith(
                    //           fontSize: isWide ? 11 : 10,
                    //         ),
                    //       ),
                    //       const SizedBox(width: 4),
                    //       Text(
                    //         '$priceStr Dhs',
                    //         style: AppTypography.bodyLarge.copyWith(
                    //           color: colors.primary,
                    //           fontWeight: FontWeight.w700,
                    //           fontSize: isWide ? 14 : 13,
                    //         ),
                    //       ),
                    //     ],
                    //   )
                    // else
                    //   Text(
                    //     'Contact for pricing',
                    //     style: AppTypography.caption.copyWith(
                    //       color: colors.onSecondary,
                    //       fontSize: isWide ? 11 : 10,
                    //     ),
                    //   ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

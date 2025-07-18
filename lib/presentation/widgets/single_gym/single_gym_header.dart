import 'package:filtrek_app/end_points.dart';
import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/core/utils/extensions.dart';
import 'package:filtrek_app/domain/entities/gym/single_gym_entity.dart';
import 'package:filtrek_app/presentation/widgets/user/image_skeleton.dart';
import 'package:flutter/material.dart';

class SingleGymHeader extends StatelessWidget {
  final bool isLoading;
  final SingleGymEntity? gymData;
  final VoidCallback? onBackPressed;
  final VoidCallback? onMenuPressed;

  const SingleGymHeader({
    super.key,
    required this.isLoading,
    this.gymData,
    this.onBackPressed,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      height: 50.0.hp(context),
      decoration: isLoading || gymData == null
          ? BoxDecoration(color: Colors.grey[300])
          : BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "${EndPoints.getGymImage}/${gymData!.gymPicture}",
                ),
                fit: BoxFit.cover,
              ),
            ),
      child: Stack(
        children: [
          // Loading skeleton overlay
          if (isLoading || gymData == null) const ImageSkeleton(),

          // Gradient overlay for better text visibility
          if (gymData != null)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.7),
                    ],
                    stops: [0.0, 0.4, 0.7, 1.0],
                  ),
                ),
              ),
            ),

          // Top navigation buttons
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  height: 50,
                  minWidth: 50,
                  onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
                  shape: CircleBorder(),
                  color: Colors.black.withOpacity(0.3),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                MaterialButton(
                  height: 50,
                  minWidth: 50,
                  onPressed: onMenuPressed,
                  shape: CircleBorder(),
                  color: Colors.black.withOpacity(0.3),
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),

          // Gym info at bottom left
          if (gymData != null)
            Positioned(
              bottom: 48,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    gymData!.name,
                    style: AppTypography.h1.copyWith(color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        "3 km near you",
                        style: AppTypography.body2.copyWith(
                          color: colors.tertiary,
                        ),
                      ),
                      SizedBox(width: 16),
                      Text(
                        "Open ${gymData!.openTime}-${gymData!.closeTime}",
                        style: AppTypography.body2.copyWith(
                          color: colors.tertiary,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "Starts from ",
                        style:
                            AppTypography.body1.copyWith(color: colors.outline),
                      ),
                      SizedBox(width: 2),
                      Text(
                        gymData!.startPrice,
                        style: AppTypography.body1.copyWith(
                            color: colors.primary, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 16),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          // Text(
                          //   "${gymData!.ratingAvg} (20 reviews)",
                          //   style: AppTypography.body1
                          //       .copyWith(color: Colors.white.withOpacity(0.9)),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

          // Bottom rounded container
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:filtrek_app/presentation/widgets/single_gym/maptab_view.dart';
import 'package:filtrek_app/presentation/widgets/app_widgets/app_button.dart';
import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/route_names.dart';
import 'package:go_router/go_router.dart';

class SingleGymLocationTab extends StatelessWidget {
  final dynamic gymData;
  final ColorScheme colors;

  const SingleGymLocationTab({
    Key? key,
    required this.gymData,
    required this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: MapTabView(gymData: gymData),
        ),
        Container(
          height: 48,
          margin: const EdgeInsets.all(16),
          child: AppButton(
            borderRadius: 16,
            height: 44,
            onPressed: () async {
              await context.pushNamed(RouteNames.gymMap, queryParameters: {
                "lat": gymData.address.latitude.toString(),
                "long": gymData.address.longitude.toString()
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Find Your way",
                  style: AppTypography.button.copyWith(color: colors.surface),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.directions_outlined,
                  color: colors.surface,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

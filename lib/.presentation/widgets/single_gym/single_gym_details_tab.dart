import 'dart:ffi';

import 'package:filtrek_app/domain/entities/gym/single_gym_entity.dart';
import 'package:flutter/material.dart';
import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/presentation/widgets/single_gym/amenity_icon.dart';
import 'package:filtrek_app/presentation/widgets/single_gym/single_gym_details_skeleton.dart';

class SingleGymDetailsTab extends StatelessWidget {
  final SingleGymEntity gymData;
  final ColorScheme colors;
  final ScrollController scrollController;

  const SingleGymDetailsTab({
    Key? key,
    required this.gymData,
    required this.colors,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Amenities",
              style: AppTypography.h3.copyWith(color: colors.onSecondary)),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                gymData.amenities.length,
                (index) => Padding(
                    padding: EdgeInsets.only(right: index < 7 ? 12.0 : 0),
                    child: AmenityIcon.fromName(gymData.amenities[index])),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text("Description",
              style: AppTypography.h3.copyWith(color: colors.onSecondary)),
          const SizedBox(height: 12),
          Text(
            gymData?.description ?? " ",
            style: AppTypography.body2.copyWith(color: colors.tertiary),
          ),
        ],
      ),
    );
  }
}

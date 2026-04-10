import 'package:filtrek_app/core/constant/image_assets.dart';
import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/core/utils/extensions.dart';
import 'package:filtrek_app/presentation/widgets/coache-calendar/custom_sfcalendar.dart';
import 'package:filtrek_app/presentation/widgets/coache-calendar/horitzontal_date_scroller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CoachPlanningScreen extends StatelessWidget {
  const CoachPlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return ListView(
      children: [
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 24),
          height: 30.0.hp(context).clamp(200, 340),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageAssets.coachCalendarBackgrond),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                color.secondary.withOpacity(0.95), // 0.5 = 50% opacity
                BlendMode.darken,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Planing",
                style: AppTypography.h1.copyWith(color: color.primary),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                DateFormat('EEEE, dd MMM').format(DateTime.now()),
                style: AppTypography.h3.copyWith(
                    color: color.onSurface, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 16,
              ),
              HoritzontalDateScroller(),
            ],
          ),
        ),
        Container(height: 60.0.hp(context), child: CustomSfcalendar())
      ],
    );
  }
}

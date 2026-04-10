import 'package:filtrek_app/core/constant/end_points.dart';
import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/core/utils/extensions.dart';
import 'package:filtrek_app/domain/entities/gym/available_coaches_entity.dart';
import 'package:flutter/material.dart';

class CoachCard extends StatelessWidget {
  final CoachEntity coach;
  final VoidCallback? onTap;
  final bool isSelected;

  const CoachCard(
      {Key? key, required this.coach, this.onTap, required this.isSelected})
      : super(key: key);

  String _formatProfilePictureUrl(String url) {
    if (url.isEmpty) return '';
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    }
    return "${EndPoints.endPointsPrefix}/api/user/profile-picture/$url";
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = _formatProfilePictureUrl(coach.coachImage ??
        "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y");
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          side: isSelected
              ? BorderSide(
                  color: Theme.of(context).colorScheme.primary, width: 2)
              : BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade200,
              ),
              child: imageUrl.isEmpty
                  ? Icon(Icons.person, size: 40, color: Colors.grey)
                  : ClipOval(
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.person, size: 40, color: Colors.grey),
                      ),
                    ),
            ),
            SizedBox(height: 8),
            Text(coach.coachName.capitalize(),
                style: AppTypography.body2.copyWith(color: colors.onSecondary)),
            SizedBox(height: 4),
            Text("${coach.specialization.capitalize()} Coach",
                style: AppTypography.body2.copyWith(color: colors.outline)),
          ],
        ),
      ),
    );
  }
}

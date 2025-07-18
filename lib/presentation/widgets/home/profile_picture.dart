import 'package:filtrek_app/presentation/providers/user_provider.dart';
import 'package:filtrek_app/domain/entities/user/current_user_response_entity.dart';
import 'package:filtrek_app/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePicture extends ConsumerWidget {
  final double? width;
  final double? height;

  const ProfilePicture({
    super.key,
    this.width = 50,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userStateProvider);
    print(userState.currentUser!.profilePictureUrl);
    return ClipOval(
      child: Container(
        width: width,
        height: height,
        child: userState.isLoading
            ? _ProfileSkeleton(width: width, height: height)
            : userState.errorMessage != null
                ? _FallbackAvatar(width: width, height: height)
                : _buildUserProfile(userState.currentUser),
      ),
    );
  }

  Widget _buildUserProfile(CurrentUserResponseEntity? user) {
    final profilePictureUrl = user?.profilePictureUrl;

    if (profilePictureUrl != null && profilePictureUrl.isNotEmpty) {
      final formattedUrl = _formatProfilePictureUrl(profilePictureUrl);

      return Image.network(
        formattedUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _FallbackAvatar(width: width, height: height);
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _ProfileSkeleton(width: width, height: height);
        },
      );
    }

    return _FallbackAvatar(width: width, height: height);
  }

  String _formatProfilePictureUrl(String url) {
    // Check if it's already a complete URL (starts with http or https)
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    }

    // If it's just an image name, format it with the endpoint
    return "${EndPoints.endPointsPrefix}/api/user/profile-picture/$url";
  }
}

class _ProfileSkeleton extends StatefulWidget {
  final double? width;
  final double? height;

  const _ProfileSkeleton({this.width, this.height});

  @override
  State<_ProfileSkeleton> createState() => _ProfileSkeletonState();
}

class _ProfileSkeletonState extends State<_ProfileSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(_animation.value * 0.3),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}

class _FallbackAvatar extends StatelessWidget {
  final double? width;
  final double? height;

  const _FallbackAvatar({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.person,
        size: (width! * 0.6),
        color: Colors.white,
      ),
    );
  }
}

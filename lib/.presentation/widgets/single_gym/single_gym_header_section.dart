import 'package:flutter/material.dart';
import 'package:filtrek_app/presentation/widgets/single_gym/single_gym_header.dart';

class SingleGymHeaderSection extends StatelessWidget {
  final bool isLoading;
  final dynamic gymData;
  final VoidCallback? onMenuPressed;

  const SingleGymHeaderSection({
    Key? key,
    required this.isLoading,
    required this.gymData,
    this.onMenuPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleGymHeader(
      isLoading: isLoading,
      gymData: gymData,
      onMenuPressed: onMenuPressed,
    );
  }
}

import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/presentation/providers/managers/search/search_screen_manager_provider.dart';
import 'package:filtrek_app/presentation/widgets/app_widgets/app_dropDown.dart';
import 'package:filtrek_app/presentation/widgets/app_widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchFilterBottomSheet extends ConsumerStatefulWidget {
  const SearchFilterBottomSheet({super.key});

  @override
  ConsumerState<SearchFilterBottomSheet> createState() =>
      _SearchFilterBottomSheetState();
}

class _SearchFilterBottomSheetState
    extends ConsumerState<SearchFilterBottomSheet> {
  String? selectedLocation;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final searchState = ref.watch(searchScreenManagerProvider);
    final searchNotifier = ref.read(searchScreenManagerProvider.notifier);

    return Container(
      // Use surface instead of secondary for background
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: colors.surface,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Location",
            style: AppTypography.body2
                .copyWith(color: colors.tertiary, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 12),
          // Show loading indicator or dropdown based on availableCitiesAreLoading
          searchState.availableCitiesAreLoading
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: CircularProgressIndicator(),
                  ),
                )
              : SizedBox(
                  height: 48,
                  child: AppDropdown<String>(
                    items: searchState.availableGymsCities,
                    selectedValue: searchState.cityController.text.isEmpty
                        ? null
                        : searchState.cityController.text,
                    hintText: 'Select Location',
                    width: double.infinity,
                    onChanged: (String? value) {
                      searchNotifier.updateCityFilter(value ?? '');
                      setState(() {
                        selectedLocation = value;
                      });
                    },
                  ),
                ),
          SizedBox(height: 20),
          // // Hide price filters if cities are loading
          // if (!searchState.availableCitiesAreLoading) ...[
          //   Row(
          //     spacing: 20,
          //     children: [
          //       Expanded(
          //         child: Column(
          //           spacing: 12,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               "Price Minimum",
          //               style: AppTypography.body2.copyWith(
          //                   color: colors.tertiary,
          //                   fontWeight: FontWeight.w400),
          //             ),
          //             SizedBox(
          //               height: 48,
          //               child: AppTextField(
          //                 labelText: "Min Price",
          //                 controller: searchState.minPriceController,
          //                 keyboardType: TextInputType.number,
          //               ),
          //             )
          //           ],
          //         ),
          //       ),
          //       Expanded(
          //           child: Column(
          //         spacing: 12,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             "Price Maximum",
          //             style: AppTypography.body2.copyWith(
          //                 color: colors.tertiary, fontWeight: FontWeight.w400),
          //           ),
          //           SizedBox(
          //             height: 48,
          //             child: AppTextField(
          //               labelText: "Max Price",
          //               controller: searchState.maxPriceController,
          //               keyboardType: TextInputType.number,
          //             ),
          //           )
          //         ],
          //       ))
          //     ],
          //   ),
          //   SizedBox(
          //     height: 32,
          //   ),
          // ],
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: MaterialButton(
                    color: colors.secondary,
                    textColor: colors.onSecondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Text(
                      "Reset",
                      style: AppTypography.button
                          .copyWith(color: colors.onSecondary),
                    ),
                    onPressed: () {
                      searchNotifier.resetFilters();
                      setState(() {
                        selectedLocation = null;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(width: 24),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: MaterialButton(
                    color: colors.primary,
                    textColor: colors.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Text(
                      "Apply",
                      style:
                          AppTypography.button.copyWith(color: colors.surface),
                    ),
                    onPressed: () {
                      searchNotifier.applyFilters();
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ],
          ),

          // Add bottom padding for safe area
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}

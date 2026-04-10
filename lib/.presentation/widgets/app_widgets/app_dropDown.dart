import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class AppDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedValue;
  final ValueChanged<T?>? onChanged;
  final String hintText;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final String Function(T)? displayText;

  const AppDropdown({
    super.key,
    required this.items,
    this.selectedValue,
    this.onChanged,
    this.hintText = 'Select Item',
    this.width = 140,
    this.height = 48,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.displayText,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colors.secondary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent, width: 0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<T>(
          isExpanded: true,
          hint: Text(
            hintText,
            style: AppTypography.body2.copyWith(color: colors.outline),
          ),
          items: items
              .map((T item) => DropdownMenuItem<T>(
                    value: item,
                    child: Text(
                      displayText?.call(item) ?? item.toString(),
                      style:
                          AppTypography.body1.copyWith(color: colors.onSurface),
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: onChanged,
          buttonStyleData: ButtonStyleData(
            padding: padding,
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.transparent,
            ),
          ),
          iconStyleData: IconStyleData(
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: colors.primary,
              size: 24,
            ),
            iconSize: 24,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: colors.secondary,
            ),
            padding: EdgeInsets.zero,
          ),
          menuItemStyleData: MenuItemStyleData(
            height: height ?? 48,
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
          selectedItemBuilder: (context) {
            return items.map((item) {
              return Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  displayText?.call(item) ?? item.toString(),
                  style: AppTypography.body1.copyWith(color: colors.onSurface),
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}

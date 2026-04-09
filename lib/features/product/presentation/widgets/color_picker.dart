import 'package:crafty_bay/app/extensions/utils_extension.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key, required this.colors, required this.onChange});
  final List<String> colors;
  final Function(String) onChange;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  String? _selectedColor;

  @override

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(context.l10n.color, style: context.textTheme.titleMedium),
        Row(
          children: widget.colors.map((color) {
            return GestureDetector(
              onTap: () {
                _selectedColor = color;
                widget.onChange(color);
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: _selectedColor == color
                      ? AppColors.themeColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.themeColor),
                ),
                child: Text(color),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

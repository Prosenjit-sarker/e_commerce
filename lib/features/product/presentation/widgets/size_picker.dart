import 'package:crafty_bay/app/extensions/utils_extension.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';

class SizePicker extends StatefulWidget {
  const SizePicker({super.key, required this.sizes, required this.onChange});
  final List<String> sizes;
  final Function(String) onChange;

  @override
  State<SizePicker> createState() => _SizePickerState();
}

class _SizePickerState extends State<SizePicker> {
  String? _selectedSize;

  @override

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(context.l10n.size, style: context.textTheme.titleMedium),
        Row(
          children: widget.sizes.map((size) {
            return GestureDetector(
              onTap: () {
                _selectedSize = size;
                widget.onChange(size);
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: _selectedSize == size
                      ? AppColors.themeColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.themeColor),
                ),
                child: Text(size),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

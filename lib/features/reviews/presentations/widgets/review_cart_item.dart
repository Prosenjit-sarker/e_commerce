import 'package:flutter/material.dart';
import '../../../../app/app_colors.dart';
import '../../../../app/extensions/utils_extension.dart';

class ReviewCartItem extends StatelessWidget {
  const ReviewCartItem({
    super.key,
    required this.name,
    required this.description,
  });

  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: .symmetric(horizontal: 16, vertical: 4),
      elevation: 3,
      shadowColor: AppColors.themeColor.withAlpha(30),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person),
                              SizedBox(width: 8,),
                              Text(
                                name,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),

                          const SizedBox(height: 6),
                          Text(
                            description,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
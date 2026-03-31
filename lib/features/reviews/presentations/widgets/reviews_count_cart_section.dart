import 'package:flutter/material.dart';
import '../../../../app/app_colors.dart';
import '../../../../app/extensions/utils_extension.dart';
import '../model/review_model.dart';
import '../screens/createreviewpage.dart';

class ReviewCountToCartSection extends StatelessWidget {
  const ReviewCountToCartSection({
    super.key,
    required this.count,
    required this.onTapReview,
  });

  final double count;
  final ValueChanged<ReviewModel> onTapReview;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: .only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: AppColors.themeColor.withAlpha(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                'Reviews  (${count.toStringAsFixed(count.truncateToDouble() == count ? 0 : 1)})',
                style: context.textTheme.bodyLarge?.copyWith(
                ),
              ),
            ],
          ),
          FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CreateReviewPage(),
                ),
              );

              if (result != null && result is ReviewModel) {
                onTapReview(result);
              }
            },
            backgroundColor: AppColors.themeColor,
            child: const Icon(Icons.add,color: Colors.white,),

          ),
        ],
      ),
    );
  }
}

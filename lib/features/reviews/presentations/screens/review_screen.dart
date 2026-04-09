import 'package:crafty_bay/features/reviews/presentations/widgets/reviews_count_cart_section.dart';
import 'package:flutter/material.dart';
import '../../../../app/extensions/utils_extension.dart';
import '../model/review_model.dart';
import '../widgets/review_cart_item.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});
  static const name = '/review-screen';

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final List<ReviewModel> _reviews = [
    ReviewModel(
      firstName: 'Prosenjit',
      lastName: 'sarker',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla facilisi. Praesent euismod, nisl vel consectetur interdum, nisl nisi aliquet nunc, vitae egestas nunc nisl eu lectus. Integer sit amet libero ut erat finibus gravida.',
    ),
  ];

  void _addReview(ReviewModel review) {
    setState(() {
      _reviews.insert(0, review);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
        title: Text(context.l10n.reviews),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _reviews.length,
              itemBuilder: (context, index) {
                final review = _reviews[index];
                return ReviewCartItem(
                  name: '${review.firstName} ${review.lastName}',
                  description: review.description,
                );
              },
            ),
          ),
          ReviewCountToCartSection(
            count: _reviews.length.toDouble(),
            onTapReview: _addReview,
          ),
        ],
      ),
    );
  }
}

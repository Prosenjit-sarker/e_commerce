import 'package:flutter/material.dart';
import '../../../../app/app_colors.dart';
import '../../../../app/extensions/utils_extension.dart';
import '../model/review_model.dart';

class CreateReviewPage extends StatefulWidget {
  const CreateReviewPage({super.key});

  @override
  State<CreateReviewPage> createState() => _CreateReviewPageState();
}

class _CreateReviewPageState extends State<CreateReviewPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  void submit() {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        descController.text.isEmpty) {
      return;
    }

    final review = ReviewModel(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      description: descController.text,
    );

    Navigator.pop(context, review);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(context.l10n.createReview),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(16),
        color: AppColors.themeColor.withAlpha(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(labelText: context.l10n.firstName),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(labelText: context.l10n.lastName),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: descController,
                    maxLines: 8,
                    decoration: InputDecoration(labelText: context.l10n.description),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.themeColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: submit,
                child: Text(context.l10n.submit),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

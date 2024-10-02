import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key});

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _reviewTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Create Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              controller: _firstNameTEController,
              decoration: const InputDecoration(
                  hintText: 'First Name'
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              textInputAction: TextInputAction.next,
              controller: _lastNameTEController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  hintText: 'Last Name'
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              maxLines: 6,
              keyboardType: TextInputType.text,
              controller: _reviewTEController,
              decoration: const InputDecoration(
                  hintText: 'Write Review'
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
              },
              child: const Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}

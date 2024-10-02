import 'package:crafty_bay_app/presentation/ui/screen/create_review_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_color.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Reviews'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8),
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, int index) {
                    return Card(
                      color: Colors.white,
                      elevation: 1,
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width - 32,
                        child: const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.black12,
                                    radius: 12.0,
                                    child: Icon(
                                      Icons.person_2_outlined,
                                      color: Colors.black54,
                                      size: 18,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Rabbil Hasan',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              Text(
                                  '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. ''',
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )),
          ),
          buildTotalPriceAndCheckoutSection()
        ],
      ),
    );
  }
}

Widget buildTotalPriceAndCheckoutSection() {
  return Container(
    decoration: BoxDecoration(
        color: AppColors.themeColor.withOpacity(0.2),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        )),
    height: 80,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Reviews  (1000)',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black54)),
            ],
          ),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.themeColor,
            ),
            child: IconButton(
                onPressed: () {
                  Get.to(()=> const CreateReviewScreen());
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 35,
                )),
          )
        ],
      ),
    ),
  );
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app_clean_architecture/presentation/widget/chips_widget.dart';
import 'package:flutter_news_app_clean_architecture/utils/config/app_router.dart';
import 'package:flutter_news_app_clean_architecture/utils/constant.dart';
import '../widget/article_card_widget.dart';
import '../../utils/colors_app.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News 360"),
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.bookmark_outline),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ! Title
          Container(
              margin: const EdgeInsets.only(top: mediumSize, left: mediumSize),
              child: const Text(
                "Top Headlines",
                style: TextStyle(
                    fontSize: mediumTextSize, fontWeight: FontWeight.bold),
              )),
          const SizedBox(
            height: normalSize,
          ),

          // ! chips
          ChipWidget(chipData: const [
            "Sport",
            "Sport",
            "Sport",
            "Sport",
            "Sport",
            "Sport",
            "Sport",
          ], onSelected: (value) {}),

          // ! article card
          ArticleCardWidget(
            onClickCard: () {
              context.router.push(const DetailsRoute());
            },
          ),
        ],
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
      body: ArticleCardWidget(
        onClickCard: () {},
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../widget/chips_widget.dart';
import '../widget/swiper_card_widget.dart';
import '../../utils/config/app_router.dart';
import '../../utils/constant.dart';
import '../../utils/colors_app.dart';
import 'package:card_swiper/card_swiper.dart';

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
            onPressed: () {
              context.router.push(const SearchRoute());
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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

            const SizedBox(
              height: 16,
            ),

            SizedBox(
              height: 400,
              child: Swiper(
                itemHeight: double.infinity,
                itemWidth: 300,
                itemBuilder: (BuildContext context, int index) {
                  return SwiperCardWidget(
                    onClick: () {
                      context.router.push(const DetailsRoute());
                    },
                  );
                },
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                layout: SwiperLayout.STACK,
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ! Title
                  const Text(
                    "Latest News",
                    style: TextStyle(
                      fontSize: largeFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //! Button
                  TextButton(
                    onPressed: () {
                      print("Button pressed!");
                    },
                    child: Text(
                      "See all",
                      style: TextStyle(
                        fontSize: smallFontSize,
                        color: kSecondaryTextColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

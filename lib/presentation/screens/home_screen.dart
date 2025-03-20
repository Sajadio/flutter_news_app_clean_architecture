import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_news_app_clean_architecture/presentation/cubit/searchQuery/article_cubit.dart';
import 'package:flutter_news_app_clean_architecture/presentation/widget/article_card_widget.dart';
import '../../utils/format.dart';
import '../widget/card_slider.dart';
import '../widget/chips_widget.dart';
import '../../confic/router/app_router.dart';
import '../../utils/constant.dart';
import '../../utils/colors_app.dart';

@RoutePage()
@RoutePage()
class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ArticleCubit>(context);
    final pageController = usePageController();
    final currentPage = useState(0);

    useEffect(() {
      pageController.addListener(() {
        int page = pageController.page?.toInt() ?? 0;
        if (page != currentPage.value) {
          currentPage.value = page;
        }
      });
      return pageController.dispose;
    }, []);

    return Scaffold(
      appBar: AppBar(
        actions: [
          _buildActionIcon(context, const Icon(CupertinoIcons.bookmark), () {
            context.router.push(const SaveRoute());
          }),
          const SizedBox(width: mediumSize),
          _buildActionIcon(context, const Icon(CupertinoIcons.search), () {
            context.router.push(const SearchRoute());
          }),
          const SizedBox(width: mediumSize),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: mediumSize, vertical: normalSize),
              child: _buildTextTitle("Breaking News", context, () {}),
            ),
            SizedBox(
              height: 300,
              child: PageView.builder(
                controller: pageController,
                itemCount: cubit.articles.length,
                itemBuilder: (context, index) {
                  return CardSlider(article: cubit.articles[index]);
                },
              ),
            ),
            const SizedBox(height: normalSize),
            _buildIndicator(currentPage.value, cubit.articles.length),
            const SizedBox(height: normalSize),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: mediumSize, vertical: normalSize),
              child: _buildTextTitle("Recommendation", context, () {}),
            ),
            SizedBox(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cubit.articles.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: normalSize),
                    child: ArticleCardWidget(
                      showButton: false,
                      article: cubit.articles[index],
                      onClickCard: (id) {
                        context.router.push(DetailsRoute(id: id));
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator(int currentPage, int countOfIndicator) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(countOfIndicator, (index) {
        double indicatorWidth = currentPage == index ? mediumSize : normalSize;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: smallSize),
          height: normalSize,
          width: indicatorWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(normalSize),
            color: currentPage == index ? kPrimaryColor : kSecondaryTextColor,
          ),
        );
      }),
    );
  }

  Widget _buildActionIcon(
      BuildContext context, Icon icon, Function() onPressed) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: kSecondaryColor),
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
      ),
    );
  }

  Widget _buildTextTitle(
      String title, BuildContext context, Function() viewAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold)),
        TextButton(
          onPressed: viewAll,
          child: Text("View all",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}

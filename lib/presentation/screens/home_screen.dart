import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app_clean_architecture/presentation/cubit/searchQuery/article_cubit.dart';
import 'package:flutter_news_app_clean_architecture/presentation/widget/article_card_widget.dart';
import '../widget/chips_widget.dart';
import '../../confic/router/app_router.dart';
import '../../utils/constant.dart';
import '../../utils/colors_app.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ArticleCubit>(context);
    cubit.refreshCacheData(cubit.chipsItems[cubit.selectedIndex]);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Newsly",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: kSecondaryColor),
            child: IconButton(
              onPressed: () {
                context.router.push(const SaveRoute());
              },
              icon: const Icon(CupertinoIcons.bookmark),
            ),
          ),
          Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: kSecondaryColor),
            child: IconButton(
              onPressed: () {
                context.router.push(const SearchRoute());
              },
              icon: const Icon(CupertinoIcons.search),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: mediumSize,
          ),
          // ! Title
          _buildTextTitle("Breaking News", context, () {}),
          const SizedBox(
            height: normalSize,
          ),
          // ! chips
          ChipWidget(onSelected: (category) {
            cubit.refreshCacheData(category);
          }),
          const SizedBox(
            height: mediumSize,
          ),
          BlocBuilder<ArticleCubit, ArticleState>(
            builder: (context, state) {
              switch (state.runtimeType) {
                case DataStateSuccess:
                  return Expanded(
                    child: state.articles.isEmpty
                        ? const Text("Not Data, check your connection")
                        : ListView.builder(
                            itemCount: state.articles.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: mediumSize),
                                child: ArticleCardWidget(
                                  showButton: false,
                                  article: state.articles[index],
                                  onClickCard: (id) {
                                    // context.router.push(DetailsRoute(id: id));
                                  },
                                ),
                              );
                            }),
                  );
                default:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextTitle(
      String title, BuildContext context, Function() viewAll) {
    return Row(
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold)),
        const Spacer(),
        TextButton(
          onPressed: viewAll,
          child:
              Text("View all", style: Theme.of(context).textTheme.labelLarge),
        ),
      ],
    );
  }
}

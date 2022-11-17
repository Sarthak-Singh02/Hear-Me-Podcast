import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hear_me/activity/Tabs/ExploreTab.dart';
import 'package:hear_me/activity/Tabs/FavouritesTab.dart';
import 'package:hear_me/activity/Tabs/TrendingTab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Flutter Podcast",
            style: TextStyle(
              color: Colors.deepOrange,
              fontSize: 30,
            ),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TabBar(
              controller: _controller,
              splashFactory: NoSplash.splashFactory,
              splashBorderRadius: BorderRadius.circular(50),
              labelColor: Colors.deepOrange,
              unselectedLabelColor: CupertinoColors.systemGrey6,
              indicator: BoxDecoration(
                border: Border.all(color: Colors.deepOrange, width: 2),
                borderRadius: BorderRadius.circular(50), // Creates border
              ),
              tabs: const [
                Tab(
                  icon: Icon(Icons.podcasts),
                  child: Text(
                    "Trending",
                  ),
                ),
                Tab(
                  icon: Icon(Icons.explore),
                  child: Text(
                    "Explore",
                  ),
                ),
                Tab(
                  icon: Icon(Icons.favorite),
                  child: Text("Favourites"),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                  controller: _controller,
                  children: const [TrendingTab(), Explore(), FavouritesTab()]),
            )
          ],
        ),
      ),
    );
  }
}

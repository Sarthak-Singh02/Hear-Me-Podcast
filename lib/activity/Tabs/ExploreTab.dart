import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Explore extends StatelessWidget {
  Explore({super.key});
  final List<String> _genres = [
    "Arts",
    "Books",
    "Business",
    "Comedy",
    "Culture",
    "Education",
    "Spirituality",
    "Sports"
  ];
  final List _colors = [
    CupertinoColors.systemRed,
    CupertinoColors.activeGreen,
    CupertinoColors.activeBlue,
    CupertinoColors.activeOrange,
    CupertinoColors.systemIndigo,
    CupertinoColors.systemPurple,
    CupertinoColors.systemGrey,
    CupertinoColors.systemYellow
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Text(
                "Explore",
                style: TextStyle(
                  color: CupertinoColors.systemGrey6,
                  fontSize: 25,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: _genres.length,
                  itemBuilder: (context, index) {
                    return Card(
                        color: _colors[index],
                        child: Center(
                          child: Text(
                            _genres[index],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ));
                  }),
            )
          ],
        ),
      ),
    );
  }
}

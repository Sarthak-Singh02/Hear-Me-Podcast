import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavouritesTab extends StatelessWidget {
  const FavouritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Text(
                "Favourites",
                style: TextStyle(
                  color: CupertinoColors.systemGrey6,
                  fontSize: 25,
                ),
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
    );
  }
}

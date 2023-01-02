import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudioPlayer extends StatelessWidget {
  final List audious;
  const AudioPlayer({super.key, required this.audious});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.deepOrange),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.list,
              )),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.podcasts_rounded,
              color: Colors.deepOrange,
              size: 200,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            ),
            Slider(
              activeColor: Colors.deepOrange,
              inactiveColor: Colors.white,
              min: 0.0,
              max: 2.0,
              value: 1.0,
              onChanged: (value) {
                // final position = Duration(seconds: value.toInt());
                // audioPlayer.seek(position);
                // audioPlayer.resume();
                // _animationIconController1.forward();
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  CupertinoIcons.backward_fill,
                  color: Colors.white,
                ),
                GestureDetector(
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.play_circle,
                        size: 55,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                ),
                Icon(
                  CupertinoIcons.forward_fill,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

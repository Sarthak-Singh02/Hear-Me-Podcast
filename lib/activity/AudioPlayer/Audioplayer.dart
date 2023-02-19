import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAudioPlayer extends StatelessWidget {
  final String title;
  final String audios;
  MyAudioPlayer({super.key, required this.audios, required this.title});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.deepOrange),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.podcasts,
            color: Colors.deepOrange,
            size: 150,
          ),
          SizedBox(
            height: 10,
          ),
          CustomSlider(
            audios: audios,
          ),
        ],
      ),
    );
  }
}


class CustomSlider extends StatefulWidget {
  final String audios;
  CustomSlider({super.key, required this.audios});

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationIconController1;

  late AudioPlayer audioPlayer;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool issongplaying = false;
  bool isLoading = true;
  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'
        .split('.')[0]
        .padLeft(4, '0')
        .toString()
        .substring(2, 7);
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void initState() {
    super.initState();
    audioPlayer = new AudioPlayer();
    _animationIconController1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
      reverseDuration: Duration(milliseconds: 750),
    );
    audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          issongplaying = state == PlayerState.playing;
        });
      }
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      if (mounted) {
        setState(() {
          duration = newDuration;
        });
      }
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      if (mounted) {
        setState(() {
          position = newPosition;
        });
      }
    });
    loadingPodcast();
  }

  loadingPodcast() async {
    return await audioPlayer
        .play(UrlSource(widget.audios.replaceAll('{', '').replaceAll('}', '')))
        .whenComplete(() {
      isLoading = false;
      _animationIconController1.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black,
      ),
      child: Column(
        children: [
          Slider(
            activeColor: Colors.deepOrange,
            inactiveColor: Colors.white,
            min: 0,
            max: duration.inSeconds.toDouble(),
            value: position.inSeconds.toDouble(),
            onChanged: (value) {
              final position = Duration(seconds: value.toInt());
              audioPlayer.seek(position);
              audioPlayer.resume();
              _animationIconController1.forward();
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatTime(position.inSeconds),
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  formatTime((duration).inSeconds),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Icon(
              //   Icons.refresh,
              //   color: Colors.black,
              // ),
              InkWell(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      audioPlayer.seek(Duration(
                          seconds: position.inSeconds.toDouble().toInt() - 15));
                    });
                  }
                },
                child: Icon(
                  CupertinoIcons.backward_fill,
                  color: Colors.deepOrange,
                ),
              ),
              Stack(
                children: [
                  Visibility(
                      visible: isLoading ? true : false,
                      child: CircularProgressIndicator.adaptive()),
                  Visibility(
                    visible: isLoading ? false : true,
                    child: GestureDetector(
                      onTap: () {
                        if (mounted) {
                          setState(
                            () {
                              if (!issongplaying && isLoading == false) {
                                audioPlayer.play(UrlSource(widget.audios
                                    .replaceAll('{', '')
                                    .replaceAll('}', '')));
                              } else if (issongplaying && isLoading == false) {
                                audioPlayer.pause();
                              }
                              issongplaying
                                  ? _animationIconController1.reverse()
                                  : _animationIconController1.forward();
                              issongplaying = !issongplaying;
                            },
                          );
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AnimatedIcon(
                              icon: AnimatedIcons.play_pause,
                              size: 55,
                              progress: _animationIconController1,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              InkWell(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      audioPlayer.seek(Duration(
                          seconds: position.inSeconds.toDouble().toInt() + 15));
                    });
                  }
                },
                child: Icon(
                  CupertinoIcons.forward_fill,
                  color: Colors.deepOrange,
                ),
              ),
              // Icon(
              //   Icons.repeat,
              //   color: Colors.black,
              // )
            ],
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    audioPlayer.dispose();
    super.dispose();
  }
}
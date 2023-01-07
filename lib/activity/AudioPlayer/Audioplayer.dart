import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hear_me/BloC/AudioPlayerBloc/audio_player_bloc.dart';

import '../../BloC/AudioPlayerBloc/audio_player_state.dart';

class MyAudioPlayer extends StatelessWidget {
  final String audios;
  MyAudioPlayer({super.key, required this.audios});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.deepOrange),
        actions: [
          IconButton(
              onPressed: () {
                print(audios.replaceAll('{', '').replaceAll('}', ''));
              },
              icon: const Icon(
                Icons.list,
              )),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
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
            BlocProvider(
              create: (context) => AudioPlayerBloc(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(
                  //     CupertinoIcons.backward_end_fill,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.backward_fill,
                      color: Colors.white,
                    ),
                  ),
                  BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                    builder: (context, state) {
                      if (state is AudioPlayerLoadingState) {
                        context.read<AudioPlayerBloc>().play(
                            audios.replaceAll('{', '').replaceAll('}', ''));
                      }
                      return (state is AudioPlayerLoadingState)
                          ? const CircularProgressIndicator()
                          : IconButton(
                              onPressed: () async {
                                if (state is AudioPlayerPlayState) {
                                  context.read<AudioPlayerBloc>().pause();
                                } else {
                                  context.read<AudioPlayerBloc>().play(audios
                                      .replaceAll('{', '')
                                      .replaceAll('}', ''));
                                }
                              },
                              icon: (state is AudioPlayerPlayState)
                                  ? const Icon(
                                      CupertinoIcons.pause_circle,
                                      color: Colors.deepOrange,
                                      size: 40,
                                    )
                                  : const Icon(
                                      CupertinoIcons.play_circle,
                                      color: Colors.deepOrange,
                                      size: 40,
                                    ),
                            );
                    },
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.forward_fill,
                      color: Colors.white,
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(
                  //     CupertinoIcons.forward_end_fill,
                  //     color: Colors.white,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

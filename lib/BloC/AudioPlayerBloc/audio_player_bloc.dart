import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hear_me/BloC/AudioPlayerBloc/audio_player_state.dart';

class AudioPlayerBloc extends Cubit<AudioPlayerState> {
  AudioPlayerBloc() : super(AudioPlayerLoadingState());
  AudioPlayer audioPlayer = AudioPlayer();
  void play(String _audio) async {
    final result = await audioPlayer.play(UrlSource(_audio));
    emit(AudioPlayerPlayState());
  }

  void pause() async {
    await audioPlayer.pause();
    emit(AudioPlayerPauseState());
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}

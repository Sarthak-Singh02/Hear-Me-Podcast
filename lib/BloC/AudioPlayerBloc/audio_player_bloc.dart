import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hear_me/BloC/AudioPlayerBloc/audio_player_event.dart';
import 'package:hear_me/BloC/AudioPlayerBloc/audio_player_state.dart';

class AudioPlayerBloc extends Cubit<AudioPlayerState> {
  AudioPlayerBloc() : super(AudioPlayerPlayState());
  void play() => emit(AudioPlayerPlayState());
  void pause() => emit(AudioPlayerPauseState());
}

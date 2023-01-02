import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hear_me/BloC/AudioPlayerBloc/audio_player_event.dart';
import 'package:hear_me/BloC/AudioPlayerBloc/audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  AudioPlayerBloc() : super(AudioPlayerInitialState()) {
    on<AudioPlayerPlayEvent>((event, emit) => AudioPlayerPlayState());
    on<AudioPlayerPauseEvent>((event, emit) => AudioPlayerPauseState());
  }
}

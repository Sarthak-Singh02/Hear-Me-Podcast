abstract class AudioPlayerState{}

class AudioPlayerLoadingState extends AudioPlayerState{}
class AudioPlayerPlayState extends AudioPlayerState{}
class AudioPlayerPauseState extends AudioPlayerState{}
class AudioPlayerSeekForwardState extends AudioPlayerState{}
class AudioPlayerSeekBackwardState extends AudioPlayerState{}
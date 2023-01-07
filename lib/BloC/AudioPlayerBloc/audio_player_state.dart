abstract class AudioPlayerState{}

class AudioPlayerLoadingState extends AudioPlayerState{}
class AudioPlayerPlayState extends AudioPlayerState{}
class AudioPlayerPauseState extends AudioPlayerState{}
class AudioPlayerResumeState extends AudioPlayerState{}
class AudioPlayerSeekState extends AudioPlayerState{}
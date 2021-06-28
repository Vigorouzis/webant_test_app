abstract class SendImageState {
  const SendImageState();
}

class InitSendImageState extends SendImageState {}

class SendImageLoading extends SendImageState {}

class SendImageSuccess extends SendImageState {}

class SendImageError extends SendImageState {}

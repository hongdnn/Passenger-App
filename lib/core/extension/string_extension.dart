extension StringNullExtension on String? {
  bool isNullOrEmpty() {
    if (this == null) return true;
    return this!.isEmpty;
  }
}

extension StringX on String {
  bool isMedia() {
    return isPhoto() || isVideo();
  }

  bool isPhoto() {
    final RegExp photo = RegExp(r'^.*(\.(jpe?g|jpe|png|gif|bmp))$');
    return photo.hasMatch(toLowerCase());
  }

  bool isVideo() {
    final RegExp video = RegExp(r'^.*(\.(mp3|mp4|mkv|mov|3gp))$');
    return video.hasMatch(toLowerCase());
  }
}

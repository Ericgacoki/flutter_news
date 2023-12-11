String formatRelativeDate(String inputDate, {DateTime? currentDate}) {
  currentDate ??= DateTime.now();
  DateTime parsedDate = DateTime.parse(inputDate);
  Duration difference = currentDate.difference(parsedDate);

  if (difference.inSeconds < 60) {
    return 'just now';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
  } else if (difference.inDays == 1) {
    return 'yesterday';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
  } else if (difference.inDays < 14) {
    return 'last week';
  } else if (difference.inDays < 30) {
    return '2 weeks ago';
  } else if (difference.inDays < 60) {
    return 'last month';
  } else if (difference.inDays < 365) {
    return '${(difference.inDays / 30).round()} months ago';
  } else if (difference.inDays < 730) {
    return 'last year';
  } else {
    return '${(difference.inDays / 365).round()} years ago';
  }
}

String formatAuthor(String? author) {
  if (author == null || author.isEmpty) {
    return 'Unknown Author';
  }

  List<String> authors = author.split(',');

  if (authors.isEmpty) {
    return 'Unknown Author';
  }

  String firstName = authors[0];
  int additionalAuthors = authors.length - 1;

  var other =  additionalAuthors > 1 ? "others" : "other";
  return additionalAuthors > 0 ? '$firstName and $additionalAuthors $other'  : firstName;
}

String countAuthors(String? author) {
  if (author == null) {
    return '1';
  }

  List<String> authors = author.split(',');

  if (authors.isEmpty) {
    return '1';
  }

  int totalAuthors = authors.length;

  return totalAuthors > 0 ? totalAuthors.toString() : "1";
}

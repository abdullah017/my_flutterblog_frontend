String capitalize(String text) {
  if (text.isEmpty) return text;

  return text.split('-').map((word) {
    if (word.isNotEmpty) {
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }
    return word;
  }).join(' ');
}

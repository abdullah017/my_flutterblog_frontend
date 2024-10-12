class RouteSlugHelper {
  String slugify(String title) {
    return title
        .toLowerCase()
        .replaceAll(RegExp(r'\s+'), '-')
        .replaceAll(RegExp(r'[^\w\-]'), '');
  }
}

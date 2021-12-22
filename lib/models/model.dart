class Model {
  final String label;
  final String method;
  final String route;
  final String key;
  final String? description;

  const Model({
    required this.label,
    required this.method,
    required this.route,
    required this.key,
    this.description,
  });
}

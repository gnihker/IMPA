class Model {
  final String label;
  final String method;
  final String route;
  final String? description;

  const Model({
    required this.label,
    required this.method,
    required this.route,
    this.description,
  });
}

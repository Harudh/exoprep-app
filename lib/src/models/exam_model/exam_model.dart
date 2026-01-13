class Exam {
  final String id;
  final String name;
  final List<Exam> children;

  Exam({required this.id, required this.name, required this.children});

  factory Exam.fromJson(Map<String, dynamic> json) {
    final childrenJson = json['children'] as List?;
    return Exam(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      children: childrenJson == null ? [] : childrenJson.map((child) => Exam.fromJson(child as Map<String, dynamic>)).toList(),
    );
  }

  @override
  String toString() {
    if (children.isEmpty) {
      return 'Exam(id: $id, name: $name)';
    }
    return 'Exam(id: $id, name: $name, children: ${children.map((e) => e.toString()).toList()})';
  }
}

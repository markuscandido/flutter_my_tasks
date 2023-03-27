abstract class Entity<T> {
  final int? id;

  Entity({
    required this.id,
  });

  Map<String, Object?> toJson();
}

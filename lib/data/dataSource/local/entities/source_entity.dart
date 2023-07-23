import 'package:equatable/equatable.dart';

class SourceEntity extends Equatable {
  final String? id;
  final String? name;

  const SourceEntity({
    this.id,
    this.name,
  });

  SourceEntity copyWith({
    String? id,
    String? name,
  }) {
    return SourceEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory SourceEntity.fromMap(Map<String, dynamic> map) {
    return SourceEntity(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name];
}

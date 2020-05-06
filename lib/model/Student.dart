import 'package:floor/floor.dart';

@entity
class Student {
  @PrimaryKey(autoGenerate: true)
  final int id;

  final String name;
  final String school;

  Student({this.id, this.name, this.school});

  @override
  String toString() {
    return 'Student{id: $id, name: $name, school: $school}';
  }
}

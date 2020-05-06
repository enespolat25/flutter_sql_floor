import '../../model/Student.dart';
import 'package:floor/floor.dart';


@dao
abstract class StudentDao {
  @Query('SELECT * FROM student WHERE id = :id')
  Future<Student> findStudentById(int id);

  @Query('SELECT * FROM student')
  Future<List<Student>> findAllStudent();

  @Query('SELECT * FROM student')
  Stream<List<Student>> findAllStudentsAsStream();

  @insert
  Future<void> insertStudent(Student student);

  @insert
  Future<void> insertStudents(List<Student> students);

  @update
  Future<void> updateStudent(Student student);

  @update
  Future<void> updateStudents(List<Student> student);

  @delete
  Future<void> deleteStudent(Student student);

  @delete
  Future<void> deleteStudents(List<Student> students);
}

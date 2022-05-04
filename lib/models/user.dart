import 'phone.dart';

class User {
  final int? id;
  final String name;
  final Phone phone;
  final String age;
  final String height;
  final String cpf;

  User({
    this.id,
    required this.phone,
    required this.name,
    required this.age,
    required this.height,
    required this.cpf,
  });

  @override
  String toString() {
    return 'User(name: $name, age: $age, height: $height, cpf: $cpf)';
  }
}

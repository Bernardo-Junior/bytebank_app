class Contact {
  final int id;
  final String name;
  final int accountNumber;

  Contact({
    required this.id,
    required this.name,
    required this.accountNumber,
  });

  @override
  String toString() =>
      'Contact(id: $id, name: $name, accountNumber: $accountNumber)';
}

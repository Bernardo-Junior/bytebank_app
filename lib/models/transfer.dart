class Transfer {
  final int? id;
  final double value;
  final String account;

  Transfer({this.id, required this.account, required this.value});

  @override
  String toString() => 'Transfer(value: $value, account: $account)';
}

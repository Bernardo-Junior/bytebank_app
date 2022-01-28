class Transfer {
  final double value;
  final String account;

  Transfer(this.account, this.value);

  @override
  String toString() => 'Transfer(value: $value, account: $account)';
}

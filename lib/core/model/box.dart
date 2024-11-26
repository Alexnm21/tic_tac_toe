class Box {
  final int row;
  final int col;
  final String value;

  Box({required this.row, required this.col, required this.value});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'row': row,
      'col': col,
      'value': value,
    };
  }

  factory Box.fromMap(Map<String, dynamic> map) {
    return Box(
      row: map['row'] as int,
      col: map['col'] as int,
      value: map['value'] as String,
    );
  }
}

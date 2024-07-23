class Instruction {
  final String step;
  final int number;

  Instruction({required this.step, required this.number});

  factory Instruction.fromJson(Map<String, dynamic> json) {
    return Instruction(
      step: json['step'], number: json['number'],
    );
  }
}
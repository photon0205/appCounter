import 'package:equatable/equatable.dart';

class CounterState extends Equatable {
  const CounterState(
      {required this.counter,
      required this.wasIncremented,
      required this.wasDecremented});
  final int counter;
  final bool wasIncremented;
  final bool wasDecremented;

  @override
  List<Object> get props => [counter, wasIncremented, wasDecremented];
}

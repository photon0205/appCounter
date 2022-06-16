import 'counter_state.dart';
import 'counter_event.dart';
import 'package:bloc/bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc(int counter)
      : super(CounterState(
            counter: counter, wasIncremented: false, wasDecremented: false)) {
    on<Increment>((event, emit) => emit(CounterState(
        counter: state.counter + 1,
        wasIncremented: true,
        wasDecremented: false)));
    on<Decrement>((event, emit) => emit(CounterState(
        counter: state.counter - 1,
        wasIncremented: false,
        wasDecremented: true)));
  }
}

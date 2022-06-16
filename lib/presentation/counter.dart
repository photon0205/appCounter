// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/model/api_model.dart';
import '../services/api.dart';
import '../core/locator.dart';
import '../services/local_storage_service.dart';
import 'bloc/counter_bloc.dart';
import 'bloc/counter_event.dart';
import 'bloc/counter_state.dart';

int counter = 0;
String bin = "";

// ignore: use_key_in_widget_constructors
class CounterPage extends StatelessWidget {
  initState() async {
    await setupLocator();
    LocalStorageService localStorageService = locator<LocalStorageService>();
    counter = localStorageService.getCounter();
  }

  final LocalStorageService localStorageService;
  CounterPage({
    Key? key,
    required this.localStorageService,
  }) : super(key: key);

  final DioClient n = DioClient();

  @override
  Widget build(BuildContext context) {
    counter = localStorageService.getCounter();
    return BlocProvider(
      create: (_) => CounterBloc(counter),
      child: (BlocConsumer<CounterBloc, CounterState>(
        listener: (context, state) {
          if (state.wasIncremented == true) {
            // ignore: deprecated_member_use
            Scaffold.of(context).showSnackBar(
              SnackBar(
                  content: Text('Incremented to ${state.counter}'),
                  duration: const Duration(milliseconds: 1000),
                  elevation: 1000,
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      BlocProvider.of<CounterBloc>(context)
                          .add(const Decrement());
                    },
                  )),
            );
          } else if (state.wasDecremented == true) {
            // ignore: deprecated_member_use
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Decremented to ${state.counter}'),
              duration: const Duration(milliseconds: 1000),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  BlocProvider.of<CounterBloc>(context).add(const Increment());
                },
              ),
            ));
          }
        },
        builder: (context, state) {
          localStorageService.setCounter(state.counter);
          return Center(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const Text("For Counter Number watch for the SnackBar"),
            const SizedBox(
              height: 350,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterBloc>(context)
                        .add(const Increment());
                  },
                  child: const Icon(Icons.add),
                ),
                const SizedBox(
                  height: 8,
                ),
                FutureBuilder<Binary?>(
                    future: n.getBinary(number: state.counter),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Binary? data = snapshot.data;
                        if (data != null) {
                          bin = data.converted;
                          var t = state.counter;
                          return Text("$t\n in Binary is: \n$bin",
                              textAlign: TextAlign.center, textScaleFactor: 2);
                        }
                      }
                      return const CircularProgressIndicator();
                    }),
                const SizedBox(
                  height: 8,
                ),
                const SizedBox(
                  height: 8,
                ),
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterBloc>(context)
                        .add(const Decrement());
                  },
                  child: const Icon(Icons.remove),
                ),
              ],
            )
          ]));
        },
      )),
    );
  }
}

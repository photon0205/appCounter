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
      child: (BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          localStorageService.setCounter(state.counter);
          return Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<CounterBloc>(context).add(const Increment());
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
                        return Text(bin);
                      }
                    }
                    return const CircularProgressIndicator();
                  }),
              const SizedBox(
                height: 8,
              ),
              Text(
                state.counter.toString(),
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(
                height: 8,
              ),
              FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<CounterBloc>(context).add(const Decrement());
                },
                child: const Icon(Icons.remove),
              ),
            ],
          ));
        },
      )),
    );
  }
}

import 'package:flutter/material.dart';
import './core/locator.dart';
import './services/local_storage_service.dart';
import './presentation/counter.dart';

LocalStorageService localStorageService = locator<LocalStorageService>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  LocalStorageService localStorageService = locator<LocalStorageService>();
  counter = localStorageService.getCounter();
  runApp(MyApp());
}

int counter = 0;

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Counter App'),
        ),
        body: CounterPage(
          localStorageService: localStorageService,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter hook widget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

T changeNotifierListenable<T extends ChangeNotifier>(T data) {
  final state = useState<T>(data);
  return useListenable(state.value);
}

class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final counterChangeNotifier =
        changeNotifierListenable(CounterChangeNotifier());

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Hook Widget Exercise'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              counterChangeNotifier.counter.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          counterChangeNotifier.newCounter();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class CounterChangeNotifier extends ChangeNotifier {
  int counter = 0;
  Future<void> newCounter() async {
    counter += 1;
    notifyListeners();
  }
}

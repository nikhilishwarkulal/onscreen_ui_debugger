import 'package:flutter/material.dart';
import 'package:onscreen_ui_debugger/debug_helper/debug_log_bloc.dart';
import 'package:onscreen_ui_debugger/debug_helper/debug_utilities.dart';
import 'package:onscreen_ui_debugger/debug_helper/debug_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: (context, child) {
        return Stack(
          children: [
            child ?? Container(),
            Overlay(
              initialEntries: [
                OverlayEntry(
                  builder: (context) => const DebugWidget(),
                ),
              ],
            ),
          ],
        );
      },
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      DebugLog debugLog =
          DebugLog(logTitle: "Counter Log", dateTime: DateTime.now());
      debugLog.logStrings.add(DebugLogString(
          logTitle: "Before Increment", logsDescription: _counter.toString()));
      _counter++;
      debugLog.logStrings.add(DebugLogString(
          logTitle: "After Increment", logsDescription: _counter.toString()));
      (_counter % 2 == 0) ? debugLog.setAsSad() : debugLog.setAsBlue();
      DebugUtils.debugLogBloc.addDebugLog(debugLog);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

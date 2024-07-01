import 'package:flutter/material.dart';
import 'business_logic.dart';
import 'dart:async';

// 1. エントリーポイントのmain関数
void main() {
  // 2. MyAppを呼び出す
  runApp(const MyApp());
}

// MyAppのクラス
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 3. タイトルとテーマを設定する。 画面の本体はMyHomePageで作る。
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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
  /* floatingActionButton及び_incrementCounterは不要のため削除 */
  var intStream = StreamController<int>();
  var stringStream = StreamController<String>.broadcast();

  // 初期化時に各クラスにStreamを渡す @override
  void initState() {
    super.initState();
    Generator(intStream);
    Coordinator(intStream, stringStream);
    Consumer(stringStream);
  }

  // 終了時にStreamを解放する @override
  void dispose() {
    super.dispose();
    intStream.close();
    stringStream.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder<String>(
              stream: stringStream.stream,
              initialData: "",
              builder: (context, snapshot) {
                return Text(
                  '${snapshot.data}',
                  style: Theme.of(context).textTheme.displayMedium,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

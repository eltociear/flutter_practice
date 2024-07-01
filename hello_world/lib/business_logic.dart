import "dart:math" as math;
import "dart:async";

// Generatorクラス
// データの生成を担当する
class Generator {
  // コンストラクタで int 型の Stream を受け取る
  Generator(StreamController<int> intStream) {
    // 10秒に1度、 整数の乱数を作ってStreamに流す
    Timer.periodic(
      const Duration(seconds: 10),
      (timer) {
        int data = math.Random().nextInt(100);
        print("Generator が $data を作ったよ ");
        intStream.sink.add(data);
      },
    );
  }
}

// Coordinatorクラス
// データの加工を担当する
class Coordinator {
  // コンストラクタで int 型の Stream と String 型の Stream を受け取る
  Coordinator(
      StreamController<int> intStream, StreamController<String> stringStream) {
    // 流れてきたものをintからStringにする
    intStream.stream.listen((data) async {
      String newData = data.toString();
      print("Coordinator が $data( 数値 ) から $newData( 文字列 ) に変換したよ ");
      stringStream.sink.add(newData);
    });
  }
}

// Consumerクラス
// データの利用を担当する
class Consumer {
  // コンストラクタでString型のStreamを受け取る
  Consumer(StreamController<String> stringStream) {
    // Streamをlistenしてデータが来たらターミナルに表示する
    stringStream.stream.listen((data) async {
      print("Consumer が $data を使ったよ ");
    });
  }
}

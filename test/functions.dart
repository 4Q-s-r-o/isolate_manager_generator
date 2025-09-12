import 'package:isolate_manager/isolate_manager.dart';

@isolateManagerWorker
void myWorkerFunction(String message) {
  print('Received: \$message');
}

@isolateManagerCustomWorker
void myCustomWorkerFunction(dynamic params) {
  print('Custom worker processing: \$params');
}

@isolateManagerSharedWorker
void mySharedWorkerFunction(dynamic params) {
  print('Shared worker processing: \$params');
}

class MyService {
  void regularMethod() {
    print('This is a regular method.');
  }

  @isolateManagerWorker
  static void myWorkerMethod(int number) {
    print('Processing number: \$number');
  }

  @isolateManagerCustomWorker
  static void myCustomWorkerFunction(dynamic params) {
    print('Custom worker processing: \$params');
  }

  @isolateManagerSharedWorker
  static void mySharedWorkerFunction(dynamic params) {
    print('Shared worker processing: \$params');
  }
}

void anotherFunction() {
  print('Not a worker.');
}

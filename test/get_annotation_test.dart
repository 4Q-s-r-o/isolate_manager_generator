import 'dart:io';

import 'package:isolate_manager_generator/src/utils.dart';
import 'package:test/test.dart';

void main() {
  test('Get annotations test', () async {
    final annotations = await parseAnnotations('test/functions.dart', [
      'isolateManagerWorker',
      'isolateManagerCustomWorker',
      'isolateManagerSharedWorker',
    ]);

    expect(
      annotations,
      equals({
        'isolateManagerWorker': [
          'myWorkerFunction',
          'MyService.myWorkerMethod'
        ],
        'isolateManagerCustomWorker': [
          'myCustomWorkerFunction',
          'MyService.myCustomWorkerFunction'
        ],
        'isolateManagerSharedWorker': [
          'mySharedWorkerFunction',
          'MyService.mySharedWorkerFunction'
        ]
      }),
    );
  });

  test('Generate js', () async {
    final process = await Process.run(
      Platform.resolvedExecutable,
      [
        'run',
        'isolate_manager_generator',
        '--input',
        'test/',
        '--output',
        'test/output',
      ],
    );

    expect(
      process.stdout,
      contains('Compiled: test/output/myCustomWorkerFunction.js'),
    );
    expect(
      process.stdout,
      contains('Compiled: test/output/MyService.myCustomWorkerFunction.js'),
    );
    expect(
      process.stdout,
      contains('Compiled: test/output/myWorkerFunction.js'),
    );
    expect(
      process.stdout,
      contains('Compiled: test/output/MyService.myWorkerMethod.js'),
    );

    for (final fileName in [
      'myCustomWorkerFunction.js',
      'MyService.myCustomWorkerFunction.js',
      'myWorkerFunction.js',
      'MyService.myWorkerMethod.js',
    ]) {
      expect(File('test/output/$fileName').existsSync(), isTrue);
    }

    Directory('test/output').deleteSync(recursive: true);
  });
}

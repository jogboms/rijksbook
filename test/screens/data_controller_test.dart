import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rijksbook/screens.dart';

import '../mocks.dart';

void main() {
  group('Data controller', () {
    final List<ConnectionState> expectedConnectionStatesInOrder = <ConnectionState>[
      ConnectionState.waiting,
      ConnectionState.done,
    ];

    group('DetailDataController', () {
      test('can fetch', () async {
        final DetailDataController controller = DetailDataController(
          (_) async => dummyArtDetailModel,
          id: '',
        );

        final Recorder recorder = Recorder();
        controller.addListener(() => recorder(controller.state));

        await controller.fetch();

        expect(recorder.states, containsAllInOrder(expectedConnectionStatesInOrder));
        expect(controller.data, dummyArtDetailModel);
        expect(controller.isLoading, false);
        expect(controller.hasError, false);
      });

      test('can handle errors', () async {
        final DetailDataController controller = DetailDataController(
          (_) async => throw 'Error',
          id: '',
        );

        final Recorder recorder = Recorder();
        controller.addListener(() => recorder(controller.state));

        await controller.fetch();

        expect(recorder.states, containsAllInOrder(expectedConnectionStatesInOrder));
        expect(controller.data, isNull);
        expect(controller.hasError, true);
        expect(controller.error!.message, 'Error');
      });

      test('can retry', () async {
        int requestCount = 0;
        final DetailDataController controller = DetailDataController(
          (_) async {
            if (requestCount == 0) {
              requestCount++;
              throw 'Error';
            }
            return dummyArtDetailModel;
          },
          id: '',
        );

        final Recorder recorder = Recorder();
        controller.addListener(() => recorder(controller.state));

        await controller.fetch();

        expect(recorder.states, containsAllInOrder(expectedConnectionStatesInOrder));
        expect(controller.data, isNull);
        expect(controller.hasError, true);
        expect(controller.error!.message, 'Error');

        recorder.states.clear();

        await controller.retry();

        expect(recorder.states, containsAllInOrder(expectedConnectionStatesInOrder));
        expect(controller.data, dummyArtDetailModel);
        expect(controller.isLoading, false);
        expect(controller.hasError, false);
      });
    });
  });
}

class Recorder {
  final List<ConnectionState> states = <ConnectionState>[];

  void call(ConnectionState state) => states.add(state);
}

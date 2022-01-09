import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rijksbook/domain.dart';
import 'package:rijksbook/screens.dart';

import '../mocks.dart';

void main() {
  group('Data controller', () {
    final List<ConnectionState> expectedConnectionStatesInOrder = <ConnectionState>[
      ConnectionState.waiting,
      ConnectionState.done,
    ];

    group('PagedDataController', () {
      test('can fetch', () async {
        final PagedDataController controller = PagedDataController(
          ({required int page}) async => dummyArtModelList,
        );

        final Recorder recorder = Recorder();
        controller.addListener(() => recorder(controller.state));

        await controller.fetch();

        expect(recorder.states, containsAllInOrder(expectedConnectionStatesInOrder));
        expect(controller.data, dummyArtModelList);
        expect(controller.page, 1);
        expect(controller.isLoading, false);
        expect(controller.hasError, false);
      });

      test('should have a pure fetch', () async {
        final PagedDataController controller = PagedDataController(
          ({required int page}) async => dummyArtModelList,
        );

        final Recorder recorder = Recorder();
        controller.addListener(() => recorder(controller.state));

        await controller.fetch();
        await controller.fetch();
        await controller.fetch();
        await controller.fetch();

        expect(recorder.states, containsAllInOrder(expectedConnectionStatesInOrder));
        expect(controller.data, dummyArtModelList);
        expect(controller.page, 1);
        expect(controller.isLoading, false);
        expect(controller.hasError, false);
      });

      test('can fetch next page', () async {
        final PagedDataController controller = PagedDataController(
          ({required int page}) async => dummyArtModelList,
        );

        final Recorder recorder = Recorder();
        controller.addListener(() => recorder(controller.state));

        await controller.fetch();

        expect(recorder.states, containsAllInOrder(expectedConnectionStatesInOrder));
        expect(controller.data, dummyArtModelList);
        expect(controller.page, 1);
        expect(controller.isLoading, false);
        expect(controller.hasError, false);

        await controller.next();
        await controller.next();

        expect(recorder.states, containsAllInOrder(expectedConnectionStatesInOrder));
        expect(controller.data, <Art>[...dummyArtModelList, ...dummyArtModelList, ...dummyArtModelList]);
        expect(controller.page, 3);
        expect(controller.isLoading, false);
        expect(controller.hasError, false);
      });

      test('can handle errors', () async {
        final PagedDataController controller = PagedDataController(
          ({required int page}) async => throw 'Error',
        );

        final Recorder recorder = Recorder();
        controller.addListener(() => recorder(controller.state));

        await controller.fetch();

        expect(recorder.states, containsAllInOrder(expectedConnectionStatesInOrder));
        expect(controller.data, const <Art>[]);
        expect(controller.page, 1);
        expect(controller.hasError, true);
        expect(controller.error!.message, 'Error');
      });

      test('can handle errors and keep previous data', () async {
        int requestCount = 0;
        final PagedDataController controller = PagedDataController(
          ({required int page}) async {
            if (requestCount == 1) {
              throw 'Error';
            }
            requestCount++;
            return dummyArtModelList;
          },
        );

        final Recorder recorder = Recorder();
        controller.addListener(() => recorder(controller.state));

        await controller.fetch();
        await controller.fetch();

        expect(controller.data, dummyArtModelList);
        expect(controller.page, 1);
        expect(controller.isLoading, false);
        expect(controller.hasError, true);
        expect(controller.error!.message, 'Error');
      });

      test('can retry', () async {
        int requestCount = 0;
        final PagedDataController controller = PagedDataController(
          ({required int page}) async {
            if (requestCount == 0) {
              requestCount++;
              throw 'Error';
            }
            return dummyArtModelList;
          },
        );

        final Recorder recorder = Recorder();
        controller.addListener(() => recorder(controller.state));

        await controller.fetch();

        expect(recorder.states, containsAllInOrder(expectedConnectionStatesInOrder));
        expect(controller.data, const <Art>[]);
        expect(controller.page, 1);
        expect(controller.hasError, true);
        expect(controller.error!.message, 'Error');

        await controller.retry();

        expect(recorder.states, containsAllInOrder(expectedConnectionStatesInOrder));
        expect(controller.data, dummyArtModelList);
        expect(controller.page, 1);
        expect(controller.isLoading, false);
        expect(controller.hasError, false);
      });

      test('should retry on the same page', () async {
        int requestCount = 0;
        final PagedDataController controller = PagedDataController(
          ({required int page}) async {
            if (requestCount == 2) {
              throw 'Error';
            }
            requestCount++;
            return dummyArtModelList;
          },
        );

        final Recorder recorder = Recorder();
        controller.addListener(() => recorder(controller.state));

        await controller.fetch();
        await controller.next();
        await controller.next();

        expect(recorder.states, containsAllInOrder(expectedConnectionStatesInOrder));
        expect(controller.data, <Art>[...dummyArtModelList, ...dummyArtModelList]);
        expect(controller.page, 2);
        expect(controller.hasError, true);
        expect(controller.error!.message, 'Error');

        await controller.retry();

        expect(controller.page, 2);
        expect(controller.hasError, true);
      });
    });

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

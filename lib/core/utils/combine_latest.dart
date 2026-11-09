import 'dart:async';

Stream<R> combineLatest2<A, B, R>(
  Stream<A> first,
  Stream<B> second,
  R Function(A firstValue, B secondValue) combine,
) {
  late final StreamController<R> controller;
  StreamSubscription<A>? firstSubscription;
  StreamSubscription<B>? secondSubscription;
  ({A value})? firstLatest;
  ({B value})? secondLatest;
  var firstDone = false;
  var secondDone = false;

  void emitIfReady() {
    final firstValue = firstLatest;
    final secondValue = secondLatest;
    if (firstValue != null && secondValue != null) {
      controller.add(combine(firstValue.value, secondValue.value));
    }
  }

  controller = StreamController<R>(
    onListen: () {
      firstSubscription = first.listen(
        (value) {
          firstLatest = (value: value);
          emitIfReady();
        },
        onError: controller.addError,
        onDone: () {
          firstDone = true;
          if (secondDone) controller.close();
        },
      );
      secondSubscription = second.listen(
        (value) {
          secondLatest = (value: value);
          emitIfReady();
        },
        onError: controller.addError,
        onDone: () {
          secondDone = true;
          if (firstDone) controller.close();
        },
      );
    },
    onCancel: () async {
      await firstSubscription?.cancel();
      await secondSubscription?.cancel();
    },
  );

  return controller.stream;
}

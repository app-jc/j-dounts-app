import 'dart:async';

import 'package:j_dounts_app/core/error/result.dart';

Stream<Result<T>> toResultStream<T>(Stream<T> source) => source.transform(
  StreamTransformer<T, Result<T>>.fromHandlers(
    handleData: (value, sink) => sink.add(Success<T>(value)),
    handleError: (error, stackTrace, sink) {
      sink.add(FailureResult<T>(StorageFailure(cause: error)));
    },
  ),
);

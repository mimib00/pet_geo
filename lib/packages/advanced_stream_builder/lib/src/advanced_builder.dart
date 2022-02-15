import 'package:flutter/widgets.dart';
import 'package:stream_transform/stream_transform.dart';

class AdvancedStreamBuilder<T> extends StatelessWidget {
  final List<Stream<T>> streams;
  final AsyncWidgetBuilder<List<T>> builder;

  /// This widget let's you build UI from more then 1 stream
  ///
  /// streams are stored as a list so you have to loop throgh to access them all.
  const AdvancedStreamBuilder({
    Key? key,
    required this.streams,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var first = streams[0];
    streams.removeAt(0);
    var stream = first.combineLatestAll(streams);

    return StreamBuilder<List<T>>(
      stream: stream,
      builder: (context, snapshot) {
        return builder(context, snapshot);
      },
    );
  }
}

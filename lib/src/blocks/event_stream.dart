
import 'dart:async';


import 'package:axiluniv/src/models/event.dart';

class EventStream {
  static StreamController<Event> _streamController = new StreamController.broadcast();

  static Stream<Event> getStream() {
    return _streamController.stream;
  }

  static void putEvent(Event event) {
    print("EventCreated:");
    print(event.eventType.toString());
    _streamController.sink.add(event);
  }
}



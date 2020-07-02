

class Event {
  EventType _eventType;
  int _id;

  Event(EventType eventType) {
    _eventType = eventType;
  }

  EventType get eventType => _eventType;

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}

enum EventType {
  PAGE_REFRESHED,

}
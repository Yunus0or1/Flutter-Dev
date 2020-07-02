import 'feed_info.dart';

class FeedRequest {
  FeedInfo _feedInfo;
  int _nextFromId = 0;
  String _session = "";
  int _userId = 0;
  int _feedSize = 15;

  FeedRequest(FeedInfo feedInfo, nextFromId, session) {
    _feedInfo = feedInfo;
    _nextFromId = nextFromId;
    _session = session;
  }

  FeedInfo get feedInfo => _feedInfo;

  get session => _session;

  set session(value) {
    _session = value;
  }

  get nextFromId => _nextFromId;

  set nextFromId(value) {
    _nextFromId = value;
  }

  get userId => _userId;

  set userId(value) {
    _userId = value;
  }

  int get feedSize => _feedSize;

  set feedSize(int value) {
    _feedSize = value;
  }
}

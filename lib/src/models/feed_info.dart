class FeedInfo {

  int _userId = 0;
  FeedType_Enum _feedType = FeedType_Enum.MAIN_FEED;

  FeedInfo(FeedType_Enum feedType) {
    _feedType = feedType;
  }

  FeedType_Enum get feedType => _feedType;

  get userId => _userId;

  set userId(value) {
    _userId = value;
  }

  Map<String, dynamic> toJsonMap() {
    final data = Map<String, dynamic>();
    data['_userId'] = _userId.toString();
    data['_feedType'] = FeedType_Enum.MAIN_FEED.toString();
    return data;
  }
}

enum FeedType_Enum { MAIN_FEED }

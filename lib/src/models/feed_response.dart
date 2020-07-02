import 'package:axiluniv/src/models/course.dart';
import 'package:axiluniv/src/models/feed_info.dart';
import 'package:axiluniv/src/models/feed_item.dart';

class FeedResponse {
  bool status;
  bool lastfeed;
  String response;
  int nextFromId;
  String session;
  FeedType_Enum feedType_Enum;
  List<FeedItem> feedItems;
  bool error;

  FeedResponse(
      {this.status,
      this.lastfeed,
      this.nextFromId,
      this.session,
      this.feedType_Enum,
      this.response,
      this.feedItems,
      this.error});

  factory FeedResponse.fromJson(Map<String, dynamic> json) {
    return FeedResponse(
      status: json['status'],
      lastfeed: json['lastfeed'],
      nextFromId: json['nextFromId'],
      session: json['session'],
      feedType_Enum: getFeedType(json['feedType_Enum']),
      response: json['response'],
      error: json['error'],
      feedItems: (json['feedItems'] as List)
          .map((item) => FeedItem.fromJson(item))
          .toList(),
    );
  }

  static FeedType_Enum getFeedType(String feedType) {
    if (feedType == "MAIN_FEED") return FeedType_Enum.MAIN_FEED;
  }
}

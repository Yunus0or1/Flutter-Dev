import 'dart:async';
import 'package:axiluniv/src/blocks/event_stream.dart';
import 'package:axiluniv/src/client/main_client.dart';
import 'package:axiluniv/src/component/general/common_ui.dart';
import 'package:axiluniv/src/models/event.dart';
import 'package:axiluniv/src/models/feed_info.dart';
import 'package:axiluniv/src/models/feed_item.dart';
import 'package:axiluniv/src/models/feed_request.dart';
import 'package:axiluniv/src/models/feed_response.dart';
import 'package:axiluniv/src/models/user.dart';
import 'package:axiluniv/src/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tuple/tuple.dart';

import 'feed_card_handler.dart';

class FeedContainer extends StatefulWidget {
  final FeedInfo feedInfo;

  const FeedContainer(this.feedInfo, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FeedContainerState(feedInfo);
  }
}

class _FeedContainerState extends State<FeedContainer>
    with AutomaticKeepAliveClientMixin<FeedContainer> {
  final FeedInfo feedInfo;
  List<FeedItem> feedItems;
  FeedResponse feedResponse = new FeedResponse();
  bool loadMoreOngoing = false;
  bool noMoreItems = false;
  bool noInternet = false;
  bool noServer = false;

  _FeedContainerState(this.feedInfo);

  @override
  void initState() {
    super.initState();
    feedItems = new List();
    clearItems();
    refreshFeed();
    eventChecker();
  }

  void eventChecker() async {
    EventStream.getStream().listen((data) {
      if (data.eventType == EventType.PAGE_REFRESHED) {
        feedItems.clear();
        refreshFeed();
      }
    });
  }

  void refreshUI() {
    if (mounted)
      setState(() {
        refreshFeed();
      });
  }

  void clearItems() {
    if (mounted)
      setState(() {
        feedItems.clear();
      });
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  Future<void> refreshFeed() async {
    loadMoreOngoing = true;
    FeedRequest feedRequest = new FeedRequest(widget.feedInfo, 0, '');
    User user = Store.instance.appState.currentUser;
    feedRequest.userId = user.id;
    requestLoadFeed(feedRequest);
  }

  Future<void> loadMoreFeed() async {
    if (loadMoreOngoing) return;
    loadMoreOngoing = true;

    if (noMoreItems == true) {
      return;
    }

    FeedRequest feedRequest = new FeedRequest(widget.feedInfo, 0, '');

    if (noMoreItems != true) {
      feedRequest = new FeedRequest(
          widget.feedInfo, feedResponse.nextFromId, feedResponse.session);
    }
    User user = Store.instance.appState.currentUser;
    feedRequest.userId = user.id;

    requestLoadFeed(feedRequest);
  }

  Future<void> requestLoadFeed(FeedRequest feedRequest) async {
    noInternet = false;
    noServer = false;
    feedResponse = await MainClient.instance.getMainFeed(feedRequest);

    if (feedResponse.error == false) {
      addItems(feedResponse.feedItems);
    }

    if (mounted) setState(() {});
    loadMoreOngoing = false;
  }

  void addItems(List<FeedItem> items) {
    if (mounted)
      setState(() {
        feedItems.addAll(items);
      });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (noInternet == true) {
      return noInternetView(refreshFeed);
    }
    if (noServer == true) {
      return noServerView(refreshFeed);
    }
    if (noMoreItems == true && feedItems.length == 0) {
      return noItemView(refreshFeed);
    }
    return buildFeedView();
  }

  Widget buildFeedView() {
    int length = feedItems.length + 1;

    return RefreshIndicator(
      onRefresh: refreshFeed,
      backgroundColor: Colors.black,
      child: Container(
        color: Colors.grey[50],
        child: ListView.builder(
          padding: EdgeInsets.all(0),
          itemCount: length,
          itemBuilder: (context, int index) {
            // load more call before ending feed.
            if (index + 2 >= length) loadMoreFeed();

            // build feed or sshow loading spinner
            return index >= feedItems.length
                ? (noMoreItems ? Container() : loadingSpinner())
                : buildFeedCard(feedItems[index]);
          },
        ),
      ),
    );
  }

  Widget buildFeedCard(FeedItem item) {
    return FeedCardHandler(feedInfo, item);
  }

  Widget loadingSpinner() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: SpinKitFadingCircle(
        color: Colors.orangeAccent,
        size: 30,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

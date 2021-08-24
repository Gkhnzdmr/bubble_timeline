library bubble_timeline;

import 'package:flutter/material.dart';
import 'package:bubble_timeline/timeline_item.dart';

class Config {
  static String rightDirection = 'R';
  static String leftDirection = 'L';
}

/// A Bubble Timeline Widget.
class BubbleTimeline extends StatefulWidget {
  final double bubbleDiameter;
  final List<TimelineItem> items;
  final Color stripColor;

  /// This is color of your scaffold.
  /// Use same color as used for Scaffold background.
  final Color scaffoldColor;

  const BubbleTimeline({
    @required this.bubbleDiameter,
    @required this.items,
    @required this.stripColor,
    @required this.scaffoldColor,
  });

  @override
  _BubbleTimelineState createState() => _BubbleTimelineState();
}

class _BubbleTimelineState extends State<BubbleTimeline> {
  bool checkEven(int n) {
    return n % 2 == 0;
  }

  List<TimelineBubble> createTimeline() {
    final List<TimelineBubble> _items = [];
    for (var i = 0; i < widget.items.length; i++) {
      _items.add(
        TimelineBubble(
          direction: widget.items[i].widgetDirection,
          size: widget.bubbleDiameter,
          title: widget.items[i].title,
          subtitle: widget.items[i].subtitle,
          description: widget.items[i].description,
          icon: widget.items[i].child,
          stripColor: widget.stripColor,
          bubbleColor: widget.items[i].bubbleColor,
          bgColor: widget.scaffoldColor,
          subtitleDirection: widget.items[i].subtitleDirection,
          descriptionDirection: widget.items[i].descriptionDirection,
        ),
      );
    }
    return _items;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TopHandle(widget.stripColor),
            ...createTimeline(),
            BottomHandle(widget.stripColor),
          ],
        ),
      ),
    );
  }
}

class TopHandle extends StatelessWidget {
  final Color handleColor;
  const TopHandle(this.handleColor);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: handleColor,
            shape: BoxShape.circle,
          ),
          height: 20,
        ),
        Container(
          height: 20,
          width: 5,
          color: handleColor,
        ),
      ],
    );
  }
}

class BottomHandle extends StatelessWidget {
  final Color handleColor;
  const BottomHandle(this.handleColor);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          width: 5,
          color: handleColor,
        ),
        Container(
          decoration: BoxDecoration(
            color: handleColor,
            shape: BoxShape.circle,
          ),
          height: 20,
        ),
      ],
    );
  }
}

class TimelineBubble extends StatelessWidget {
  final TimelineItemDirection direction;
  final double size;
  final String title;
  final String subtitle;
  final String description;
  final Widget icon;
  final Color stripColor;
  final Color bgColor;
  final Color bubbleColor;
  final TimelineItemDirection subtitleDirection;
  final TimelineItemDirection descriptionDirection;

  const TimelineBubble({
    @required this.direction,
    @required this.size,
    @required this.title,
    @required this.subtitle,
    @required this.description,
    @required this.icon,
    @required this.stripColor,
    @required this.bgColor,
    @required this.bubbleColor,
    @required this.subtitleDirection,
    @required this.descriptionDirection,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                title != null && direction == TimelineItemDirection.Left
                    ? Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(title, textAlign: TextAlign.right),
                        ],
                      )
                    : Container(),
                subtitle != null &&
                        subtitleDirection == TimelineItemDirection.Left
                    ? Column(
                        children: [
                          Text(subtitle, textAlign: TextAlign.right),
                        ],
                      )
                    : Container(),
                description != null &&
                        descriptionDirection == TimelineItemDirection.Left
                    ? Column(
                        children: [
                          Text(description, textAlign: TextAlign.right),
                        ],
                      )
                    : Container()
              ]),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 10,
                width: 5,
                color: stripColor,
              ),
              Container(
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      height: size,
                      child: ClipPath(
                        child: Container(
                          width: size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: stripColor,
                          ),
                        ),
                        clipper: direction == TimelineItemDirection.Left
                            ? LeftClipper()
                            : RightClipper(),
                      ),
                    ),
                    Container(
                      height: size - 10,
                      width: size - 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: bgColor,
                      ),
                    ),
                    Container(
                      height: size - 20,
                      width: size - 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: bubbleColor,
                      ),
                      alignment: Alignment.center,
                      child: icon,
                    ),
                  ],
                ),
              ),
              Container(height: 10, width: 5, color: stripColor),
            ],
          ),
        ),
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                title != null && direction == TimelineItemDirection.Right
                    ? Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(title, textAlign: TextAlign.left),
                        ],
                      )
                    : Container(),
                subtitle != null &&
                        subtitleDirection == TimelineItemDirection.Right
                    ? Column(
                        children: [
                          Text(subtitle, textAlign: TextAlign.left),
                        ],
                      )
                    : Container(),
                description != null &&
                        descriptionDirection == TimelineItemDirection.Right
                    ? Column(
                        children: [
                          Text(description, textAlign: TextAlign.left),
                        ],
                      )
                    : Container()
              ]),
        ),
      ],
    );
  }
}

class RightClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width / 2 + 3, size.height);
    path.lineTo(size.width / 2 + 3, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class LeftClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width / 2 - 3, size.height);
    path.lineTo(size.width / 2 - 3, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

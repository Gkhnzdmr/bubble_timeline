import 'package:flutter/material.dart';

class TimelineItem {
  final String title;
  final String subtitle;
  final String description;
  final Widget child;
  final Color bubbleColor;
  final TimelineItemDirection subtitleDirection;
  final TimelineItemDirection descriptionDirection;
  final TimelineItemDirection widgetDirection;
  const TimelineItem(
      {@required this.title,
      @required this.subtitle,
      @required this.description,
      @required this.child,
      @required this.bubbleColor,
      @required this.subtitleDirection,
      @required this.descriptionDirection,
      @required this.widgetDirection});
}

enum TimelineItemDirection { Left, Right }

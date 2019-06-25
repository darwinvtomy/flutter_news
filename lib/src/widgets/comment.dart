import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../widgets/loading_container.dart';
import 'package:date_format/date_format.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  const Comment({Key key, this.itemId, this.itemMap, this.depth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }
        final item = snapshot.data;
        final children = <Widget>[
          ListTile(
            leading: Container(
              child: Image.asset(item.avathar),
              color: Colors.blueGrey.shade500,
              height: 50.0,
              width: 50.0,
            ),
            title: item.by == '' ? Text('Deleted') : _NameandTime(item),
            subtitle: commentAndReaction(item: item),
            contentPadding: EdgeInsets.only(
              right: 16.0,
              left: (depth + 1) * 16.0,
            ),
          ),
          Divider()
        ];
        item.kids.forEach((kidId) {
          children.add(
            Comment(
              itemId: kidId,
              itemMap: itemMap,
              depth: depth + 1,
            ),
          );
        });
        return Column(
          children: children,
        );
      },
      future: itemMap[itemId],
    );
  }

  Widget commentAndReaction({ItemModel item}) {
    final text = item.text
        .replaceAll('&#x27;', "'")
        .replaceAll('<p>', '\n\n')
        .replaceAll('&quot;', '\"')
        .replaceAll('&gt;', '>')
        .replaceAll('</p>', '');
    return Column(
crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(text),
        SizedBox(height: 7.0,),
        _reactionWidject(),
      ],
    );
  }

  Widget _reactionWidject() {
    return Wrap(
      spacing: 14.0,
      alignment: WrapAlignment.center,
      direction: Axis.horizontal,
      children: <Widget>[
        GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.thumb_up,
              size: 15,
            )),
        GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.thumb_down,
              size: 15,
            )),
        Text(
          'Replay',
          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _NameandTime(ItemModel item) {
    return Wrap(
      spacing: 14.0,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.horizontal,
      children: <Widget>[
        Text(
          item.by,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          _getProperTime(item.time),
          style: TextStyle(
              fontWeight: FontWeight.w400, color: Colors.grey, fontSize: 12.0),
        )
      ],
    );
  }

  String _getProperTime(int time) {
    final df = formatDate(
        DateTime.fromMillisecondsSinceEpoch(time*1000), [d, ' ', M, ' ', yy]);
    return df;
  }
}

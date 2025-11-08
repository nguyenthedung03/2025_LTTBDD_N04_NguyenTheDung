import 'package:flutter/material.dart';
import 'comments_section.dart';

class CommentsBottomSheet
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(40)),
        color:
            Color(0xfff1f1f1).withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Sheet header
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Bình luận",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () =>
                      Navigator.pop(context),
                  color: Colors.deepPurple,
                ),
              ],
            ),
          ),
          Divider(),
          // Comments section with fixed height
          Container(
            height: MediaQuery.of(context)
                    .size
                    .height *
                0.6, // 60% of screen height
            padding: const EdgeInsets.symmetric(
                horizontal: 20),
            child: CommentsSection(),
          ),
        ],
      ),
    );
  }
}

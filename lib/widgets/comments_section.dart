import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/state_provider.dart';
import '../model/car.dart';

class CommentsSection extends StatefulWidget {
  final Car? car;

  CommentsSection({this.car});

  @override
  _CommentsSectionState createState() =>
      _CommentsSectionState();
}

class _CommentsSectionState
    extends State<CommentsSection> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state =
        Provider.of<StateProvider>(context);
    final car = widget.car ??
        state.currentCar ??
        carList.cars[0];
    final comments = state.getComments(car);

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text('Bình luận',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          if (comments.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8.0),
              child: Text(
                  'Chưa có bình luận nào. Hãy là người đầu tiên!'),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics:
                  NeverScrollableScrollPhysics(),
              itemCount: comments.length,
              separatorBuilder: (_, __) =>
                  Divider(),
              itemBuilder: (context, index) {
                final c = comments[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                      child: Text(
                          c.author.isNotEmpty
                              ? c.author[0]
                                  .toUpperCase()
                              : 'U')),
                  title: Text(c.author),
                  subtitle: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(c.text),
                      SizedBox(height: 4),
                      Text('${c.createdAt}',
                          style: TextStyle(
                              fontSize: 11,
                              color:
                                  Colors.grey)),
                    ],
                  ),
                );
              },
            ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                      hintText:
                          'Viết bình luận...'),
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  final text =
                      _controller.text.trim();
                  if (text.isEmpty) return;
                  final author = state.loggedIn
                      ? (state.userName ??
                          'Người dùng')
                      : 'Khách';
                  state.addComment(
                      car, author, text);
                  _controller.clear();
                },
                child: Text('Gửi'),
              )
            ],
          )
        ],
      ),
    );
  }
}

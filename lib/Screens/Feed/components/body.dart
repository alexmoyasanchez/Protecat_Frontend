import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Feed/feed_screen.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/data.dart';
import 'package:flutter_auth/models/models.dart';

class Body extends StatelessWidget {
  final Future<User> user;

  Body({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
          child: FutureBuilder(
              future: getPosts(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print(snapshot.data);
                if (snapshot.data == null) {
                  return Container(
                      child: Center(
                          child:
                              CircularProgressIndicator(color: DetailsColor)));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 1.0),
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        color: Colors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _PostHeader(post: snapshot.data[index]),
                                  const SizedBox(height: 4.0),
                                  Text(snapshot.data[index].text,
                                      style: TextStyle(color: Colors.black)),
                                  snapshot.data[index].imageUrl != null
                                      ? const SizedBox.shrink()
                                      : const SizedBox(
                                          height: 6.0,
                                        ),
                                ],
                              ),
                            ),
                            snapshot.data[index].imageUrl != " "
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: CachedNetworkImage(
                                        imageUrl:
                                            snapshot.data[index].imageUrl),
                                  )
                                : const SizedBox.shrink(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: _PostStats(post: snapshot.data[index]),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              })),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final Post post;

  const _PostHeader({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
            radius: 20.0,
            backgroundColor: PrimaryColor,
            backgroundImage: NetworkImage(post.user["imageUrl"])),
        const SizedBox(width: 8.0),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              post.user["username"],
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.public,
                  color: Colors.grey[600],
                  size: 12.0,
                )
              ],
            )
          ]),
        ),
      ],
    );
  }
}

class _PostStats extends StatelessWidget {
  final Post post;

  const _PostStats({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String iconofav = "assets/images/star.png";

    for (int i = 0; i < post.likes.length; i++) {
      if (post.likes[i] == user_id) {
        iconofav = "assets/images/star_filed.png";
      }
    }

    return Column(
      children: [
        Row(
          children: [
            Container(
                padding: const EdgeInsets.all(4.0),
                child: const Icon(
                  Icons.star,
                  size: 20.0,
                  color: Colors.yellow,
                )),
            const SizedBox(width: 4.0),
            Expanded(
              child: Text(
                (post.likes.length).toString() + " Favoritos",
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Favorito",
              style: TextStyle(color: Colors.black),
            ),
            IconButton(
              iconSize: 5.0,
              icon: Image.asset(iconofav),
              onPressed: () async {
                if (iconofav == "assets/images/star.png") {
                  await giveLike(user_id, post.id);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FeedScreen();
                  }));
                } else if (iconofav == "assets/images/star_filed.png") {
                  await undoLike(user_id, post.id);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FeedScreen();
                  }));
                }
              },
            ),
          ],
        ),
        Divider(
          color: Background,
          thickness: 1.0,
        ),
      ],
    );
  }
}

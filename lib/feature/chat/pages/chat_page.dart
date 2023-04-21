import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_clone/common/helper/last_seen_message.dart';
import 'package:whatsapp_clone/common/models/user_model.dart';
import 'package:whatsapp_clone/common/routes/routes.dart';
import 'package:whatsapp_clone/common/widgets/custom_icon_button.dart';
import 'package:whatsapp_clone/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/feature/chat/controller/chat_controller.dart';
import 'package:whatsapp_clone/feature/chat/widgets/chat_text_field.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.theme.chatPageBgColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          borderRadius: BorderRadius.circular(20),
          child: Row(
            children: [
              const Icon(Icons.arrow_back),
              Hero(
                tag: 'profile',
                child: Container(
                  width: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(user.profileImageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        title: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.profile,
              arguments: user,
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.username,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 3),
                StreamBuilder(
                  stream: ref
                      .read(authControllerProvider)
                      .getUserPresenceStatus(uid: user.uid),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState != ConnectionState.active) {
                      return const Text(
                        'connecting',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      );
                    }

                    final singleUserModel = snapshot.data!;

                    final lastMessage =
                        lastSeenMessage(singleUserModel.lastSeen);

                    return Text(
                      singleUserModel.active ? "Online" : "$lastMessage ago",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          CustomIconButton(
            onTap: () {},
            icon: Icons.video_call,
            iconColor: Colors.white,
          ),
          CustomIconButton(
            onTap: () {},
            icon: Icons.call,
            iconColor: Colors.white,
          ),
          CustomIconButton(
            onTap: () {},
            icon: Icons.more_vert,
            iconColor: Colors.white,
          ),
        ],
      ),
      body: Stack(
        children: [
          Image(
            height: double.maxFinite,
            width: double.maxFinite,
            image: const AssetImage('assets/images/doodle_bg.png'),
            fit: BoxFit.cover,
            color: context.theme.chatPageDoodleColor,
          ),
          Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: ref
                      .watch(chatControllerProvider)
                      .getAllOneToOneMessage(user.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.active) {
                      print('로딩중');
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.data == null) {}
                    print(snapshot.data!.length);
                    return Container(
                      color: Colors.red,
                    );
                    // return ListView.builder(
                    //   itemCount: snapshot.data!.length,
                    //   itemBuilder: (_, index) {
                    //     final message = snapshot.data![index];
                    //     print(message);
                    //     return Text(message.textMessage);
                    //   },
                    // );
                  },
                ),
              ),
              ChatTextField(receiverId: user.uid),
            ],
          ),
        ],
      ),
    );
  }
}

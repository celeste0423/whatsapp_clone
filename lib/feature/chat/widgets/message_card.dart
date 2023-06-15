import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //as를 이용해서 이름이 겹치는 것을 피할 수 있음
import 'package:whatsapp_clone/common/enum/message_type.dart' as myMessageType;
import 'package:whatsapp_clone/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_clone/common/models/message_model.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({
    super.key,
    required this.isSender,
    required this.haveNip,
    required this.message,
  });

  final bool isSender;
  final bool haveNip;
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      margin: EdgeInsets.only(
        top: 4,
        bottom: 4,
        left: isSender
            ? 80
            : haveNip
                ? 10
                : 15,
        right: isSender
            ? haveNip
                ? 10
                : 15
            : 80,
      ),
      child: ClipPath(
        //특이한 모양 만들 때 쓰는 custom_clippers extenstion
        clipper: haveNip
            ? UpperNipMessageClipperTwo(
                //CustomClipPath 내부에도 MessageType이 있음(모양을 고르기 위해)
                isSender ? MessageType.send : MessageType.receive,
                nipWidth: 8,
                nipHeight: 10,
                bubbleRadius: haveNip ? 12 : 0,
              )
            : null,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: isSender
                    ? context.theme.senderChatCardBg
                    : context.theme.receiverChatCardBg,
                borderRadius: haveNip ? null : BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Colors.black38),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                //여기 MessageType은 우리가 직접 정의한 enum
                child: message.type == myMessageType.MessageType.image
                    ? Padding(
                        padding: const EdgeInsets.only(
                          right: 4,
                          top: 4,
                          left: 4,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image(
                            image:
                                CachedNetworkImageProvider(message.textMessage),
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                          left: isSender ? 10 : 15,
                          right: isSender ? 15 : 10,
                        ),
                        child: Text(
                          "${message.textMessage}         ",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
              ),
            ),
            Positioned(
              bottom: message.type == myMessageType.MessageType.text ? 8 : 4,
              right: message.type == myMessageType.MessageType.text
                  ? isSender
                      ? 15
                      : 10
                  : 4,
              child: message.type == myMessageType.MessageType.text
                  ? Text(
                      DateFormat.Hm().format(message.timeSent),
                      style: TextStyle(
                        fontSize: 11,
                        color: context.theme.greyColor,
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.only(
                        left: 90,
                        right: 12,
                        bottom: 10,
                        top: 10,
                      ),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            //대각선으로
                            begin: const Alignment(0, -1),
                            end: const Alignment(1, 1),
                            colors: [
                              context.theme.greyColor!.withOpacity(0),
                              context.theme.greyColor!.withOpacity(.8),
                            ],
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(300),
                            bottomRight: Radius.circular(100),
                          )),
                      child: Text(
                        DateFormat.Hm().format(message.timeSent),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

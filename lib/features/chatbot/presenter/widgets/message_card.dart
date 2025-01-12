import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../../../helper/global.dart';
import '../../domain/entitites/message.dart';

class MessageCard extends StatelessWidget {
  final Message message;

  const MessageCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(15);

    return message.msgType == MessageType.bot

        //bot
        ? Row(children: [
            const SizedBox(width: 6),

            const CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Image(
                image: AssetImage(
                  "assets/images/bot_logo.png",
                ),
                width: 20,
                color: Colors.grey,
              ),
            ),

            //
            Container(
                constraints: BoxConstraints(maxWidth: mq.width * .6),
                margin: EdgeInsets.only(
                    bottom: mq.height * .02, left: mq.width * .02),
                padding: EdgeInsets.symmetric(
                    vertical: mq.height * .01, horizontal: mq.width * .02),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    // border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: const BorderRadius.only(
                        topLeft: radius,
                        topRight: radius,
                        bottomRight: radius)),
                child: message.msg.isEmpty
                    ? AnimatedTextKit(animatedTexts: [
                        TypewriterAnimatedText(
                          ' ... ',
                          speed: const Duration(milliseconds: 150),
                        ),
                      ], repeatForever: true)
                    : AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            message.msg,
                            speed: const Duration(milliseconds: 90),
                          ),
                        ],
                        repeatForever: false,
                        totalRepeatCount: 2,
                      )

                // Text(
                //         message.msg,
                //         textAlign: TextAlign.start,
                //       ),
                )
          ])

        //user
        : Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            //
            Container(
                constraints: BoxConstraints(maxWidth: mq.width * .6),
                margin: EdgeInsets.only(
                    bottom: mq.height * .02, right: mq.width * .02),
                padding: EdgeInsets.symmetric(
                    vertical: mq.height * .01, horizontal: mq.width * .02),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: const BorderRadius.only(
                        topLeft: radius, topRight: radius, bottomLeft: radius)),
                child: Text(
                  message.msg,
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.white),
                )),

            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Theme.of(context).primaryColor),
            ),

            const SizedBox(width: 6),
          ]);
  }
}

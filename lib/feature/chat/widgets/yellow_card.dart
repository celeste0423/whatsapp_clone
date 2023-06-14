import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/extension/custom_theme_extension.dart';

class YellowCard extends StatelessWidget {
  const YellowCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 30,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: context.theme.yellowCardBgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        'Message and calls are end-to-end encrypted. No one outshide of this chat. not ee WhatsApp, can read or listen to the. Tap to learn more.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 13,
          color: context.theme.yellowCardTextColor,
        ),
      ),
    );
  }
}

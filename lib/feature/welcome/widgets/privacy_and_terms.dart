import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/extension/custom_theme_extension.dart';

class PrivacyAndTerms extends StatelessWidget {
  const PrivacyAndTerms({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Read our ',
          style: TextStyle(
            color: theme.greyColor,
            height: 1.5,
          ),
          children: [
            TextSpan(
              text: 'Privacy Policy ',
              style: TextStyle(
                color: theme.blueColor,
              ),
            ),
            const TextSpan(
              text: 'Tap "Agree and continue" to accept the ',
            ),
            TextSpan(
              text: 'Terms of Services.',
              style: TextStyle(
                color: theme.blueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

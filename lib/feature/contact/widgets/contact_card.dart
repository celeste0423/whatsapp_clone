import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_clone/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_clone/common/models/user_model.dart';
import 'package:whatsapp_clone/common/routes/routes.dart';
import 'package:whatsapp_clone/common/utils/coloors.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.contactSource,
  });

  final UserModel contactSource;

  shareSmsLink(phoneNumber) async {
    Uri sms = Uri.parse(
        "sms:${phoneNumber}?body=Let's chat on WhatsApp! it's a fast, simple, and secure app we can call each other for free. Get it at https://whatsappme.com/dl/");
    if (await launchUrl(sms)) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: contactSource.profileImageUrl.isNotEmpty
          ? () {
              Navigator.of(context).pushNamed(
                Routes.chat,
                arguments: contactSource,
              );
            }
          : () {},
      contentPadding: const EdgeInsets.only(left: 20, right: 10),
      dense: true,
      leading: CircleAvatar(
        backgroundColor: context.theme.greyColor!.withOpacity(0.3),
        radius: 20,
        backgroundImage: contactSource.profileImageUrl.isNotEmpty
            ? CachedNetworkImageProvider(contactSource.profileImageUrl)
            : null,
        child: contactSource.profileImageUrl.isEmpty
            ? const Icon(
                Icons.person,
                size: 30,
                color: Colors.white,
              )
            : const SizedBox(),
      ),
      title: Text(
        contactSource.username,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: contactSource.profileImageUrl.isEmpty
          ? null
          : Text(
              "Hey there! I'm using WhatsApp",
              style: TextStyle(
                color: context.theme.greyColor,
                fontWeight: FontWeight.w600,
              ),
            ),
      trailing: contactSource.profileImageUrl.isEmpty
          ? TextButton(
              onPressed: () {
                shareSmsLink(
                  contactSource.phoneNumber,
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Coloors.greenDark,
              ),
              child: const Text('INVITE'),
            )
          : null,
    );
  }
}

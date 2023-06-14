import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_clone/common/models/user_model.dart';
import 'package:whatsapp_clone/common/utils/coloors.dart';
import 'package:whatsapp_clone/common/widgets/custom_icon_button.dart';
import 'package:whatsapp_clone/feature/contact/controllers/contacts_controller.dart';
import 'package:whatsapp_clone/feature/contact/widgets/contact_card.dart';

class ContactPage extends ConsumerWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select contact',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 3),
            ref.watch(contactControllerProvider).when(data: (allContacts) {
              return Text(
                "${allContacts[0].length} Contact${allContacts[0].length <= 1 ? '' : 's'}",
                style: const TextStyle(fontSize: 12),
              );
            }, error: (e, t) {
              return const SizedBox();
            }, loading: () {
              return const Text(
                'counting',
                style: TextStyle(fontSize: 12),
              );
            }),
          ],
        ),
        actions: [
          CustomIconButton(onPressed: () {}, icon: Icons.search),
          CustomIconButton(onPressed: () {}, icon: Icons.more_vert),
        ],
      ),
      body: ref.watch(contactControllerProvider).when(
        data: (allContacts) {
          return ListView.builder(
            itemCount: allContacts[0].length + allContacts[1].length,
            itemBuilder: (context, index) {
              late UserModel firebaseContacts;
              late UserModel phoneContacts;

              if (index < allContacts[0].length) {
                //파이어베이스 연락처의 길이보다 작음
                firebaseContacts = allContacts[0][index];
              } else {
                phoneContacts = allContacts[1][index - allContacts[0].length];
              }

              return index < allContacts[0].length //index 계속 증가
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index == 0)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              myListTile(
                                leading: Icons.group,
                                text: 'New group',
                              ),
                              myListTile(
                                leading: Icons.contacts,
                                text: 'New contact',
                                trailing: Icons.qr_code,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Text(
                                  'Contacts on WhatsApp',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: context.theme.greyColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ContactCard(contactSource: firebaseContacts),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index == allContacts[0].length)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: Text(
                              'Contacts on Phone',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: context.theme.greyColor,
                              ),
                            ),
                          ),
                        ContactCard(contactSource: phoneContacts),
                      ],
                    );
            },
          );
        },
        error: (e, t) {
          return null;
        },
        loading: () {
          return const SizedBox();
        },
      ),
    );
  }

  ListTile myListTile({
    required IconData leading,
    required String text,
    IconData? trailing,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.only(top: 10, left: 20, right: 10),
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: Coloors.greenDark,
        child: Icon(
          leading,
          color: Colors.white,
        ),
      ),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        trailing,
        color: Coloors.greyDark,
      ),
    );
  }
}

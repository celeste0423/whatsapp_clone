import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/models/user_model.dart';

final contactsRepositoryProvider = Provider((ref) {
  return ContactsRepository(firestore: FirebaseFirestore.instance);
});

class ContactsRepository {
  final FirebaseFirestore firestore;

  ContactsRepository({required this.firestore});

  Future<List<List>> getAllContacts() async {
    List<UserModel> firebaseContacts = []; //전화번호 중 회원
    List<UserModel> phoneContacts = []; //전화번호 중 비회원

    try {
      if (await FlutterContacts.requestPermission()) {
        final userCollection = await firestore.collection('users').get();
        final allContactsInThePhone = await FlutterContacts.getContacts(
          withProperties: true,
        );

        bool isContactFound = false;

        for (var contact in allContactsInThePhone) {
          for (var firebaseContactData in userCollection.docs) {
            var firebaseContact = UserModel.fromMap(firebaseContactData.data());
            if (contact.phones[0].number.replaceAll('-', '').substring(1) ==
                firebaseContact.phoneNumber.substring(3)) {
              firebaseContacts.add(firebaseContact);
              isContactFound = true;
              break;
            }
          }
          if (!isContactFound) {
            phoneContacts.add(
              UserModel(
                username: contact.displayName,
                uid: '',
                profileImageUrl: '',
                active: false,
                lastSeen: 0,
                phoneNumber:
                    '+82${contact.phones[0].number.replaceAll('-', '').substring(1)}',
                groupId: [],
              ),
            );
          }
          isContactFound = false;
        }
      }
    } catch (e) {
      log(e.toString());
    }

    return [firebaseContacts, phoneContacts];
    //0번으로 firebaseContacts, 1번으로 phoneContacts 반환
  }
}

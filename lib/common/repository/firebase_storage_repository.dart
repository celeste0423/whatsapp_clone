import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseStorageRepositoryProvider = Provider(
  (ref) => FirebaseStorageRepository(firebaseStorage: FirebaseStorage.instance),
);

class FirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;

  FirebaseStorageRepository({required this.firebaseStorage});

  storeFileToFirebase(String ref, var file) async {
    UploadTask? uploadTask;
    if (file is File) {
      uploadTask = firebaseStorage.ref().child(ref).putFile(file);
      //ref 경로에 file을 업로드 함
    }
    if (file is Uint8List) {
      uploadTask = firebaseStorage.ref().child(ref).putData(file);
    }

    TaskSnapshot snapshot = await uploadTask!;
    //업로드 결과 확인
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
    //업로드 결과 사진 url을 리턴함
  }
}

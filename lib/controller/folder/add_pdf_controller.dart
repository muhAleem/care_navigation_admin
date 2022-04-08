import 'dart:convert';
import 'dart:typed_data';

import 'package:care_navigation_admin_panel/firebase/api_data.dart';
import 'package:care_navigation_admin_panel/widgets/custom_alerts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadPdfController extends GetxController {
  String pictureController3 = "";
  bool isLoading = true;
  FilePickerResult? uploadPhoto;
  int maxFileSize = 500 * 1024;
  int signatureFileSize = 100 * 1024;

  List titlelist = [];

  TextEditingController selecttilte = TextEditingController();
  TextEditingController pdftilte = TextEditingController();

  final picker = ImagePicker();
  PickedFile? pickedFile;
  XFile? xFile;
  String attachmentBase64Image = "";
  String attachmentFileName = "";
  String attachmentType = '';
  String retrieveDataError = "";
  String pictureController = "";
  String pdfUrl = "";

  String docId = '';

  dynamic pickImageError;

  @override
  void onReady() async {
    await getTitles();
    isLoading = false;
    update();
    super.onReady();
  }

  Future<void> getTitles() async {
    titlelist.clear();
    titlelist.add({'id': '0', 'name': 'Select Folder'});
    update();
    var data = await ApiData.folder.get();
    for (var e in data.docs) {
      titlelist.add(
        {'id': e.get('id'), 'name': e.get('name')},
      );
    }
    update();
  }

  void getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['pdf']);

    if (result != null) {
      // Uint8List uploadfile = result.files.single.bytes!;
      // File file = File(result.files.single.path!);
      await addData(result.files.first);
    } else {
      // User canceled the picker
    }
  }

  uploadImage() async {
    try {
      xFile = (await picker.pickImage(
        source: ImageSource.gallery,
      ))!;
    } catch (e) {
      pickImageError = e;
    }

    if (GetPlatform.isAndroid) await retrieveLostData();
    if (kDebugMode) {
      print("Check $xFile");
    }
    if (xFile!.path.isNotEmpty) {
      attachmentBase64Image = base64Encode(await xFile!.readAsBytes());
      attachmentFileName = xFile!.path.split("/").last;
      if (attachmentBase64Image != "") {
        pictureController = attachmentBase64Image;
        attachmentType = 'local';
        update();
      }
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      xFile = response.file!;
    } else {
      retrieveDataError = response.exception!.code;
    }
  }

  Future<void> addData(PlatformFile file) async {
    isLoading = true;
    update();
    try {
      var storage = FirebaseStorage.instance;
      var fileName = file.name;
      fileName = fileName;
      TaskSnapshot snapshot;
      snapshot = await storage.ref('/pdf').child(fileName).putData(file.bytes!);
      pdfUrl = await snapshot.ref.getDownloadURL();
      try {
        if (pdfUrl != "") {
          var data = ApiData.pdf.doc();
          var docSnap = await data.get();
          data.set({
            'id': docSnap.reference.id,
            'titleId': selecttilte.text,
            'imagePath': pdfUrl,
            'pdftitle': pdftilte.text,
            'createdAt': DateTime.now()
          }).then((value) {
            isLoading = false;
            update();
            CommonSnackbar.getSnackbar(
              'Success',
              'Pdf added successfully',
              Colors.green,
            );
          });
        }
      } catch (e) {
        isLoading = false;
        update();
      }
      // var data = ApiData.pdf.doc();
      // var docSnap = await data.get();
      // data.set({
      //   'id': docSnap.reference.id,
      //   'titleId': selecttilte.text,
      //   'imagePath': pictureController,
      //   'createdAt': DateTime.now()
      // }).then((value) {
      //   isLoading = false;
      //   update();
      //   CommonSnackbar.getSnackbar(
      //     'Success',
      //     'Signal added successfully',
      //     Colors.green,
      //   );
      // });
    } on FirebaseException catch (e) {
      isLoading = false;
      update();
      CommonSnackbar.getSnackbar('Error', e.message.toString(), Colors.red);
    }
  }
}

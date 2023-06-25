import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  final supabaseClient = Supabase.instance.client;
  final bucketName = "insta-clone-bucket";

  Future<String> uploadImage(File? imageFile, String folder, String fileName) async {
    try {
      await supabaseClient.storage
          .from(bucketName)
          .upload('$folder/$fileName', imageFile!);
      final url = await getImageUrl(fileName);
      return url;
    } catch (e) {
      print("Upload image failed: $e");
      return "Failed uploading image.";
    }
  }

  Future<String> getImageUrl(String fileName) async {
    final String file = supabaseClient.storage.from('$bucketName/users').getPublicUrl(fileName);
    return file;
  }
}

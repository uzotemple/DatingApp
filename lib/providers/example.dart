import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ImageUploadScreennn extends StatefulWidget {
  const ImageUploadScreennn({super.key});

  @override
  _ImageUploadScreennnState createState() => _ImageUploadScreennnState();
}

class _ImageUploadScreennnState extends State<ImageUploadScreennn> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) {
      print('No image selected');
      return;
    }

    final url = Uri.parse("http://localhost:7001/profile/add-image");
    final request = http.MultipartRequest('POST', url);

    // Add Authorization Token
    request.headers['Authorization'] =
        'Bearer eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIyMzEwYjg3NS03ZjRmLTQ5MTYtODA1Mi1kMTBjNDk5Y2U1ZTgiLCJlbnZpcm9ubWVudCI6ImRldiIsImF1dGhvcml0eSI6WyJST0xFX1VTRVIiXSwiaXNzIjoiaHR0cDpcL1wvbG9jYWxob3N0OjMwMDAiLCJleHAiOjE3MzcxMDcwMjIsInR5cGUiOiJub3JtYWwiLCJpYXQiOjE3MzcxMDY5NjIsImVtYWlsIjoidGVtcGxlM0BnbWFpbC5jb20iLCJyZW1vdGVBZGRyZXNzIjoiMTAyLjg5LjQ3LjExNyIsInVzZXJuYW1lIjoidGVtcGxlM0BnbWFpbC5jb20ifQ.LY4uk8n487xaymPh4moNvu522_Sc-fhqWxjhiQC13uH2tDSh7NOAFpMfq04IQiBICnKUiIy5esECcJABCrLaKDhmlMKNhmU5zgJmhycA3yB0Q3OEyU4Pj_m0qRNbP32X_NwxfCs0GP_DYg6uEmB8zQL9JP5KelGCAoef6o6Hnauosjw1KAtsKVM8Yk724hsuuXRmi_DRP4ckerkJWgS1X4rxoRzRwa5lPZP__fMs4rUffSPCC61NndO7Zgwc8XObenfe-GULZvEF2y7DBEjsmKRBMnA-BE9TDl50ct0EQA38GGts7Sgu4n8wbI2yyUuL8TG_cIYfogvWHRlE27Nj8-kPLHITV3qc8VeW7v-GyYjMJQMo5A3GbswpernpclM2lclKkDTpV7OJYFTEvkF1vmXB4G4EYjF94pLu9LKtLDZcPUTw0ZIifWMDfq5f-LAJt1QV4bhhvG08LyCJ4G4zd6dIG_Lv75SC8zubN3ByWnbQ55dvMW2ZoofdFTTcICuKIF2HlmEk_ndx_sQI8PQf3LIqRkSVJCEe5hgGFCqNHEGm_IfF0rP4h9w9wfNOH9Y0JL7doXgHz5Pzh9S9tKfzPGZObNEUirMB2cwuWQfV_N-tMWpn__T90YG9c6D-G_tbVG5_XmJQH-MLxv98YrHwMYewi6OiaA3Y77djk8oCyIA';

    // Attach Image File
    request.files.add(await http.MultipartFile.fromPath(
      'image', // Backend field name
      _image!.path,
    ));

    final response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print('Failed to upload image: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Image")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? Image.file(_image!, height: 200)
                : const Text("No image selected"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text("Pick Image"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _uploadImage,
              child: const Text("Upload Image"),
            ),
          ],
        ),
      ),
    );
  }
}

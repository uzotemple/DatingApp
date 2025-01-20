import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:love_bird/config/constants.dart';
import 'package:love_bird/config/routes.dart';

import 'package:love_bird/providers/auth_provider.dart';
import 'package:love_bird/providers/image_service.dart';
import 'package:love_bird/providers/image_provider.dart';

import 'package:provider/provider.dart';

class UploadPicturesScreen extends StatefulWidget {
  const UploadPicturesScreen({super.key});

  @override
  _UploadPicturesScreenState createState() => _UploadPicturesScreenState();
}

class _UploadPicturesScreenState extends State<UploadPicturesScreen> {
  final ImagePicker _picker = ImagePicker();
  //final ImageUploadService _uploadService = ImageUploadService();
  Future<void> _pickImage(int index, ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      Provider.of<ImageProviderModel>(context, listen: false)
          .addImage(index, File(pickedFile.path));
    }
  }

  void _uploadImages() async {
    final imageProvider =
        Provider.of<ImageProviderModel>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final apiService = ApiService();
    await apiService.uploadImages(context, imageProvider.images, authProvider);
  }

  void _showImageSourceActionSheet(int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: Theme.of(context).iconTheme.color,
                ),
                title: Text(
                  'Pick from gallery',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(index, ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.camera_alt,
                  color: Theme.of(context).iconTheme.color,
                ),
                title: Text(
                  'Take a photo',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(index, ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImageProviderModel>(context);

    final images = imageProvider.images;
    final uploadedImageCount = imageProvider.uploadedImageCount;
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
                MediaQuery.of(context).size.width * 0.05, // 5% of screen width
            vertical: MediaQuery.of(context).size.height *
                0.03, // 5% of screen height
          ),
          child: Column(
            children: [
              SizedBox(
                width: screenSize.width,
                height: screenSize.height * 0.02,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        color: blue.withOpacity(0.19),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        width: screenSize.width * 0.7,
                        color: blue,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenSize.width * 0.046,
              ),
              Row(
                children: [
                  const Text(
                    'Show Your Best Self',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 5),
                  Image.asset('assets/images/six.png', width: 40),
                ],
              ),
              const Text(
                'Upload at least 6 of your best pictures to make a great first impression.',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              // Image grid
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _showImageSourceActionSheet(index),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: images[index] == null
                                ? const Center(
                                    child: Icon(Icons.add,
                                        size: 24, color: Colors.grey))
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      images[index]!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                          ),
                          if (images[index] != null)
                            Positioned(
                              top: -8,
                              right: -8,
                              child: GestureDetector(
                                onTap: () => imageProvider.removeImage(index),
                                child: Container(
                                  color: Colors.red,
                                  padding: const EdgeInsets.all(2),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              // Continue button
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        uploadedImageCount >= 1 ? blue : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: uploadedImageCount >= 1
                      ? () {
                          Navigator.pushNamed(context, photoVerificationOne);
                          // _uploadImages(); // Add the function call
                        }
                      : null,

                  //  onPressed: _uploadImages,

                  child: Text(
                    "Continue ($uploadedImageCount/9)",
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

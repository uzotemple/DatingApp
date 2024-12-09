// image_provider.dart
import 'dart:io';
import 'package:flutter/foundation.dart';

class ImageProviderModel extends ChangeNotifier {
  final List<File?> _images = List.filled(9, null);

  List<File?> get images => _images;

  void addImage(int index, File image) {
    _images[index] = image;
    notifyListeners();
  }

  void removeImage(int index) {
    _images[index] = null;
    notifyListeners();
  }

  int get uploadedImageCount => _images.where((image) => image != null).length;
}

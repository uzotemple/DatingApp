import 'dart:io';
import 'package:flutter/material.dart';

class ImageGrid extends StatelessWidget {
  final List<File?> images;
  final Function(int index) onDelete;
  final Function(int index) onSetAsProfile;

  const ImageGrid({
    super.key,
    required this.images,
    required this.onDelete,
    required this.onSetAsProfile,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: images[index] != null
                    ? DecorationImage(
                        image: FileImage(images[index]!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: PopupMenuButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 1,
                    child: Text('Set as Profile Picture'),
                  ),
                  const PopupMenuItem(
                    value: 2,
                    child: ListTile(
                      leading: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      title: Text('Delete'),
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == 1) {
                    onSetAsProfile(index);
                  } else if (value == 2) {
                    onDelete(index);
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

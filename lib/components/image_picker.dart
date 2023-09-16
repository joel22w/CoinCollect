import 'dart:io';

import 'package:coincollect/constants/colors.dart';
import 'package:coincollect/provider/category_provider.dart';
import 'package:coincollect/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _image;
  final picker = ImagePicker();
  bool isUploading = false;

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No Image Selected');
      }
    });
  }

  @override
Widget build(BuildContext context) {
    var _provider = Provider.of<CategoryProvider>(context);
    double containerHeight;

    if (_image != null) {
      containerHeight = isUploading ? 150.0 : 420.0;
    } else if (_provider.imageUploadedUrls.isNotEmpty) {
      containerHeight = 150.0;
    } else {
      containerHeight = 420.0;
    }
    return  SingleChildScrollView(
      child: Container(
      height: containerHeight,
     
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          (_image != null)
              ? SizedBox(
                  height: isUploading ? 100 : 300,
                  child: isUploading
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: secondaryColour,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                                'Uploading your image to the database ...')
                          ],
                        )
                      : Image.file(_image!),
                )
              : (_provider.imageUploadedUrls.isNotEmpty)
                  ? Expanded(
                      child: GalleryImage(
                          titleGallery: 'Uploaded Images',
                          numOfShowImages: _provider.imageUploadedUrls.length,
                          imageUrls: _provider.imageUploadedUrls),
                    )
                  : Icon(
                      CupertinoIcons.photo_on_rectangle,
                      size: 200,
                      color: disabledColour,
                    ),
          const SizedBox(
            height: 20,
          ),
          (_image == null)
              ? Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: getImage,
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 20)),
                                backgroundColor:
                                    MaterialStateProperty.all(secondaryColour)),
                            child: const Text('Select Image')),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                )
              : (isUploading)
                  ? const SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isUploading = true;
                                  uploadFile(context, _image!.path).then((url) {
                                    if (url != null) {
                                      _provider.setImageList(url);
                                      setState(() {
                                        isUploading = false;
                                        _image = null;
                                      });
                                    }
                                  });
                                });
                              },
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 20)),
                                  backgroundColor:
                                      MaterialStateProperty.all(blackColour)),
                              child: const Text('Upload Image')),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _image = null;
                                  });
                                },
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 20)),
                                    backgroundColor:
                                        MaterialStateProperty.all(blackColour)),
                                child: const Text('Cancel')))
                      ],
                    ),
        ],
      ),
    ),
    );
  }
}

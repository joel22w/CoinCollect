// ignore_for_file: void_checks

import 'package:coincollect/components/bottom_bar.dart';
import 'package:coincollect/components/image_picker.dart';
import 'package:coincollect/constants/colors.dart';
import 'package:coincollect/constants/validator.dart';
import 'package:coincollect/constants/widgets.dart';
import 'package:coincollect/forms/listing_product.dart';
import 'package:coincollect/provider/category_provider.dart';
import 'package:coincollect/services/user_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:provider/provider.dart';

class CommonForm extends StatefulWidget {
  static const String screenId = 'common_form';
  const CommonForm({Key? key}) : super(key: key);

  @override
  State<CommonForm> createState() => _CommonFormState();
}

class _CommonFormState extends State<CommonForm> {
  UserService firebaseUser = UserService();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _descriptionController;
  late FocusNode _descriptionNode;
  late TextEditingController _titleController;
  late FocusNode _titleNode;
  late TextEditingController _priceController;
  late FocusNode _priceNode;
  late TextEditingController _typeController;
  late FocusNode _typeNde;




  

  @override
  void initState() {
    _descriptionController = TextEditingController();
    _descriptionNode = FocusNode();
    _titleController = TextEditingController();
    _titleNode = FocusNode();
    _priceController = TextEditingController();
    _priceNode = FocusNode();
    _typeController = TextEditingController();
    _typeNde = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
 
    _descriptionController.dispose();
    _descriptionNode.dispose();
    _titleController.dispose();
    _titleNode.dispose();
    _priceController.dispose();
    _priceNode.dispose();
    _typeController.dispose();
    _typeNde.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var categoryProvider = Provider.of<CategoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: blackColour),
          backgroundColor: whiteColour,
          title: Text(
            '${categoryProvider.selectedCategory} Details',
            style: TextStyle(color: blackColour),
          )),
      body: formBodyWidget(context, categoryProvider),
      bottomNavigationBar: BottomNavigationWidget(
        buttonText: 'Next',
        validator: true,
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            categoryProvider.formData.addAll({
              'seller_uid': firebaseUser.user!.uid,
              'category': categoryProvider.selectedCategory,
              'subcategory': categoryProvider.selectedSubCategory,
              
              'title': _titleController.text,
              'description': _descriptionController.text,
              'price': _priceController.text,
              'images': categoryProvider.imageUploadedUrls.isEmpty
                  ? ''
                  : categoryProvider.imageUploadedUrls,
              'posted_at': DateTime.now().microsecondsSinceEpoch,
              'favourites': [],
            });
            if (categoryProvider.imageUploadedUrls.isNotEmpty) {
              Navigator.pushNamed(context, UserFormReview.screenId);
            } else {
              vibrantSnackBar(
                  context: context,
                  content: 'Please upload images to the database');
            }
            print(categoryProvider.formData);
          }
        },
      ),
    );
  }

 

  formBodyWidget(BuildContext context, CategoryProvider categoryProvider) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding:
                const EdgeInsets.only(left: 18, top: 10, right: 10, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${categoryProvider.selectedSubCategory}',
                  style: TextStyle(
                    color: blackColour,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: _titleController,
                    focusNode: _titleNode,
                    maxLength: 50,
                    validator: (value) {
                      return checkNullEmptyValidation(value, 'title');
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Title*',
                      counterText:
                          'What is it?',
                      labelStyle: TextStyle(
                        color: greyColour,
                        fontSize: 14,
                      ),
                      errorStyle:
                          const TextStyle(color: Colors.red, fontSize: 12),
                      contentPadding: const EdgeInsets.all(15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: disabledColour)),
                    )),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: _descriptionController,
                    focusNode: _descriptionNode,
                    maxLength: 50,
                    validator: (value) {
                      return checkNullEmptyValidation(
                          value, 'product description');
                    },
                    maxLines: 3,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Description*',
                      counterText: '',
                      labelStyle: TextStyle(
                        color: greyColour,
                        fontSize: 14,
                      ),
                      errorStyle:
                          const TextStyle(color: Colors.red, fontSize: 12),
                      contentPadding: const EdgeInsets.all(15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: disabledColour)),
                    )),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: _priceController,
                    focusNode: _priceNode,
                    validator: (value) {
                      return validatePrice(value);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefix: const Text('RM '),
                      labelText: 'Price*',
                      labelStyle: TextStyle(
                        color: greyColour,
                        fontSize: 14,
                      ),
                      errorStyle:
                          const TextStyle(color: Colors.red, fontSize: 12),
                      contentPadding: const EdgeInsets.all(15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: disabledColour)),
                    )),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    if (kDebugMode) {
                      print(categoryProvider.imageUploadedUrls.length);
                    }
                    return stylishBottomSheet(
                        context: context, child: const ImagePickerWidget());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Colors.grey[300],
                    ),
                    child: Text(
                      categoryProvider.imageUploadedUrls.isNotEmpty
                          ? 'Upload More Images'
                          : 'Upload Image',
                      style: TextStyle(
                          color: blackColour, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                categoryProvider.imageUploadedUrls.isNotEmpty
                    ? GalleryImage(
                        titleGallery: 'Uploaded Images',
                        numOfShowImages:
                            categoryProvider.imageUploadedUrls.length,
                        imageUrls: categoryProvider.imageUploadedUrls)
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

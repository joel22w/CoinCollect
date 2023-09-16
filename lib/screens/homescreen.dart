

import 'package:coincollect/screens/category/category_display_row.dart';
import 'package:coincollect/components/topbar_search.dart';
import 'package:coincollect/components/product_listing.dart';
import 'package:coincollect/constants/colors.dart';
import 'package:coincollect/constants/widgets.dart';
import 'package:coincollect/provider/category_provider.dart';
import 'package:coincollect/screens/geolocation_screen.dart';
import 'package:coincollect/utils.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String screenId = 'home_screen';
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchController;
  
  int _current = 0;
  late FocusNode searchNode;

  Future<List<String>> downloadBannerImageUrlList() async {
    List<String> bannerUrlList = [];
    final ListResult storageRef =
        await FirebaseStorage.instance.ref().child('banner').listAll();
    List<Reference> bannerRef = storageRef.items;
    await Future.forEach<Reference>(bannerRef, (image) async {
      final String fileUrl = await image.getDownloadURL();
      bannerUrlList.add(fileUrl);
    });
    return bannerUrlList;
  }

  @override
  void initState() {
    searchController = TextEditingController();
    searchNode = FocusNode();
    
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    searchNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var categoryProvider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: MainAppBarWithSearch(
            controller: searchController, focusNode: searchNode),
      ),
      body: homeBodyWidget(),
    );
  }

  lcoationAutoFetchBar(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    User? user = FirebaseAuth.instance.currentUser;
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(user!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return vibrantSnackBar(
              context: context, content: "Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return vibrantSnackBar(
              context: context, content: "Addrress not selected");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          if (data['address'] == null) {
            Position? position = data['location'];
            getFetchedAddress(context, position).then((location) {
              return locationTextWidget(
                location: location,
              );
            });
          } else {
            return locationTextWidget(location: data['address']);
          }
          return locationTextWidget(location: 'Update Location');
        }
        return locationTextWidget(location: 'Fetching location');
      },
    );
  }

  Widget homeBodyWidget() {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CategoryWidget(),
            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              height: 40,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(LocationScreen.screenId);
                },
                child: Center(child: lcoationAutoFetchBar(context)),
              ),
            ),
           
            ProductListing()
          ],
        ),
      ),
    );
  }
}

class locationTextWidget extends StatelessWidget {
  final String? location;
  const locationTextWidget({Key? key, required this.location})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.pin_drop,
          size: 18,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          location ?? '',
          style: TextStyle(
            color: blackColour,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

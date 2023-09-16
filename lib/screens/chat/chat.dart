import 'dart:developer';

import 'package:coincollect/constants/colors.dart';
import 'package:coincollect/screens/category/category_list.dart';
import 'package:coincollect/screens/chat/chat_card.dart';
import 'package:coincollect/screens/navigation_screen.dart';
import 'package:coincollect/services/auth_service.dart';
import 'package:coincollect/services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const screenId = 'chat_screen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

_bottomBar() {
  return TabBar(
      labelStyle: TextStyle(
        color: blackColour,
        fontWeight: FontWeight.bold,
        fontFamily: 'Oswald',
      ),
      labelColor: blackColour,
      indicatorColor: secondaryColour,
      tabs: const [
        Tab(
          text: 'All',
        ),
        Tab(
          text: 'Selling',
        )
      ]);
}

_body({required Auth authService, required UserService firebaseUser}) {
  return TabBarView(
    children: [
      Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: authService.messages
                .where('users', arrayContains: firebaseUser.user!.uid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Error loading chats..'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: secondaryColour),
                );
              }
              if (snapshot.data!.docs.length == 0) {
                return Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Ahhh! Start Selling/Buying...'),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(blackColour)),
                        onPressed: () => Navigator.of(context)
                            .pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (c) =>
                                        const MainNavigationScreen()),
                                (route) => false),
                        child: const Text('Recommended Products'))
                  ],
                ));
              }
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  return ChatCard(data: data);
                }).toList(),
              );
            }),
      ),
      
      Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: authService.messages
                .where('users', arrayContains: firebaseUser.user!.uid)
                .where('product.seller', isEqualTo: firebaseUser.user!.uid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Error loading chats..'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: secondaryColour),
                );
              }
              if (snapshot.data!.docs.length == 0) {
                return Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('No chats yet ? Start Now !'),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(blackColour)),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => const CategoryListScreen(
                                      isForForm: true,
                                    ))),
                        child: const Text('Add Products'))
                  ],
                ));
              }
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  return ChatCard(data: data);
                }).toList(),
              );
            }),
      ),
    ],
  );
}

class _ChatScreenState extends State<ChatScreen> {
  Auth authService = Auth();
  UserService firebaseUser = UserService();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
              elevation: 0,
              backgroundColor: whiteColour,
              title: Text(
                'Chats',
                style: TextStyle(
                  color: blackColour,
                ),
              ),
              bottom: _bottomBar()),
          body: _body(
            authService: authService,
            firebaseUser: firebaseUser,
          )),
    );
  }
}

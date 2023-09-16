import 'package:coincollect/constants/colors.dart';
import 'package:coincollect/screens/category/category_list.dart';
import 'package:coincollect/screens/chat/chat.dart';
import 'package:coincollect/screens/homescreen.dart';
import 'package:coincollect/screens/post/my_post_screen.dart';
import 'package:coincollect/screens/user_profile_screen.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainNavigationScreen extends StatefulWidget {
  static const screenId = 'main_nav_screen';
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  List pages = [
    const HomeScreen(),
    const ChatScreen(),
    const CategoryListScreen(isForForm: true),
    const MyPostScreen(),
    const ProfileScreen(),
  ];
  PageController controller = PageController();
  int _index = 0;

  _bottomNavigationBar() {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: DotNavigationBar(
        backgroundColor: blackColour,
        margin: EdgeInsets.zero,
        paddingR: EdgeInsets.zero,
        selectedItemColor: secondaryColour,
        currentIndex: _index,
        dotIndicatorColor: Colors.transparent,
        unselectedItemColor: disabledColour,
        enablePaddingAnimation: true,
        enableFloatingNavBar: false,
        onTap: (index) {
          setState(() {
            _index = index;
          });
          controller.jumpToPage(index);
        },
        items: [
          DotNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                  color: _index == 0 ? whiteColour : Colors.transparent,
                  borderRadius: BorderRadius.circular(40)),
              padding: const EdgeInsets.all(10),
              child: Icon(
                Icons.home,
                color: _index == 0 ? secondaryColour : disabledColour,
              ),
            ),
          ),
          DotNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                  color: _index == 1 ? whiteColour : Colors.transparent,
                  borderRadius: BorderRadius.circular(40)),
              padding: const EdgeInsets.all(10),
              child: Icon(
                Icons.chat,
                color: _index == 1 ? secondaryColour : disabledColour,
              ),
            ),
          ),
          DotNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                  color: _index == 2 ? whiteColour : Colors.transparent,
                  borderRadius: BorderRadius.circular(40)),
              padding: const EdgeInsets.all(10),
              child: Icon(
                Icons.add,
                color: _index == 2 ? secondaryColour : disabledColour,
              ),
            ),
          ),
          DotNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                  color: _index == 3 ? whiteColour : Colors.transparent,
                  borderRadius: BorderRadius.circular(40)),
              padding: const EdgeInsets.all(10),
              child: Icon(
                _index == 3 ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                color: _index == 3 ? secondaryColour : disabledColour,
              ),
            ),
          ),
          DotNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                  color: _index == 4 ? whiteColour : Colors.transparent,
                  borderRadius: BorderRadius.circular(40)),
              padding: const EdgeInsets.all(10),
              child: Icon(
                Icons.person,
                color: _index == 4 ? secondaryColour : disabledColour,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: PageView.builder(
            itemCount: pages.length,
            controller: controller,
            onPageChanged: (page) {
              setState(() {
                _index = page;
              });
            },
            itemBuilder: (context, position) {
              return pages[position];
            }),
        bottomNavigationBar: _bottomNavigationBar());
  }
}

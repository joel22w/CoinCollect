import 'package:flutter/material.dart';
import 'package:coincollect/constants/colors.dart';
import 'package:coincollect/models/popup_model.dart';
import 'package:coincollect/services/user_service.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';

// Create a colorful loading dialog with a message.
 colorfulLoadingDialog(BuildContext context, String loadingMessage) {
  AlertDialog colorfulAlert = AlertDialog(
    content: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircularProgressIndicator(
          color: secondaryColour,
        ),
        const SizedBox(
          width: 30,
        ),
        Text(
          loadingMessage,
          style: TextStyle(
            color: blackColour,
          ),
        ),
      ],
    ),
  );

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return colorfulAlert;
    },
  );
}

// Display a vibrant custom snackbar.
 vibrantSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: blackColour,
      content: Text(
        content,
        style: TextStyle(color: whiteColour, letterSpacing: 0.5),
      ),
    ),
  );
}

// Craft an elegant rounded button widget.
Widget elegantRoundedButton({
  context,
  required Color? buttonColour,
  required Function()? onPressed,
  Color? textColor,
  double? buttonWidth,
  double? buttonPadding,
  required String? buttonText,
  Color? borderColor,
}) {
  return SizedBox(
    width: buttonWidth ?? double.infinity,
    child: ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(
              color: borderColor ?? secondaryColour,
            ),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(buttonColour),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: buttonPadding ?? 15),
        child: Text(
          buttonText!,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
      ),
    ),
  );
}

// Present an elegant alert dialog with a message.
elegantAlertDialog(String message, BuildContext context) {
  AlertDialog elegantAlert = AlertDialog(
    content: Text(
      message,
      style: TextStyle(
        color: blackColour,
      ),
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(
          'Ok',
        ),
      ),
    ],
  );

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return elegantAlert;
    },
  );
}

// Unveil a stylish bottom sheet with optional title and custom height.
stylishBottomSheet({
  required BuildContext context,
  required Widget child,
  String? appBarTitle,
  double? sheetHeight,
}) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    enableDrag: false,
    isDismissible: false,
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                      primary: Colors.white,
                    ),
                    child: Icon(Icons.close, color: blackColour),
                  ),
                ),
              ],
            ),
            if (appBarTitle != null)
              Container(
                color: Colors.transparent,
                child: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: secondaryColour,
                  title: Text(
                    appBarTitle,
                    style: TextStyle(color: whiteColour, fontSize: 18),
                  ),
                ),
              )
            else
              const SizedBox(),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: sheetHeight ?? MediaQuery.of(context).size.height / 2,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: whiteColour,
                    ),
                    child: child,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

// Fashion a sleek custom popup menu with specified menu items.
Widget sleekPopupMenu({
  required BuildContext context,
  required String? chatroomId,
}) {
  CustomPopupMenuController controller = CustomPopupMenuController();
  UserService firebaseUser = UserService();
  List<PopUpMenuModel> menuItems = [
    PopUpMenuModel('Delete', Icons.delete),
    PopUpMenuModel('Mark Sold', Icons.done),
  ];
  return CustomPopupMenu(
    menuBuilder: () => ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        color: whiteColour,
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: menuItems
                .map(
                  (item) => GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      if (menuItems.indexOf(item) == 0) {
                        firebaseUser.deleteChat(chatroomId: chatroomId);
                        vibrantSnackBar(
                            context: context,
                            content: 'Chat successfully deleted..');
                      } else {
                        print('Mark Sold');
                      }
                      controller.hideMenu();
                    },
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            item.icon,
                            size: 15,
                            color: blackColour,
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                item.title,
                                style: TextStyle(
                                  color: blackColour,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    ),
    pressType: PressType.singleClick,
    verticalMargin: -12,
    controller: controller,
    child: Container(
      padding: const EdgeInsets.all(20),
      child: Icon(Icons.more_vert_sharp, color: blackColour),
    ),
  );
}

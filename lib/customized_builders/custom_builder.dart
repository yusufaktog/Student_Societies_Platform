import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grad_project/model/community.dart';
import 'package:grad_project/model/event.dart';
import 'package:grad_project/pages/authorized_user.dart';
import 'package:grad_project/pages/communities.dart';
import 'package:grad_project/pages/events.dart';
import 'package:grad_project/pages/main_page.dart';
import 'package:grad_project/pages/setting_page.dart';
import 'package:grad_project/service/auth.dart';

import '../constants.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {Key? key,
      required this.backGroundColor,
      required this.verticalMargin,
      required this.horizontalMargin,
      required this.allPadding,
      required this.child,
      required this.borderRadius})
      : super(key: key);

  final Color backGroundColor;
  final double verticalMargin;
  final double horizontalMargin;
  final double allPadding;
  final Widget child;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backGroundColor,
      margin: EdgeInsets.symmetric(vertical: verticalMargin, horizontal: horizontalMargin),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
      child: Padding(padding: EdgeInsets.all(allPadding), child: child),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.hintText,
      required this.fontSize,
      required this.textColor,
      this.controller,
      this.prefixIcon,
      this.suffixIcon,
      this.onChanged,
      this.isObscureText})
      : super(key: key);

  final String hintText;
  final double fontSize;
  final Color textColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function? onChanged;
  final TextEditingController? controller;
  final bool? isObscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      obscureText: isObscureText ?? false,
      onChanged: (value) {
        onChanged!(value);
      },
      cursorColor: Colors.black,
      keyboardType: TextInputType.text,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: textColor, fontSize: fontSize, fontWeight: FontWeight.normal),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final TextStyle? textStyle;

  const CustomTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}

class CustomAppBarElement extends StatelessWidget {
  final State state;
  final String routeName;
  final bool isUnderlined;
  final String text;
  final double fontSize;

  const CustomAppBarElement({
    Key? key,
    required this.state,
    required this.routeName,
    required this.isUnderlined,
    required this.text,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      backGroundColor: mainBackGroundColor,
      borderRadius: 0.0,
      verticalMargin: 0,
      horizontalMargin: 0,
      allPadding: 9.0,
      child: CustomTextButton(
        onPressed: () {
          state.setState(() {
            Navigator.pushNamed(context, routeName);
          });
        },
        text: text,
        textStyle: TextStyle(
          color: Colors.transparent,
          shadows: [Shadow(color: isUnderlined == true ? Colors.orange : Colors.white54, offset: const Offset(0, -5))],
          decorationThickness: 1.5,
          decorationColor: Colors.orange,
          decoration: isUnderlined == true ? TextDecoration.underline : TextDecoration.none,
          fontSize: fontSize,
        ),
      ),
    );
  }
}

class CommunityCard extends StatefulWidget {
  final Community community;

  const CommunityCard({
    Key? key,
    required this.community,
  }) : super(key: key);

  @override
  State<CommunityCard> createState() => _CommunityCardState();
}

class _CommunityCardState extends State<CommunityCard> {
  @override
  Card build(BuildContext context) {
    return Card(
      color: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: widget.community.imageUrl!.isEmpty ? Image.asset("assets/no_image.png") : Image.network(widget.community.imageUrl!),
            ),
            Expanded(
              flex: 5,
              child: Column(
                children: <Widget>[
                  Text(widget.community.communityName,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      widget.community.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatefulWidget {
  final CommunityEvent event;

  const EventCard({Key? key, required this.event}) : super(key: key);

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Card build(BuildContext context) {
    return Card(
      color: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Image.network(widget.event.imageUrl!),
            ),
            Expanded(
              flex: 5,
              child: Column(
                children: <Widget>[
                  Text(widget.event.name ?? "default",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                    child: Text(
                      widget.event.description ?? "default",
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

PreferredSize buildPreferredSize(BuildContext context, State state, bool homeUnderLined, bool communityUnderLined, bool activityUnderLined) {
  var flexFactor = 3;
  var fontSize = 15.0;
  final AuthService _authService = AuthService();

  return PreferredSize(
    preferredSize: preferredAppBarHeight,
    child: Row(
      children: <Widget>[
        Expanded(
          flex: flexFactor,
          child: CustomAppBarElement(
            state: state,
            routeName: AuthorizedUserPage.routeName,
            isUnderlined: homeUnderLined,
            text: "HOME PAGE",
            fontSize: fontSize - 1,
          ),
        ),
        Expanded(
          flex: flexFactor,
          child: CustomAppBarElement(
              state: state,
              routeName: AuthorizedCommunityPage.routeName,
              isUnderlined: communityUnderLined,
              text: "COMMUNITIES",
              fontSize: fontSize - 3),
        ),
        Expanded(
          flex: flexFactor,
          child: CustomAppBarElement(
              state: state, routeName: EventsPage.routeName, isUnderlined: activityUnderLined, text: "EVENTS", fontSize: fontSize),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            iconSize: 30,
            color: Colors.red,
            icon: logoutIcon,
            onPressed: () {
              _authService.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginPage(),
                  ),
                  (route) => false);
            },
          ),
        )
      ],
    ),
  );
}

buildDrawer(context) {
  return Drawer(
    child: Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        color: Colors.grey,
        child: ListView(
          primary: true,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: mainBackGroundColor,
              ),
              currentAccountPicture: const CircleAvatar(
                child: Icon(
                  Icons.account_circle,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
              accountName: const Text(
                "Yusuf Aktoğ",
                style: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
              ),
              accountEmail: Text(
                FirebaseAuth.instance.currentUser!.email ?? "default",
                style: const TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              color: mainBackGroundColor,
              child: ListTile(
                trailing: logoutIcon,
                title: const Text('Log Out', style: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold)),
                tileColor: Colors.red,
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginPage(),
                      ),
                      (route) => false);
                },
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              alignment: Alignment.centerRight,
              color: mainBackGroundColor,
              child: ListTile(
                trailing: const Icon(Icons.account_circle, color: Colors.blue, size: 30),
                title: const Text(
                  'Account Settings',
                  style: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                tileColor: Colors.red,
                onTap: () async {
                  var type = await FirebaseFirestore.instance.collection("Communities").doc(FirebaseAuth.instance.currentUser!.uid).get();
                  bool exists = type.exists;
                  if (!exists) {
                    Fluttertoast.showToast(msg: "This page is not available for student accounts for now...");
                    return;
                  }
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const CommunityAccountSettings() //change it later
                        ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

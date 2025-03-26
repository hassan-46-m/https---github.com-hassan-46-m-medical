import 'package:flutter/material.dart';
import 'package:intelligent_medical_system/ui/Drug_Details/drug_details.dart';
import 'package:intelligent_medical_system/ui/Account/account.dart';
import 'package:intelligent_medical_system/ui/liked/liked_details.dart';
import 'package:intelligent_medical_system/ui/search/searchDetails.dart';
import 'package:intelligent_medical_system/ui/Register/login_screen.dart';
import 'package:intelligent_medical_system/ui/Register/signup_screen.dart';
import 'package:intelligent_medical_system/ui/colors/app_colors.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "Home Screen";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  int selectedIndex = 0;
  List<Widget> pgDetails = [
    AllDrugsScreen(),
    Searchdetails(),
    LikedDetails(),
    AccountScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        primary: true,
        bottomNavigationBar: SizedBox(
          height: 75,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10)),
            child: BottomNavigationBar(
                showUnselectedLabels: false,
                showSelectedLabels: true,
                currentIndex: selectedIndex,
                onTap: (index) {
                  selectedIndex = index;
                  setState(() {});
                },
                unselectedItemColor: AppColor.whiteColor,
                selectedIconTheme:
                    IconThemeData(size: 40, color: AppColor.secondColor),
                selectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.bold, color: AppColor.whiteColor),
                type: BottomNavigationBarType.fixed,
                backgroundColor: AppColor.primaryColor,
                items: [
                  BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage("assets/icons/homeIcon.png")),
                      label: "Home"),
                  BottomNavigationBarItem(
                      icon:
                          ImageIcon(AssetImage("assets/icons/searchIcon.png")),
                      label: "Search"),
                  BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage("assets/icons/heartIcon.png")),
                      label: "Liked"),
                  BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage("assets/icons/userIcon.png")),
                      label: "Account"),
                ]),
          ),
        ),
        key: scaffoldKey,
        appBar: AppBar(
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10))),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Intelligent",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                    color: AppColor.secondColor),
              ),
              Text(
                "medical system",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                    color: AppColor.whiteColor),
              ),
            ],
          ),
          toolbarHeight: 120,
          backgroundColor: AppColor.primaryColor,
          actions: [
            InkWell(
              onTap: () {
                scaffoldKey.currentState!.openEndDrawer();
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ImageIcon(
                    color: AppColor.whiteColor,
                    AssetImage("assets/icons/drawer.png")),
              ),
            )
          ],
        ),
        endDrawer: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 122),
            child: Drawer(
              shape: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(0))),
              shadowColor: Colors.transparent,
              width: 250,
              backgroundColor: AppColor.primaryColor,
              child: Column(
                children: [
                  MaterialButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "History List",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: AppColor.whiteColor),
                      ),
                    ),
                  ),
                  Divider(
                    color: AppColor.whiteColor,
                    thickness: 1.5,
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "FAQ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: AppColor.whiteColor),
                      ),
                    ),
                  ),
                  Divider(
                    color: AppColor.whiteColor,
                    thickness: 1.5,
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "About Us",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: AppColor.whiteColor),
                      ),
                    ),
                  ),
                  Divider(
                    color: AppColor.whiteColor,
                    thickness: 1.5,
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Contact Us",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: AppColor.whiteColor),
                      ),
                    ),
                  ),
                  Divider(
                    color: AppColor.whiteColor,
                    thickness: 1.5,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 40,),
                      IconButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                          },
                          icon: ImageIcon(
                              color: AppColor.whiteColor,
                              size: 55,
                              AssetImage("assets/icons/SignoutIcon.png"))),
                      Text("Log Out",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: AppColor.whiteColor),)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: pgDetails[selectedIndex],
      ),
    );
  }
}

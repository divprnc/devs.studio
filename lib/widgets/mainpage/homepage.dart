import 'package:devloperstudio/size_configuration.dart';
import 'package:devloperstudio/theme.dart';
import 'package:devloperstudio/widgets/cpquestions/cpquestions_main.dart';
import 'package:devloperstudio/widgets/jobsportal/jobsmain.dart';
import 'package:devloperstudio/widgets/mycontests/myContest.dart';
import 'package:devloperstudio/widgets/settings/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:devloperstudio/widgets/cpnotes/cp_main.dart';
import 'package:devloperstudio/widgets/cpforum/forum_main.dart';
import 'package:devloperstudio/widgets/ebooks/ebook_main.dart';
import 'package:devloperstudio/widgets/leaderboard/leaderboard.dart';
import 'package:devloperstudio/widgets/livecontests/live_contest_mainPage.dart';
import 'package:devloperstudio/widgets/mainpage/main_home.dart';
import 'package:devloperstudio/widgets/notification/notification.dart';
import 'package:devloperstudio/widgets/profile/profile_page.dart';
import 'package:devloperstudio/widgets/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:devloperstudio/widgets/authorization/loginModel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoginModel model = new LoginModel();
  bool isLoading = false;
  String userEmail = "", userName = "", userProfilePic = "";
  int _selectedIndex = 0;
  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    userEmail = FirebaseAuth.instance.currentUser.email;
    userName = FirebaseAuth.instance.currentUser.displayName;
    userProfilePic = FirebaseAuth.instance.currentUser.photoURL;
    if (userName == "" || userName == null) {
      userName = "Developer.Studio";
    }

    List data = userEmail.split('@');
    userEmail = "@${data[0]}";
    setState(() {
      isLoading = false;
    });
  }

  final List<Widget> _wid = [
    MainHomePage(),
    CpForumMain(),
    MyContests(),
    LeaderBoard(),
  ];
  void _onClickChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Widget drawerupScreen(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.blue,
          height: SizeConfig.safeBlockVertical * 25,
          width: double.infinity,
        ),
        Positioned(
            left: SizeConfig.screenWidth * 0.02,
            top: SizeConfig.screenHeight * 0.07,
            child: CircleAvatar(
              backgroundImage: userProfilePic == null || userProfilePic == ""
                  ? AssetImage("assets/images/profile.jpg")
                  : NetworkImage(userProfilePic),
              maxRadius: 40,
            )),
        Positioned(
            left: SizeConfig.screenWidth * 0.24,
            top: SizeConfig.screenHeight * 0.082,
            child: Text(
              userName,
              style: profileTextWhite,
            )),
        Positioned(
            left: SizeConfig.screenWidth * 0.24,
            top: SizeConfig.screenHeight * 0.12,
            child: Text(
              userEmail,
              style: profileTextWhite,
            )),
      ],
    );
  }

  Widget drawerMenu(String title, Widget icon, Function func) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontFamily: "OpenSans",
          fontSize: 17,
        ),
      ),
      leading: icon,
      onTap: func,
    );
  }

  Future<bool> _backButtonPressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              elevation: 10,
              backgroundColor: Colors.white,
              title: Text(
                "Do you really want to exit ?",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Quicksand",
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text(
                      "No",
                      style: TextStyle(
                        color: Colors.blue,
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.red,
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.bold,
                      ),
                    ))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    Image appLogo = new Image(
        image: new ExactAssetImage("assets/logos/home_icon.png"),
        height: 100.0,
        width: 90.0,
        alignment: FractionalOffset.center);
    Image ebook = new Image(
        image: new ExactAssetImage("assets/logos/ebook.png"),
        alignment: FractionalOffset.center);
    Image coding = new Image(
        image: new ExactAssetImage("assets/logos/code.png"),
        height: 25.0,
        width: 25.0,
        color: Colors.blue,
        alignment: FractionalOffset.center);
    Image liveContest = new Image(
        image: new ExactAssetImage("assets/logos/live_contest.png"),
        color: Colors.blue,
        alignment: FractionalOffset.center);
    return WillPopScope(
      onWillPop: _backButtonPressed,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.blue),
          title: appLogo,
          actions: [
            Padding(
              padding: EdgeInsets.only(
                right: 10,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return NotificationPage();
                  }));
                },
                child: Icon(
                  Icons.notifications,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
        drawer: Drawer(
          elevation: 10,
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  drawerupScreen(context),
                  drawerMenu(
                      "Profile",
                      Icon(
                        Icons.person_outline_sharp,
                        color: Colors.blue.shade700,
                      ), () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return ProfilePage();
                    }));
                  }),
                  drawerMenu(
                      "Wallet",
                      Icon(
                        Icons.account_balance_wallet_outlined,
                        color: Colors.blue,
                      ), () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return WalletPage();
                    }));
                  }),
                  // drawerMenu("Ebooks", ebook, () {
                  //   Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  //     return EbookMainPage();
                  //   }));
                  // }),
                  drawerMenu("Comptetive Programming", coding, () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return CpMainPage();
                    }));
                  }),
                  drawerMenu(
                      "Cp Questions",
                      Icon(
                        Icons.my_library_books,
                        color: Colors.blue,
                      ), () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return CpQuestionsMainPage();
                    }));
                  }),
                  drawerMenu("Live Contests", liveContest, () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return LiveCodingContests();
                    }));
                  }),
                  drawerMenu(
                      "Jobs",
                      Icon(
                        Icons.work_outline_outlined,
                        color: Colors.blue,
                      ), () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return JobPortalMain();
                    }));
                  }),
                  // drawerMenu(
                  //     "Settings",
                  //     Icon(
                  //       Icons.settings,
                  //       color: Colors.blue,
                  //     ), () {
                  //   Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  //     return SettingsPage();
                  //   }));
                  // }),
                  drawerMenu(
                      "Sign Out",
                      Icon(
                        Icons.logout,
                        color: Colors.blue,
                      ), () {
                    model.signOut().then((value) => {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "/login", ModalRoute.withName("/home"))
                        });
                  }),
                ],
              ),
            ),
          ),
        ),
        body: _wid[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 20,
          backgroundColor: Colors.white,
          elevation: 5,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          currentIndex: _selectedIndex,
          onTap: _onClickChange,
          items: [
            BottomNavigationBarItem(
                backgroundColor: Colors.black,
                icon: Icon(
                  Icons.home,
                ),
                label: ""),
            BottomNavigationBarItem(
                backgroundColor: Colors.black,
                icon: Image(
                    height: 25.0,
                    width: 25.0,
                    color: _selectedIndex == 1 ? Colors.blue : Colors.black,
                    image: new ExactAssetImage("assets/logos/carbon_forum.png"),
                    alignment: FractionalOffset.center),
                label: ""),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.auto_awesome_motion,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Image.asset(
                "assets/logos/leaderboard_icon.png",
                color: _selectedIndex == 3 ? Colors.blue : Colors.black,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}

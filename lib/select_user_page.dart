import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_neflix_cover/edit_user_page.dart';
import 'package:flutter_neflix_cover/main_page.dart';
import 'package:flutter_neflix_cover/model/user.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectUserPage extends StatefulWidget {
  @override
  _SelectUserPageState createState() => _SelectUserPageState();
}

class _SelectUserPageState extends State<SelectUserPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<List<User>> _users;

  Future<void> mockNetworkData() async {
    print('future work');
    return Future.delayed(Duration(seconds: 4), () async {
      final SharedPreferences prefs = await _prefs;
      List<User> users = [
        User("Player1", "assets/icons/icon_user.jpg"),
        User("Player2", "assets/icons/icon_user.jpg"),
        User("Player3", "assets/icons/icon_user.jpg"),
        User("Player4", "assets/icons/icon_user.jpg"),
      ];
      String s = json.encode(users);
      _users = prefs.setString('users', s).then((bool success) {
        print("setString : $success");
        return users;
      });
    });
  }

  TextStyle titleStyle = TextStyle(color: Colors.white, fontSize: 20.0);
  TextStyle userNameStyle = TextStyle(color: Colors.white, fontSize: 14.0);

  bool editMode = false;

  @override
  void initState() {
    print('initState');
    _users = _prefs.then((SharedPreferences prefs) async {
      print("_prefs");
      String _string = prefs.getString('users') ?? '';
      print("_string :$_string");
      if (_string.isEmpty) {
        await mockNetworkData();
        _string = prefs.getString('users') ?? '';
      }
      List maps = json.decode(_string);
      List<User> users = maps.map((e) => User.fromJson(e)).toList();
      return users;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Offstage(
                    offstage: !editMode,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        setState(() {
                          editMode = false;
                        });
                      },
                    )),
              ),
              !editMode
                  ? Image.asset(
                      "assets/netflix_logo.png",
                      height: 80,
                    )
                  : SizedBox(
                      height: 80,
                      child: Center(
                          child: Builder(builder: (BuildContext context) {
                        return Text(
                          AppLocalizations.of(context).manageUser,
                          style: titleStyle.copyWith(fontSize: 24.0),
                        );
                      }))),
              Align(
                  alignment: Alignment.centerRight,
                  child: Offstage(
                    offstage: editMode,
                    child: IconButton(
                      icon: Icon(Icons.mode_edit),
                      onPressed: () {
                        setState(() {
                          editMode = true;
                        });
                      },
                    ),
                  ))
            ],
          ),
          AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: editMode == true ? 0.0 : 1.0,
            child: Text(
              AppLocalizations.of(context).whoIsWatching,
              style: titleStyle,
            ),
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: FutureBuilder<List<User>>(
                  future: _users,
                  builder: (context, snapshot) {
                    print("snapshot: $snapshot");
                    print('data: ${snapshot.data}');
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data != null) {
                      return GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 10 / 12,
                        children: List.generate(snapshot.data.length,
                            (index) => _buildUser(snapshot.data[index])),
                      );
                    }
                    return GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 10 / 12,
                      children: List.generate(4, (index) => _buildWaiting()),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  _buildWaiting() {
    return Container(
//      color: Colors.red,
      child: Column(
        children: [
          Expanded(
              child: Container(
            color: Colors.white.withOpacity(0.1),
            child: Stack(
              alignment: Alignment.center,
              children: [
//                  Image.asset(user.assetName),
              ],
            ),
          )),
          SizedBox(
            height: 8.0,
          ),
          Text(
            "",
            style: userNameStyle,
          )
        ],
      ),
    );
  }

  _buildUser(User user) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (_) => editMode
                    ? EditUserPage(
                        user: user,
                      )
                    : MainPage()))
            .then((value) {
          if (value == 1) {
            // _future = _users;
            setState(() {});
          } else {
            print("未儲存變更");
          }
        });
      },
      child: Container(
//      color: Colors.red,
        child: Column(
          children: [
            Expanded(
                child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(user.assetName),
                Offstage(
                    offstage: !editMode,
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                    )),
                Offstage(
                  offstage: !editMode,
                  child: Icon(Icons.edit),
                )
              ],
            )),
            SizedBox(
              height: 8.0,
            ),
            Text(
              "${user.name}",
              style: userNameStyle,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'model/user.dart';

class EditUserPage extends StatefulWidget {
  final User user;

  EditUserPage({required this.user});

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  TextStyle titleStyle = TextStyle(color: Colors.white, fontSize: 20.0);
  TextStyle inputStyle = TextStyle(color: Colors.white, fontSize: 16.0);
  TextStyle saveStyle = TextStyle(color: Colors.green, fontSize: 16.0);

  bool _isButtonDisabled = false;
  bool savingState = false;

  late TextEditingController _editingController;

  var screenSized;

  void _saveChange() {
    widget.user.name = _editingController.text;
    print("widget.user.name ${widget.user.name}");
    savingState = true;
    setState(() {});
    Future.delayed(Duration(seconds: 2), () {
      savingState = false;
      setState(() {
        Navigator.of(context).pop(1);
      });
    });
  }

  @override
  void initState() {
    _editingController = TextEditingController(text: widget.user.name);
    _editingController.addListener(() {
      print(_editingController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSized = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).pop(0);
                        });
                      },
                    ),
                  ),
                  SizedBox(
                      height: 80,
                      child: Center(
                          child: Text(
                        "編輯使用者",
                        style: titleStyle.copyWith(fontSize: 24.0),
                      ))),
                  Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: saveStyle.color,
                            disabledForegroundColor: Colors.grey,
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(
                            "儲存",
                          ),
                          onPressed: _isButtonDisabled ? null : _saveChange,
                        ),
                      ))
                ],
              ),
              _buildEditUserWidgets()
            ],
          ),
          Offstage(
            offstage: !savingState,
            child: Container(
//              width: double.infinity,
//              height: double.infinity,
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.red),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildEditUserWidgets() {
    return Column(
      children: [
        _buildUserAvatar(),
        _buildInputTextField(),
        _buildOtherWidgets()
      ],
    );
  }

  _buildUserAvatar() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Ink(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: AssetImage(
                    widget.user.assetName,
                  ),
                )),
            width: screenSized.width * 0.3,
            height: screenSized.width * .3,
            child: InkWell(
              borderRadius: BorderRadius.circular(8.0),
              onTap: () {},
            ),
          ),
        ),
        Positioned(
          right: 0.0,
          bottom: 0.0,
          child: Icon(Icons.edit),
        )
      ],
    );
  }

  _buildInputTextField() {
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      color: Color(0xff333333),
      width: screenSized.width * 0.7,
      child: TextField(
        controller: _editingController,
        cursorColor: Colors.white,
        style: inputStyle,
        decoration:
            InputDecoration(border: InputBorder.none),
      ),
    );
  }

  _buildOtherWidgets() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(4.0),
          child: Text("所有年齡分級"),
        ),
        Text("顯示所有年齡分級的影片給這位使用者觀賞"),
        Text("請前往帳戶設定變更")
      ],
    );
  }
}

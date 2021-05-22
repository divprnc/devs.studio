import 'package:flutter/material.dart';
import 'package:devloperstudio/size_configuration.dart';
import 'package:devloperstudio/theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AddBalance extends StatefulWidget {
  @override
  _AddBalanceState createState() => _AddBalanceState();
}

class MessageDisplayer {
  const MessageDisplayer(this.title);
  final String title;
}

class _AddBalanceState extends State<AddBalance> {
  final List<MessageDisplayer> _cast = <MessageDisplayer>[
    const MessageDisplayer("Currently We are not accepting wallet payments"),
  ];
  Iterable<Widget> get actorWidgets sync* {
    for (final MessageDisplayer actor in _cast) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: Chip(
          backgroundColor: Colors.blue[50],
          label: Text(
            actor.title,
            style: TextStyle(fontFamily: "OpenSans", color: Colors.blue[900]),
          ),
          onDeleted: () {
            setState(() {
              _cast.removeWhere((MessageDisplayer entry) {
                return entry.title == actor.title;
              });
            });
          },
        ),
      );
    }
  }

  Image appLogo = new Image(
      image: new ExactAssetImage("assets/logos/home_icon.png"),
      height: 100.0,
      width: 90.0,
      alignment: FractionalOffset.center);
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _email = '', _password = '';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: appLogo,
      ),
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(
              child: SpinKitRing(
                color: Colors.blue,
                lineWidth: 4,
                size: 40,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Wrap(
                    children: actorWidgets.toList(),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                _email = value;
                              });
                            },
                            validator: (balance) {
                              if (int.parse(balance) < 10) {
                                return 'Please add minimum 10 Rupees';
                              }
                              return null;
                            },
                            cursorHeight: 20,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                contentPadding: EdgeInsets.only(left: 10),
                                hintText: "Amount",
                                hintStyle: textFieldSize),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: SizeConfig.screenHeight * 0.06,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: ElevatedButton(
                            child: isLoading
                                ? SpinKitRing(
                                    color: Colors.white,
                                    lineWidth: 4,
                                    size: 40,
                                  )
                                : Text(
                                    "Add",
                                    style: normalTextWhite,
                                  ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  isLoading = true;
                                });

                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

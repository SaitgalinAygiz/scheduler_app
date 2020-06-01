import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedulerapp/constants/app_constants.dart';
import 'package:schedulerapp/services/auth.dart';
import 'package:schedulerapp/services/push_notification_service.dart';
import 'package:schedulerapp/ui/views/base.widget.dart';
import 'package:schedulerapp/viewmodels/views/login_view_model.dart';

class AuthorizationPage extends StatefulWidget {
  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  TextEditingController _idController = TextEditingController();
  final _codeController = TextEditingController();
  final _authApi = AuthApi();
  String _id, verificationId;
  bool showLogin = true;

  bool codeSent = false;
  bool successful = false;

  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationFailed: (AuthException exception) async {
          print(exception.message);
        },
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          var userFromBack = await _authApi.fetchUser(user.phoneNumber);
          if (userFromBack.name != user.displayName) {
            UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
            userUpdateInfo.displayName = userFromBack.name;

            await user.updateProfile(userUpdateInfo);
          }

          PushNotificationService pushNotificationService =
              new PushNotificationService(user);
          await pushNotificationService.initialize();

          if (user != null) {
            Navigator.pushNamed(context, RoutePaths.Home);
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    "На ваш номер телефона был выслан код",
                    style: TextStyle(color: Colors.black),
                  ),
                  content: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextField(
                          keyboardType: TextInputType.phone,
                          controller: _codeController,
                          maxLength: 6,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right: 80),
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child:
                            Text("Подтвердить", style: TextStyle(fontSize: 15)),
                        textColor: Colors.white,
                        color: Colors.blue,
                        onPressed: () async {
                          final code = _codeController.text.trim();
                          AuthCredential credential =
                              PhoneAuthProvider.getCredential(
                                  verificationId: verificationId,
                                  smsCode: code);

                          AuthResult result =
                              await _auth.signInWithCredential(credential);

                          FirebaseUser user = result.user;

                          var userFromBack =
                              await AuthApi().fetchUser(user.phoneNumber);
                          if (userFromBack.name != user.displayName) {
                            UserUpdateInfo userUpdateInfo =
                                new UserUpdateInfo();
                            userUpdateInfo.displayName = userFromBack.name;

                            await user.updateProfile(userUpdateInfo);
                          }

                          PushNotificationService pushNotificationService =
                              new PushNotificationService(user);
                          await pushNotificationService.initialize();

                          if (user != null) {
                            Navigator.pushNamed(context, RoutePaths.Home);
                          } else {
                            print("Ошибка");
                          }
                        },
                      ),
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: null);
  }

  @override
  Widget build(BuildContext context) {
    Widget _logo() {
      return Padding(
        padding: EdgeInsets.only(top: 0),
        child: Container(
          child: Stack(children: <Widget>[
            Align(
                child: Text('УКРТБ',
                    style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))),
            Padding(
                padding: const EdgeInsets.only(top: 70),
              child: Align(
                  child: Text('Дистанционное обучение',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
            ),
          ]),
        ),
      );
    }

    Widget _input(Icon icon, String hint, TextEditingController controller,
        bool obsecure) {
      return Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            controller: controller,
            obscureText: obsecure,
            keyboardType: TextInputType.phone,
            style: TextStyle(fontSize: 20, color: Colors.white),
            decoration: InputDecoration(
                hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white30),
                hintText: hint,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 3)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54, width: 1)),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: IconTheme(
                    data: IconThemeData(color: Colors.white),
                    child: icon,
                  ),
                )),
          ));
    }

    Widget _button(String text, LoginViewModel model) {
      return RaisedButton(
        splashColor: Theme.of(context).primaryColor,
        highlightColor: Theme.of(context).primaryColor,
        color: Colors.white,
        child: Text(text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
                fontSize: 15)),
        onPressed: () async {
          _id = _idController.text;
          if (_id.isEmpty) return;

          loginUser(_id, context);

          _idController.clear();
        },
      );
    }

    Widget _form(String label, LoginViewModel model) {
      return Container(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(bottom: 20, top: 20),
                child: _input(
                    Icon(Icons.phone), "Номер телефона", _idController, false)),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: _button(label, model),
              ),
            )
          ],
        ),
      );
    }

    return BaseWidget<LoginViewModel>(
      model: LoginViewModel(authService: Provider.of(context)),
      builder: (context, model, child) => Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _logo(),
              SizedBox(
                height: 100,
              ),
              model.busy
                  ? CircularProgressIndicator()
                  : _form('Выслать код на номер телефона', model),
            ],
          )),
    );
  }
}

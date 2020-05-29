import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:schedulerapp/constants/app_constants.dart';
import 'package:schedulerapp/services/auth.dart';
import 'package:schedulerapp/services/authentication_service.dart';
import 'package:schedulerapp/ui/views/base.widget.dart';
import 'package:schedulerapp/viewmodels/views/login_view_model.dart';

class AuthorizationPage extends StatefulWidget {
  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  TextEditingController _idController = TextEditingController();
  String _id;
  bool showLogin = true;

  @override
  Widget build(BuildContext context) {
    Widget _logo() {
      return Padding(
        padding: EdgeInsets.only(top: 100),
        child: Container(
          child: Align(
              child: Text('УКРТБ',
                  style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))),
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
            style: TextStyle(fontSize: 20, color: Colors.white),
            decoration: InputDecoration(
                hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
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
                fontSize: 20)),
        onPressed: () async {
          _id = _idController.text;
          if (_id.isEmpty) return;

          var loginSuccess = await model.login(_id.trim());

          if (loginSuccess) {
            Navigator.pushNamed(context, RoutePaths.Home);
          } else {
            Fluttertoast.showToast(
                msg: "Неверный ID студента/преподавателя",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }

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
                    Icon(Icons.perm_identity), "ID", _idController, false)),
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
                      : _form('ВОЙТИ', model),
                ],
              )),
        );
  }
}

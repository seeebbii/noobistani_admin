import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:noobistani_admin/controllers/authController.dart';
import 'package:noobistani_admin/utilities/constant_dart.dart';
import 'SignupScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();
  String? _userEmail, _userPassword;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      // Create user on auth request
      authController.login(_userEmail!, _userPassword!);
    }
  }

  Widget _emailFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          height: 60.0,
          decoration: kBoxDecorationStyle,
          alignment: Alignment.center,
          child: TextFormField(
            key: ValueKey('email'),
            validator: (value) {
              if (value!.isEmpty || !value.contains("@")) {
                return 'Please enter a valid email address';
              } else {
                return null;
              }
            },
            onSaved: (value) {
              _userEmail = value;
            },
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                hintText: "Enter your Email",
                hintStyle: kHintTextStyle
            ),
          ),
        ),
      ],
    );
  }

  Widget _passwordFormField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          height: 60.0,
          decoration: kBoxDecorationStyle,
          alignment: Alignment.center,
          child: TextFormField(
            key: ValueKey('password'),
            validator: (value) {
              if (value!.isEmpty || value.length < 7) {
                return 'Password must be at least 7 characters long';
              } else {
                return null;
              }
            },
            onSaved: (value) {
              _userPassword = value;
            },
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                hintText: "Enter your Password",
                hintStyle: kHintTextStyle
            ),
          ),
        ),
      ],
    );
  }

  Widget _forgotPass() {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLoginBtn(),
          FlatButton(
            onPressed: () => print('Forgot Password Button Pressed'),
            padding: EdgeInsets.only(right: 0.0),
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                color: Colors.purpleAccent.shade100,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: RaisedButton(
        elevation: 5.0,
        onPressed: _trySubmit,
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        color: Colors.purpleAccent.shade100,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 1.5,
            fontSize: 15.0,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }


  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
          return SignUp();
        }));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15.0),
        alignment: Alignment.bottomCenter,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Don\'t have an Account? ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Create one',
                style: TextStyle(
                  color: Colors.purpleAccent.shade100,
                  decoration: TextDecoration.underline,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // DIALOGS
  AlertDialog loading = AlertDialog(
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    content: Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade700,
          borderRadius: BorderRadius.circular(15.0)),
      height: 200,
      width: 50,
      child: CircularProgressIndicator(
        color: Colors.purpleAccent.shade100,
      ),
    ),
  );

  AlertDialog error = AlertDialog(
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    content: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10.0,
      color: Colors.grey.shade700,
      child: ListTile(
        leading: Icon(Icons.error_outline, color: Colors.purpleAccent.shade100,),
        title: (Text(
            'Invalid credentials!',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w200,
                fontSize: 15)
        )),
      ),
    ),
  );

  AlertDialog success = AlertDialog(
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    content: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10.0,
      color: Colors.grey.shade700,
      child: ListTile(
        leading: Icon(Icons.done_outline, color: Colors.purpleAccent.shade100,),
        title: (Text(
            'Login Successful!',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w200,
                fontSize: 15)
        )),
      ),
    ),
  );

  AlertDialog caution = AlertDialog(
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    content: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10.0,
      color: Colors.grey.shade700,
      child: ListTile(
        leading: Icon(Icons.close, color: Colors.purpleAccent.shade100,),
        title: (Text(
            'An error has occurred !',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w200,
                fontSize: 15)
        )),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children:[
                Container(
                  margin: const EdgeInsets.all(15),
                  child: Text(
                    'NOOBISTANI',
                    style: TextStyle(
                        letterSpacing: 2.5,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.2
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 30.0,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/logo/nbLogo.png',
                          height: 150,
                          width: 1000,
                          fit: BoxFit.cover,),
                          _emailFormField(),
                          SizedBox(
                            height: 30.0,
                          ),
                          _passwordFormField(),
                          _forgotPass(),
                          Divider(
                            height: 5.0,
                            color: Colors.grey.shade700,
                            thickness: 1.0,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          GestureDetector(
                            onTap: () async{
                              authController.loginWithGoogle();
                            },
                            child: Image.asset('assets/logo/google.png',height: 50,),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          _buildSignupBtn(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
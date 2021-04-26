import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:noobistani_admin/controllers/authController.dart';
import 'package:noobistani_admin/utilities/constant_dart.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();
  String? _userEmail, _userName, _userPassword;

  @override
  void initState() {
    super.initState();
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      // Create user on auth request
      authController.createUser(_userEmail!, _userName!, _userPassword!);
    }
  }


  Widget _nameTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Full Name',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            key: ValueKey('username'),
            validator: (value) {
              if (value!.isEmpty || value.length < 4 ) {
                return 'Please enter at least 4 characters';
              } if(value.length > 12){
                return 'Cannot exceed 12 charachters';
              } else {
                return null;
              }
            },
            onSaved: (value) {
              _userName = value;
            },
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person_outline,
                color: Colors.white,
              ),
              hintText: 'Enter your Name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _emailTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
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
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _passTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
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
                Icons.lock_outline,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _signUpButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: _trySubmit,
        padding: EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.purpleAccent.shade100,
        child: Text(
          'REGISTER',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 1.5,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15.0),
        alignment: Alignment.bottomCenter,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Have an Account? ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Sign In',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.purpleAccent.shade100,
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

  Widget _buildRegisterPage() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/logo/nbLogo.png',
            height: 150,
            width: 1000,
            fit: BoxFit.cover,
          ),
          _nameTextField(),
          SizedBox(
            height: 30.0,
          ),
          _emailTextField(),
          SizedBox(
            height: 30.0,
          ),
          _passTextField(),
          SizedBox(
            height: 25.0,
          ),
          _signUpButton(),
          Divider(
            height: 5.0,
            color: Colors.grey.shade700,
            thickness: 1.0,
          ),
          SizedBox(
            height: 15.0,
          ),
          _signInButton()
        ],
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

  AlertDialog emailAlready = AlertDialog(
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
            'Email already exists !',
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
          'Account created successfully!',
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
                        fontSize: 18.2),
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
                      child: _buildRegisterPage()),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

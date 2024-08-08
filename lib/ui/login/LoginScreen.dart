
import 'package:flutter/material.dart';
import 'package:to_do_app_c11/ui/common/AppFormField.dart';
import 'package:to_do_app_c11/ui/register/RegisterScreen.dart';

import '../ValidationUtilities.dart';
import '../utilities.dart';



class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static const String routeName="Login Screen";


  TextEditingController userEmailAddress=TextEditingController();
  TextEditingController userPassword=TextEditingController();


  GlobalKey<FormState> formKey =GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.routeMainColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),

        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 40,),
                Image.asset(getImagePath('route_logo.png'),
                  width: double.infinity,
                ),

                AppFormField(title: "E-mail address",
                  hint: "enter your email address",
                  myKeyboardType: TextInputType.emailAddress,
                  myValidator:(text){
                    if (text?.trim().isEmpty==true){
                      return "please enter your email address";
                    }
                    if(!isValidEmail(text!)) {
                      return "please enter valid email";
                    }
                    return null;
                  },
                  userController:userEmailAddress,
                ),
                AppFormField(title: "Password",
                  hint: "enter your password",
                  myKeyboardType: TextInputType.text,
                  securedPassword: true,
                  myValidator:(text){
                    if (text?.trim().isEmpty==true){
                      return "please enter your password";
                    }
                    if(!isValidPassword(text!)) {
                      return "please enter valid Password";
                    }
                    return null;
                  },
                  userController:userPassword,
                ),

                SizedBox(height: 24,),
                ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                      ),
                      padding: EdgeInsets.symmetric(vertical: 18),
                      backgroundColor:Colors.white,
                    ),
                    onPressed: (){
                      loginCheck();

                    }, child: Text('Login',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.routeMainColor
                  ),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have account ?",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white
                    ),
                    ),
                    TextButton(onPressed: (){
                      Navigator.pushReplacementNamed(context, RegisterScreen.routeName);
                    }, child: Text("Create Account",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginCheck(){
    // validate form
    formKey.currentState?.validate();
  }
}


import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app_c11/FirebaseAuthCodes.dart';
import 'package:to_do_app_c11/ui/common/AppFormField.dart';
import 'package:to_do_app_c11/ui/home/home_screen.dart';
import 'package:to_do_app_c11/ui/login/LoginScreen.dart';
import 'package:to_do_app_c11/ui/register/Dialog_utilities.dart';

import '../../providers/appAuthProvider.dart';
import '../ValidationUtilities.dart';
import '../utilities.dart';



class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  static const String routeName="Register Screen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController userFullName=TextEditingController();

  TextEditingController userPhoneNumber=TextEditingController();

  TextEditingController userEmailAddress=TextEditingController();

  TextEditingController userPassword=TextEditingController();

  TextEditingController userPasswordConfirmation=TextEditingController();

  GlobalKey<FormState> formKey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.routeMainColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),

        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40,),
                Image.asset(getImagePath('route_logo.png'),
                width: double.infinity,
                ),
                AppFormField(title: "Full Name",
                hint: "enter your full name",
                myKeyboardType: TextInputType.name,
                  myValidator:(text){
                  if (text?.trim().isEmpty==true){
                   return "please enter full name";
                  }
                  if((text?.length??0)<6) {
                    return "full name at least 6 characters";
                  }
                  return null;
                  },
                    userController:userFullName,
                ),
                AppFormField(title: "Mobile Number",
                  hint: "enter your mobile number",
                  myKeyboardType: TextInputType.phone,
                  myValidator:(text){
                    if (text?.trim().isEmpty==true){
                      return "please enter your phone number";
                    }
                    if(!isValidPhoneNumber(text!)) {
                      return "please enter valid email";
                    }
                    return null;
                  },
                  userController:userPhoneNumber,
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
                AppFormField(title: "Password Confirmation",
                  hint: "enter your password confirmation",
                  myKeyboardType: TextInputType.text,
                  securedPassword: true,
                    myValidator:(text){
                      if (text?.trim().isEmpty==true){
                        return "please enter your password";
                      }
                      if(userPassword.text!=userPasswordConfirmation.text){
                        return "password doesn't match";
                      }
                      return null;
                    },
                  userController:userPasswordConfirmation,
                ),
                const SizedBox(height: 24,),
                ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      backgroundColor:Colors.white,
                    ),
                    onPressed: (){
                      registerCheck();

                }, child: Text('Sign Up',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.routeMainColor
                ),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have account ?",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white
                      ),
                    ),
                    TextButton(onPressed: (){
                      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                    }, child: Text("login!",
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

  void registerCheck(){
    showMessageDialog(context,message: 'Registering',postButtonTitle: "ok",
    postButtonAction: (){
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });

    showLoadingDialog(context, message:"please wait");

    // validate form
    if(formKey.currentState?.validate()==false)
     { return;}
    createAccount();

  }

  void createAccount() async {
 var myAuthProvider= Provider.of<appAuthProvider>(context,listen: false);
    try {
      showLoadingDialog(context, message: 'please wait....');
final appUser=await myAuthProvider.createUserWithEmailAndPassword(
    userEmailAddress.text,
    userPassword.text,
    userFullName.text);
hideLoading(context);

if(appUser==null){

  showMessageDialog(context, message:'Something went wrong',
      postButtonTitle: 'try again',
      postButtonAction: (){
    createAccount();
      });
  return;
}


     showMessageDialog(context, message:'User created successfully',
     postButtonTitle: 'ok',
     postButtonAction: (){
       Navigator.pushReplacementNamed(context, HomeScreen.routeName);
     }
     );
    } on FirebaseAuthException catch (e) {
      String message ='Something went wrong';

      if (e.code == FirebaseAuthCodes.WEAK_PASSWORD) {
        message='The password provided is too weak.';
      } else if (e.code == FirebaseAuthCodes.EMAIL_IN_USE) {
        message='The account already exists for that email.';
      }
      hideLoading(context);
      showMessageDialog(context, message: message,postButtonTitle: 'ok');
    } on TimeoutException {
      String message ='No internet connection';
      hideLoading(context);
      showMessageDialog(context, message: message,postButtonTitle: 'check connection');
    }catch (e) {
      String message ='Something went wrong';

     // e is TimeoutException -> wifi without internet
      // e is IOException -> no network
      hideLoading(context);
      showMessageDialog(context, message: message,postButtonTitle: 'try again',
      postButtonAction: (){
        registerCheck();
      }
      );

    }
  }
}

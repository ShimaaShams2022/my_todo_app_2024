import 'dart:ffi';
import 'package:flutter/material.dart';

typedef Validator = String? Function(String? text);

class AppFormField extends StatefulWidget {

  String title;
  String hint;
  TextInputType myKeyboardType;
  bool securedPassword;
  Validator? myValidator=null;
  TextEditingController? userController=null;


  AppFormField(
      {required this.title,
      required this.hint,
      this.myKeyboardType = TextInputType.text,
      this.securedPassword = false,
        this.myValidator,
        this.userController,
        super.key,
     });




  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {

  bool isVisibleText=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isVisibleText=widget.securedPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.symmetric(vertical: 12) ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 12),
          TextFormField(
            validator: widget.myValidator,
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
                suffixIcon: widget.securedPassword? InkWell(
                    onTap: () {
                      setState(() {
                        isVisibleText =!isVisibleText;
                      });

                    },
                    child: Icon(isVisibleText?
                          Icons.visibility_off_outlined
                        : Icons.visibility))
                :null,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white,
                hintText: widget.hint,
                hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black)),
            keyboardType: widget.myKeyboardType,
            obscureText: isVisibleText,
            controller: widget.userController,
          ),
        ],
      ),
    );
  }
}

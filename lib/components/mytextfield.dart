import 'package:flutter/material.dart';
import 'package:projectflutter2/theme/Theme.dart';

class Mytextfield extends StatefulWidget {
  final String text;
  final TextEditingController? controller;
  final String? Function(String?)? validate;
  // final void Function(String value)? onChanged;
  final bool readOnly;
  final bool Obscuretext;
  Mytextfield({
    super.key,
    required this.text,
    required this.Obscuretext,
    required this.validate,
    this.controller,
    required this.readOnly,
  });

  @override
  State<Mytextfield> createState() => _MytextfieldState();
}

class _MytextfieldState extends State<Mytextfield> {
  bool _passwordVisible = false;
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   emailTextController.addListener(() {
  //     if (widget.onChanged != null) {
  //       widget.onChanged!(emailTextController.text);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              obscureText: widget.Obscuretext ? !_passwordVisible : false,
              controller: widget.controller,
              readOnly: widget.readOnly,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: widget.validate,
              decoration: InputDecoration(
                suffixIcon: widget.Obscuretext
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      )
                    : null,
                hintText: widget.text,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: TextColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: inputBorder),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              style: TextStyle(color: White),
            ),
          ),
        ],
      ),
    );
  }
}

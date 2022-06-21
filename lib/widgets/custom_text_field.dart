import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/helpers/helper.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Function validator;
  final bool obscureText;
  final Function onSaved;
  final Function onFieldSubmitted;
  final Function onChanged;

  CustomTextField({
    Key key,
    this.onSaved,
    this.onFieldSubmitted,
    this.onChanged,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.validator = validateName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 370),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.next,
        validator: validator,
        obscureText: obscureText,
        onSaved: onSaved,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        decoration: InputDecoration(
//            labelText: labelText ?? "Password",
            hintText: hintText ?? "123",
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(color: active, width: 2.0)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}

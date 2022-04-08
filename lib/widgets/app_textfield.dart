import 'package:flutter/material.dart';

class CommonTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final bool? obsecure;
  final TextInputType? type;
  final int? lines;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  final bool readOnly;
  const CommonTextFormField(this.controller, this.hintText, this.labelText,
      this.obsecure, this.type, this.lines, this.onChanged, this.onTap,
      {this.readOnly = false, this.onFieldSubmitted});

  @override
  _CommonTextFormFieldState createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.lines,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      keyboardType: widget.type,
      onChanged: widget.onChanged,
      //cursorColor: AppColors.primary_color,
      controller: widget.controller,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        hintStyle: const TextStyle(color: Color(0xff666666)),
        labelStyle: const TextStyle(color: Color(0xff666666)),
        errorStyle: const TextStyle(color: Colors.red),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Color(0xffC7C7C7)),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Color(0xffC7C7C7)),
          gapPadding: 10,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.red),
          gapPadding: 10,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.red),
          gapPadding: 10,
        ),
      ),
    );
  }
}

class CommonTextFormField1 extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool readOnly;
  final bool obsecure;
  final TextInputType type;

  // ignore: prefer_typing_uninitialized_variables
  final validator;
  final int? lines;
  // ignore: prefer_typing_uninitialized_variables
  final showSuffix;
  // ignore: prefer_typing_uninitialized_variables
  final changeObscureStatus;

  const CommonTextFormField1(this.controller, this.hintText, this.labelText,
      this.obsecure, this.type, this.validator, this.lines,
      {this.showSuffix = false,
      this.changeObscureStatus,
      this.readOnly = false});

  @override
  _CommonTextFormField1State createState() => _CommonTextFormField1State();
}

class _CommonTextFormField1State extends State<CommonTextFormField1> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.lines,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      keyboardType: widget.type,
      obscureText: widget.obsecure,
      readOnly: widget.readOnly,
      //cursorColor: fLabelTextColor,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        hintStyle: const TextStyle(color: Color(0xFF797a7a)),
        labelStyle: const TextStyle(color: Color(0xff808080)),
        errorStyle: const TextStyle(color: Colors.red),
        suffixIcon: widget.showSuffix
            ? InkWell(
                onTap: widget.changeObscureStatus,
                child: Icon(
                    widget.obsecure ? Icons.visibility_off : Icons.visibility),
              )
            : const SizedBox(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Color(0xff808080)),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Color(0xff808080)),
          gapPadding: 10,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.red),
          gapPadding: 10,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.red),
          gapPadding: 10,
        ),
      ),
    );
  }
}

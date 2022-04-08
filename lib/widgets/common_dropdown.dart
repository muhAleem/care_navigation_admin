
import 'package:care_navigation_admin_panel/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonDropDownField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final String? hinttext;
  final Color? fillcolor;
  final Color? bordercolor;
  final List values;
  final checkedvalue;
  final String listMapName;
  final String listMapId;
  final screenController;
  final flex;
  final readOnly;
  final doCallback;

  CommonDropDownField({
    required this.controller,
    required this.placeholder,
    required this.values,
    this.bordercolor,
    this.fillcolor,
    this.hinttext,
    this.checkedvalue,
    this.listMapName = 'name',
    this.listMapId = 'id',
    @required this.screenController,
    this.flex = 1,
    this.readOnly = false,
    this.doCallback,
  });

  @override
  Widget build(context) {
    TextEditingController terminalName = TextEditingController();
    if (readOnly) {
      values.forEach((list) {
        if (checkedvalue.text == list[listMapId])
          terminalName.text = list[listMapName];
      });
    }
    return readOnly == false
        ? Container(
            width: Get.width,
            // height: 60,
            child: InputDecorator(
              baseStyle: TextStyle(fontSize: 10),
              decoration: InputDecoration(
                hintText: placeholder,
                focusColor: Colors.black,
                hoverColor: Colors.black,
                filled: true,
                fillColor: fillcolor ?? Colors.transparent,
                hintStyle: const TextStyle(color: Color(0xff666666)),
                labelStyle: const TextStyle(color: Color(0xff666666)),
                errorStyle: TextStyle(color: Colors.red),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  dropdownColor: Colors.white,
                  icon: Icon(
                    Icons.arrow_drop_down_sharp,
                    size: 25.0,
                    color: Colors.black,
                  ),
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  value: checkedvalue.text != ''
                      ? checkedvalue.text
                      : values[0][listMapId].toString(),
                  isDense: true,
                  isExpanded: true,
                  items: values.map((list) {
                    return DropdownMenuItem(
                      child: list[listMapName] != ''
                          ? Text('${list[listMapName]}')
                          : Text('notfound'),
                      value: list[listMapId].toString(),
                    );
                  }).toList(),
                  onChanged: (value) {
                    print('Drowdown value Selected: ' + value.toString());
                    controller.text = value.toString();
                    if (screenController != null) {
                      screenController.update();
                    }
                    doCallback != null ? doCallback() : print('no callback');
                  },
                ),
              ),
            ),
          )
        : CommonTextFormField(
            terminalName,
            'Search by Email',
            'Search',
            false,
            TextInputType.name,
            1,
            (e) {}, (){}
          );
  }
}

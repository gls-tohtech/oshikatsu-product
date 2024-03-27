import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oshikatsu_product/widgets/verticalPadding.dart';

class TextFieldWidget extends StatelessWidget{
  final TextEditingController controller;
  final String formTitle;
  final TextInputType textInputType;
  final GlobalKey<FormState>? formKey;
  final RegExp validatePattern;

  TextFieldWidget({
    required this.controller,
    required this.formTitle,
    this.textInputType = TextInputType.none,
    this.formKey,
    RegExp? validatePattern,
 }) : this.validatePattern = validatePattern ?? RegExp(r'.*');

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return VerticalPaddingWidget(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "$formTitleを入力",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            key: formKey,
            controller: controller,
            maxLines: null,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 8.0
              ),
              border: OutlineInputBorder(),
            ),
            keyboardType: textInputType,
            validator: (value) {
                if (value == null || value.isEmpty) return "$formTitleを入力";
                // ignore: curly_braces_in_flow_control_structures
                if (!validatePattern.hasMatch(value)) return '適切な$formTitleを入力してください。';
                else return null;
            },
          )
        ],
      )
    );
  }
}

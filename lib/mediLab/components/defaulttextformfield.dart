import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  DefaultTextFormField(
      {super.key,
      required this.hint,
      required this.pIcon,
      this.type,
      required this.val,
      required this.controller});

  String hint;
  Widget pIcon;
  TextInputType? type = TextInputType.text;
  bool val;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black, fontSize: 18.5),
      controller: controller,
      keyboardType: type,
      obscureText: val,
      decoration: InputDecoration(
          prefixIconConstraints: const BoxConstraints(minWidth: 45),
          prefixIcon: pIcon,
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black, fontSize: 14.5),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
                  .copyWith(bottomRight: const Radius.circular(0)),
              borderSide: const BorderSide(color: Colors.redAccent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
                  .copyWith(bottomRight: const Radius.circular(0)),
              borderSide: const BorderSide(color: Colors.redAccent))),
    );
  }
}

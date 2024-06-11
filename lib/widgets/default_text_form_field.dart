// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField({
    Key? key,
    required this.controller,
    required this.keyboardType,
    this.enabled = true,
    this.onTap,
    required this.onChanged,
    this.readOnly = false,
  }) : super(key: key);
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool enabled;
  final Function()? onTap;
  final Function(String) onChanged;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 94, 94, 94),
          ),
        ),
      ),
      controller: controller,
      keyboardType: keyboardType,
      onTap: onTap,
      onChanged: onChanged,
      readOnly: readOnly,
    );
  }
}

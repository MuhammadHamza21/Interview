// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField({
    super.key,
    required this.controller,
    required this.keyboardType,
    this.enabled = true,
    this.onTap,
    required this.onChanged,
    this.readOnly = false,
  });
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
          borderRadius: BorderRadius.all(Radius.circular(15)),
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
          borderRadius: BorderRadius.all(Radius.circular(15)),
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

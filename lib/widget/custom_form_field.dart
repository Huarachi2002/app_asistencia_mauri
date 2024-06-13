import 'package:app_asistencia_docente/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final bool obscureText; 
  final String errorMessage;
  final Widget? icon;
  final String label;
  final String hint;
  final Color color;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  const CustomFormField({super.key, required this.errorMessage, this.onChanged, this.validator, required this.label, required this.hint, this.icon, required this.obscureText, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Material(
        color: color,
        child: 
        CustomTextFormField(
          obscureText: obscureText,
          icon: icon,
          label: label,
          hint: hint,
          errorMessage: errorMessage == '' ? null : errorMessage,
          onChanged: onChanged,
          validator:  validator,
        )
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSecret;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final bool readOnly;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final TextInputType textInputType;
  final GlobalKey<FormFieldState>? formFieldKey;

  const CustomTextField(
      {Key? key,
      required this.icon,
      required this.label,
      this.isSecret = false,
      this.inputFormatters,
      this.initialValue,
      this.readOnly = false,
      this.validator,
      this.onSaved,
      this.controller,
      this.textInputType = TextInputType.text,
      this.formFieldKey})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = false;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        key: widget.formFieldKey,
        controller: widget.controller,
        readOnly: widget.readOnly,
        //TODO valor a ser iniciado
        initialValue: widget.initialValue,
        inputFormatters: widget.inputFormatters,
        obscureText: isObscure,
        validator: widget.validator,
        onSaved: widget.onSaved,
        keyboardType: widget.textInputType,
        //TODO bordas circular para TextFormField
        decoration: InputDecoration(
            isDense: true,
            prefixIcon: Icon(widget.icon),
            suffixIcon: widget.isSecret
                ? IconButton(
                    icon: Icon(
                        isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                  )
                : null,
            labelText: widget.label,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(18))),
      ),
    );
  }
}

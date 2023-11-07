import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputFieldCustom extends StatefulWidget {
  final String title;
  final bool onlynumber;
  final TextEditingController controller;

  const InputFieldCustom(
      {required this.title, this.onlynumber = false, required this.controller});

  @override
  _InputFiledCustom createState() => _InputFiledCustom();
}

class _InputFiledCustom extends State<InputFieldCustom> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType:
          widget.onlynumber ? TextInputType.number : TextInputType.text,
      inputFormatters: <TextInputFormatter>[
        widget.onlynumber
            ? FilteringTextInputFormatter.digitsOnly
            : FilteringTextInputFormatter.singleLineFormatter
      ],
      controller: widget.controller,
      decoration: InputDecoration(
          labelText: widget.title, border: const OutlineInputBorder()),
    );
  }
}

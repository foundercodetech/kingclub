import 'package:mahajong/res/aap_colors.dart';
import 'package:flutter/material.dart';

class PinFieldWidget extends StatefulWidget {
  final int pinLength;
  final List<TextEditingController>? controllers;
  final VoidCallback? onSubmit;

  const PinFieldWidget({
    Key? key,
    this.pinLength = 4,
    this.controllers,
    this.onSubmit,
  }) : super(key: key);

  @override
  _PinFieldWidgetState createState() => _PinFieldWidgetState();
}

class _PinFieldWidgetState extends State<PinFieldWidget> {
  late List<FocusNode> _focusNodes;
  late List<String> _pinValues;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(widget.pinLength, (index) => FocusNode());
    _pinValues = List.generate(widget.pinLength, (index) => '');
  }

  @override
  void dispose() {
    for (int i = 0; i < widget.pinLength; i++) {
      _focusNodes[i].dispose();
    }
    super.dispose();
  }

  void _nextField(int index, String value) {
    if (index < widget.pinLength - 1) {
      _focusNodes[index].unfocus();
      _focusNodes[index + 1].requestFocus();
    } else if (index == widget.pinLength - 1) {
      _focusNodes[index].unfocus();
      _pinValues[index] = value;
      // Check if all fields are filled
      bool allFieldsFilled = _pinValues.every((value) => value.isNotEmpty);
      if (allFieldsFilled) {
        // Call onSubmit function
        widget.onSubmit!();
      }
    }
    setState(() {
      _pinValues[index] = value;
    });
  }

  void _previousField(int index) {
    if (index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.pinLength, (index) {
        return Container(
          width: 60,
          height: 60,
          margin: const EdgeInsets.all(5),
          child: TextField(
            controller: widget.controllers != null
                ? widget.controllers![index]
                : null,
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.number,
            maxLength: 1,
            obscureText: false,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              counterText: '',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black),
              ),
            ),
            onChanged: (value) {
              if (value.length == 1) {
                _nextField(index, value);
              } else {
                _previousField(index);
              }
            },
          ),
        );
      }),
    );
  }
}

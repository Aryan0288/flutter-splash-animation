import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CommonTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final TextInputType keyboardType;
  final bool isObscure;
  final Widget? prefix;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const CommonTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.labelText,
    this.keyboardType = TextInputType.text,
    this.isObscure = false,
    this.prefix,
    this.suffix,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  late bool _obscureText;
  bool _isFocused = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isObscure;
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color activeGreen = Color(0xFF388E2C);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
          color: _isFocused ? activeGreen : const Color(0xFF3A3A3C),
          width: _isFocused ? 1.5 : 1.0,
        ),
        boxShadow: _isFocused
            ? [
                BoxShadow(
                  color: activeGreen.withOpacity(0.12),
                  blurRadius: 8.0,
                  offset: const Offset(0, 2),
                )
              ]
            : null,
      ),
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        obscureText: _obscureText,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        validator: widget.validator,
        style: GoogleFonts.plusJakartaSans(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
        cursorColor: activeGreen,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: GoogleFonts.plusJakartaSans(
            color: const Color(0xFF7C7C80),
            fontSize: 15.0,
          ),
          labelText: widget.labelText,
          labelStyle: GoogleFonts.plusJakartaSans(
            color: _isFocused ? activeGreen : const Color(0xFF9E9E9E),
            fontSize: 14.0,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
          border: InputBorder.none,
          prefixIcon: widget.prefix != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                  child: widget.prefix,
                )
              : null,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 0,
            minHeight: 0,
          ),
          suffixIcon: widget.isObscure
              ? IconButton(
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    color: const Color(0xFF8E8E93),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : widget.suffix,
        ),
      ),
    );
  }
}

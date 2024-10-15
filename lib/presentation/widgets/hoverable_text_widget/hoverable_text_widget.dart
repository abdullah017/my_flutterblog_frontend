import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class HoverableText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final TextStyle hoverStyle;
  final VoidCallback onTap;

  const HoverableText({
    super.key,
    required this.text,
    required this.style,
    required this.hoverStyle,
    required this.onTap,
  });

  @override
  _HoverableTextState createState() => _HoverableTextState();
}

class _HoverableTextState extends State<HoverableText> {
  bool _isHovered = false;

  bool get _enableHover => kIsWeb; // Sadece webde hover efektini etkinleştir

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _enableHover
          ? (_) {
              setState(() {
                _isHovered = true;
              });
            }
          : null,
      onExit: _enableHover
          ? (_) {
              setState(() {
                _isHovered = false;
              });
            }
          : null,
      cursor: _isHovered ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.text,
          style: _isHovered ? widget.hoverStyle : widget.style,
        ),
      ),
    );
  }
}

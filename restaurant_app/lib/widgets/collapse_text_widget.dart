import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CollapseTextWidget extends StatefulWidget {
  const CollapseTextWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  State<CollapseTextWidget> createState() => _CollapseTextWidgetState();
}

class _CollapseTextWidgetState extends State<CollapseTextWidget> {
  int maxLines = 5;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          overflow: TextOverflow.ellipsis,
          maxLines: maxLines,
          textAlign: TextAlign.justify,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() => maxLines = maxLines == 5 ? 999 : 5);
          },
          child: Text(
            maxLines == 5 ? 'Read More' : 'Hide',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.blue.shade300,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}

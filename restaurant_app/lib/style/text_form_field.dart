import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

InputDecoration inputDecoration({required String hintText}) => InputDecoration(
      hintText: hintText,
      hintStyle: GoogleFonts.inter(
        color: Colors.blueGrey.shade100,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.blueGrey.shade100),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.blueGrey.shade100),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.blueGrey.shade200),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );

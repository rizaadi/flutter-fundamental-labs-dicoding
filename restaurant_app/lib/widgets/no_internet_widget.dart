// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class NoInternetWidget extends StatelessWidget {
  final void Function()? onPressed;
  const NoInternetWidget({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/animation_no_internet.json'),
          if (onPressed != null)
            FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                ),
                onPressed: onPressed,
                child: Text(
                  'Retry',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade800,
                  ),
                ))
        ],
      ),
    );
  }
}

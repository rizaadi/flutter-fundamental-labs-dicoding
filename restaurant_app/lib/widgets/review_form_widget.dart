import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/review_restaurant_form_model.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/style/text_form_field.dart';

class ReviewFormWidget extends StatefulWidget {
  final String id;
  const ReviewFormWidget({super.key, required this.id});

  @override
  State<ReviewFormWidget> createState() => _ReviewFormWidgetState();
}

class _ReviewFormWidgetState extends State<ReviewFormWidget> {
  final TextEditingController _nameC = TextEditingController();
  final TextEditingController _reviewC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameC.dispose();
    _reviewC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 14, right: 14, bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameC,
              maxLines: 1,
              validator: (value) =>
                  (value?.trim() ?? '').isEmpty ? 'Input Name' : null,
              decoration: inputDecoration(hintText: 'Name'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _reviewC,
              maxLines: 5,
              validator: (value) =>
                  (value?.trim() ?? '').isEmpty ? 'Input Review' : null,
              decoration: inputDecoration(hintText: 'Review'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
              child: Consumer<RestaurantProvider>(
                builder: (context, prov, _) {
                  bool isLoading = prov.reviewRestaurantState ==
                      ReviewRestaurantState.loading;
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade300,
                    ),
                    onPressed: isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              final form = ReviewRestaurantFormModel(
                                id: widget.id,
                                name: _nameC.text,
                                review: _reviewC.text,
                              );
                              final resReview =
                                  await prov.reviewRestaurant(form);

                              if (resReview.error ?? true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        duration: Duration(seconds: 3),
                                        content: Text(
                                            "Error, Cannot send a review")));
                              }
                              Navigator.pop(context);
                            }
                          },
                    child: isLoading
                        ? const CircularProgressIndicator(
                            strokeWidth: 3,
                          )
                        : Text(
                            'Submit',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

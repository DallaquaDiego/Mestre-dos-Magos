import 'package:flutter/material.dart';

import '../theme/custom_colors.dart';

class InformationField extends StatelessWidget {
  const InformationField({Key? key, required this.title, required this.information}) : super(key: key);

  final String title;
  final String information;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: CustomColors.dragon_blood.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: CustomColors.dragon_blood,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            information,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: CustomColors.dragon_blood,
            ),
          ),
        ],
      )
    );
  }
}

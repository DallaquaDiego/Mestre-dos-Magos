import 'package:flutter/material.dart';
import '../../../theme/custom_colors.dart';

class NavigationAlertDialog extends StatelessWidget {
  const NavigationAlertDialog({Key? key, required this.onConfirmPressed}) : super(key: key);

  final VoidCallback onConfirmPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Atenção!'),
      content: const Text('Se você mudar de página, perderá as modificações que ainda não foram salvas.'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Cancelar',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: onConfirmPressed,
          child: const Text(
            'Continuar',
            style: TextStyle(
              color: CustomColors.dragon_blood,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

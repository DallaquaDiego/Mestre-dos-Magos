import 'package:mestre_dos_magos/core/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';


class PageTile extends StatelessWidget {
  const PageTile({
    Key? key,
    required this.title,
    required this.iconData,
    required this.onTap,
    required this.highlighted,
  }) : super(key: key);

  final String title;
  final IconData iconData;
  final VoidCallback onTap;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: highlighted ? CustomColors.papyrus : null,
      titleTextStyle: const TextStyle(
        fontSize: 15,
        color: CustomColors.coconut,
        fontWeight: FontWeight.w600,
        fontFamily: 'Nunito',
      ),
      title: Text(title),
      trailing: Icon(
        highlighted ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
        size: 18,
        color: CustomColors.coconut,
      ),
      leading: Icon(
        iconData,
        color: CustomColors.coconut,
      ),
      onTap: onTap,
    );
  }
}

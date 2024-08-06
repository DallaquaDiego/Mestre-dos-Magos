import 'package:flutter/material.dart';
import '../../../theme/custom_colors.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CustomDrawerHeader extends StatefulWidget {
  const CustomDrawerHeader({
    Key? key,
    required this.name,
    required this.office,
    this.description,
  }) : super(key: key);

  final String name;
  final String office;
  final String? description;

  @override
  State<CustomDrawerHeader> createState() => _CustomDrawerHeaderState();
}

class _CustomDrawerHeaderState extends State<CustomDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 240,
      child: ResponsiveVisibility(
        child: _buildMobileHeader(),
        visible: false,
        visibleWhen: const [Condition.smallerThan(name: TABLET)],
        replacement: _buildDesktopHeader(),
      ),
    );
  }

  _buildMobileHeader() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: IconButton(
            icon: const Icon(
              Icons.close,
              size: 30,
              color: CustomColors.coconut,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'images/purple_octopus_logo.jpeg',
              height: 150,
            ),
            Text(
              widget.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Nunito',
                color: CustomColors.coconut,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Text(
              widget.office,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Nunito',
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            if (widget.description != null)
              Text(
                widget.description!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  color: Colors.redAccent.shade100,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
          ],
        ),
      ],
    );
  }

  _buildDesktopHeader() {
    return Center(
      child: Image.asset(
        'images/purple_octopus_logo.jpeg',
        height: 370,
      ),
    );
  }
}

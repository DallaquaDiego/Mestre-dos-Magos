import 'package:flutter/material.dart';
import '../../../theme/custom_colors.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CustomDrawerHeader extends StatefulWidget {
  const CustomDrawerHeader({
    Key? key,
    this.name,
    this.office,
    this.description,
  }) : super(key: key);

  final String? name;
  final String? office;
  final String? description;

  @override
  State<CustomDrawerHeader> createState() => _CustomDrawerHeaderState();
}

class _CustomDrawerHeaderState extends State<CustomDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'images/logo/purple_octopus_minimalist.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.name != null && widget.name != '')
                        Text(
                          widget.name!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            color: CustomColors.grape_juice,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      if (widget.office != null && widget.office != '')
                        Text(
                          widget.office!,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

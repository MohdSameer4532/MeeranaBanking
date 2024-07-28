import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool backButton;
  final BuildContext c;
  final String? title;
  final Color backgroundColor;

  const CustomAppBar({
    super.key,
    this.backButton = false,
    required this.c,
    this.title,
    required this.backgroundColor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: backButton,
      leading: backButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new,
                  color: Color.fromARGB(255, 0, 0, 0)),
              onPressed: () => Navigator.of(c).pop(),
            )
          : null,
      title: Text(
        title ?? '',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      centerTitle: true,
      backgroundColor: backgroundColor,
      elevation: 0,
    );
  }
}

import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool backButton;
  final BuildContext c;
  final String? title;
  final Color backgroundColor; // Add backgroundColor parameter

  CustomAppBar({
    super.key,
    this.backButton = false,
    required this.c,
    this.title,
    required this.backgroundColor, // Require backgroundColor parameter
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return widget.backButton
        ? AppBar(
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Navigator.of(widget.c).pop(); // Use Navigator to pop
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white, // Set the arrow color to white
              ),
            ),
            title: Text(
              widget.title ?? '',
              style: TextStyle(
                fontSize: 16, // Set the text size to 16
                fontWeight: FontWeight.normal, // Set the font weight to normal
                color: Colors.white, // Set the title text color to white
              ),
            ),
            backgroundColor: widget.backgroundColor, // Set the background color
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
          )
        : AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  // Define navigation logic here
                },
                child: const CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/profile.png'), // Placeholder
                ),
              ),
            ),
            title: GestureDetector(
              onTap: () {
                // Define navigation logic here
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User Name', // Placeholder
                    style: TextStyle(
                      fontSize: 16, // Set the text size to 16
                      fontWeight:
                          FontWeight.normal, // Set the font weight to normal
                      color: Colors.white, // Set the title text color to white
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white, // Set the menu icon color to white
                ),
                onPressed: () {
                  // Open end drawer
                },
              ),
            ],
            backgroundColor: widget.backgroundColor, // Set the background color
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
          );
  }
}

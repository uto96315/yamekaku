import 'package:flutter/material.dart';
import 'package:yamekaku/core/app_colors.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    this.backgroundColor = AppColors.primary,
    this.hasHeader = false,
    this.title = '',
    required this.body,
    super.key,
  });
  final bool hasHeader;
  final Color backgroundColor;
  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: hasHeader ? _header() : null,
      body: SafeArea(child: body),
    );
  }

  PreferredSizeWidget _header() {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: Text(
        'Yamekaku',
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w900,
          color: AppColors.textColor,
          letterSpacing: 0.5,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu, color: Colors.white, size: 28),
          tooltip: 'メニュー',
        ),
      ],
    );
  }
}

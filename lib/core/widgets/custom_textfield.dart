import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isWide = screenWidth >= 600;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 560),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: isWide ? 0 : 4),
        child: TextField(
          controller: controller,
          obscureText: isPassword,
          cursorColor: theme.colorScheme.primary,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              fontSize: 15,
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            suffixIcon:
                isPassword
                    ? Icon(
                      Icons.visibility_outlined,
                      color: theme.colorScheme.onSurfaceVariant,
                    )
                    : null,
            filled: true,
            fillColor: theme.cardColor,
            contentPadding: EdgeInsets.symmetric(
              vertical: isWide ? 18 : 16,
              horizontal: 18,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: theme.dividerColor, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
            ),
          ),
        ),
      ),
    );
  }
}

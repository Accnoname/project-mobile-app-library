import 'package:flutter/material.dart';
import 'package:library_management_app/common/helpers/extentions.dart';
import 'package:library_management_app/configs/themes/common.dart';
import 'package:library_management_app/configs/themes/gap.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class TextFieldApp extends StatelessWidget {
  const TextFieldApp({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.suffix,
    this.prefixIcon,
    this.fillColor,
    this.label,
    this.maxLines,
    this.isObscured = false,
    this.textInputType,
    this.validator,
    this.controller,
    this.initialValue,
    this.readOnly,
    this.maxWidth,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
    this.onTap,
    this.contentPadding,
    this.obscureText = false,
  });

  final String? hintText;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Color? fillColor;
  final Widget? label;
  final int? maxLines;
  final bool isObscured;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final String? initialValue;
  final bool? readOnly;
  final double? maxWidth;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final VoidCallback? onTap;
  final EdgeInsets? contentPadding;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final textTheme = context.theme.textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _applyTextStyle(context, label ?? const SizedBox()),
        if (label != null) Gap.smHeight,
        TextFormField(
          autofocus: false,
          obscureText: obscureText,
          onEditingComplete: onEditingComplete,
          onTapOutside: (PointerDownEvent event) {
            onEditingComplete?.call();
          },
          onTap: onTap,
          focusNode: focusNode,
          controller: controller,
          initialValue: initialValue,
          maxLines: maxLines ?? 1,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (validator != null) {
              return validator!(value);
            }
            return null;
          },
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor ?? colorScheme.surfaceVariant,
            border: OutlineInputBorder(
              borderRadius: radius12,
              borderSide: BorderSide(width: 1, color: colorScheme.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: radius12,
              borderSide: BorderSide(width: 1, color: colorScheme.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: radius12,
              borderSide: BorderSide(width: 1.5, color: colorScheme.primary),
            ),
            errorMaxLines: 2,
            contentPadding:
                contentPadding ??
                const EdgeInsets.symmetric(
                  vertical: Gap.lg,
                  horizontal: Gap.md,
                ),
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: Gap.md),
                    child: prefixIcon ?? SizedBox.shrink(),
                  )
                : null,
            prefix: prefixIcon == null ? Gap.smWidth : null,
            hintText: hintText,
            suffix: suffix == null && suffixIcon == null ? Gap.smWidth : null,
            suffixIcon: suffix == null && suffixIcon == null
                ? null
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: Gap.md),
                    child: suffix ?? suffixIcon ?? SizedBox.shrink(),
                  ),
            hintStyle: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            errorStyle: textTheme.labelSmall?.copyWith(
              fontStyle: FontStyle.italic,
              color: colorScheme.error,
            ),
          ),
          style: context.theme.textTheme.bodyMedium,
          keyboardType: textInputType,
          cursorColor: colorScheme.onPrimary,
          readOnly: readOnly ?? false,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _applyTextStyle(BuildContext context, Widget child) {
    if (child is Text) {
      return Text(
        child.data ?? '',
        textAlign: TextAlign.end,
        style: context.theme.textTheme.titleSmall,
      );
    }
    return child;
  }
}

@widgetbook.UseCase(
  name: 'Default',
  type: TextFieldApp,
  designLink: 'https://www.figma.com/file/your-file-id/your-node-id',
)
Widget buildTextFieldUseCase(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(16.0),
    child: TextFieldApp(
      label: Text('Sample Label'),
      hintText: 'Enter your text here...',
      prefixIcon: Icon(Icons.person),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Password',
  type: TextFieldApp,
  designLink: 'https://www.figma.com/file/your-file-id/your-node-id',
)
Widget buildPasswordFieldUseCase(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(16.0),
    child: TextFieldApp(
      label: Text('Password'),
      hintText: 'Enter your password',
      prefixIcon: Icon(Icons.lock),
      obscureText: true,
    ),
  );
}


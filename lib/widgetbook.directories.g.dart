// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:library_management_app/widgets/book_card.dart'
    as _library_management_app_widgets_book_card;
import 'package:library_management_app/widgets/stat_card.dart'
    as _library_management_app_widgets_stat_card;
import 'package:library_management_app/widgets/text_field_app.dart'
    as _library_management_app_widgets_text_field_app;
import 'package:widgetbook/widgetbook.dart' as _widgetbook;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookFolder(
    name: 'widgets',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'BookCard',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder:
                _library_management_app_widgets_book_card.buildBookCardUseCase,
            designLink: 'https://www.figma.com/file/your-file-id/your-node-id',
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'StatCard',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Primary Stat',
            builder:
                _library_management_app_widgets_stat_card.buildStatCardUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Warning Stat',
            builder: _library_management_app_widgets_stat_card
                .buildWarningStatUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'TextFieldApp',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder: _library_management_app_widgets_text_field_app
                .buildTextFieldUseCase,
            designLink: 'https://www.figma.com/file/your-file-id/your-node-id',
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Password',
            builder: _library_management_app_widgets_text_field_app
                .buildPasswordFieldUseCase,
            designLink: 'https://www.figma.com/file/your-file-id/your-node-id',
          ),
        ],
      ),
    ],
  ),
];

import 'package:flutter/material.dart';
import 'package:library_management_app/configs/themes/gap.dart';
import 'package:library_management_app/models/book_model.dart';
import 'package:library_management_app/widgets/book_card.dart';
import 'package:library_management_app/widgets/stat_card.dart';
import 'package:library_management_app/widgets/text_field_app.dart';

class DesignSystemScreen extends StatelessWidget {
  const DesignSystemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Design System Showcase'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Section(
            title: 'Typography',
            children: [
              _TypeRow(label: 'Display Large', style: theme.textTheme.displayLarge!),
              _TypeRow(label: 'Headline Medium', style: theme.textTheme.headlineMedium!),
              _TypeRow(label: 'Title Large', style: theme.textTheme.titleLarge!),
              _TypeRow(label: 'Body Large', style: theme.textTheme.bodyLarge!),
              _TypeRow(label: 'Label Small', style: theme.textTheme.labelSmall!),
            ],
          ),
          const Divider(),
          _Section(
            title: 'Colors',
            children: [
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _ColorBox(label: 'Primary', color: colorScheme.primary),
                  _ColorBox(label: 'Secondary', color: colorScheme.secondary),
                  _ColorBox(label: 'Tertiary', color: colorScheme.tertiary),
                  _ColorBox(label: 'Error', color: colorScheme.error),
                  _ColorBox(label: 'Surface', color: colorScheme.surface, border: true),
                ],
              ),
            ],
          ),
          const Divider(),
          _Section(
            title: 'Spacing (Gaps)',
            children: [
              _SpacingRow(label: 'XS (4.0)', size: Gap.xs),
              _SpacingRow(label: 'SM (8.0)', size: Gap.sm),
              _SpacingRow(label: 'MD (16.0)', size: Gap.md),
              _SpacingRow(label: 'LG (24.0)', size: Gap.lg),
              _SpacingRow(label: 'XL (32.0)', size: Gap.xl),
            ],
          ),
          const Divider(),
          _Section(
            title: 'Buttons',
            children: [
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  ElevatedButton(onPressed: () {}, child: const Text('Elevated')),
                  OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
                  TextButton(onPressed: () {}, child: const Text('Text Button')),
                  FloatingActionButton.small(
                    onPressed: () {},
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
          const Divider(),
          _Section(
            title: 'Input Fields',
            children: [
              const TextFieldApp(
                label: Text('Standard Input'),
                hintText: 'Enter something...',
                prefixIcon: Icon(Icons.edit),
              ),
              const SizedBox(height: 16),
              const TextFieldApp(
                label: Text('Password Input'),
                hintText: 'Enter password',
                prefixIcon: Icon(Icons.lock),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextFieldApp(
                label: const Text('Error State'),
                hintText: 'Invalid input',
                validator: (v) => 'This field is required',
                controller: TextEditingController(text: 'Wrong value'),
              ),
            ],
          ),
          const Divider(),
          _Section(
            title: 'Cards & Molecules',
            children: [
              const StatCard(
                title: 'Tổng số sách',
                value: '1,240',
                icon: Icons.menu_book_rounded,
                color: Color(0xFF3B5BDB),
                subtitle: '+12% tháng này',
              ),
              const SizedBox(height: 16),
              BookCard(
                book: BookModel(
                  id: 'demo',
                  title: 'Flutter Design Patterns',
                  author: 'Gemini CLI',
                  publisher: 'Google Press',
                  year: '2026',
                  imageUrl: '',
                  availableCount: 5,
                ),
                isDark: isDark,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _Section({required this.title, children}) : children = children ?? const [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.primary,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

class _TypeRow extends StatelessWidget {
  final String label;
  final TextStyle style;
  const _TypeRow({required this.label, required this.style});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          Text('The quick brown fox jumps over the lazy dog', style: style),
        ],
      ),
    );
  }
}

class _ColorBox extends StatelessWidget {
  final String label;
  final Color color;
  final bool border;
  const _ColorBox({required this.label, required this.color, this.border = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            border: border ? Border.all(color: Colors.grey.shade300) : null,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}

class _SpacingRow extends StatelessWidget {
  final String label;
  final double size;
  const _SpacingRow({required this.label, required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(width: 60, child: Text(label, style: const TextStyle(fontSize: 10))),
          Container(
            height: 20,
            width: size,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}

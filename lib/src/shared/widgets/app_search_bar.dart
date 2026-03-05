import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tech_gadol_task_app/src/app/theme/app_spacing.dart';

/// Search bar with built-in debounce. Calls [onChanged] after [debounceDuration]
/// of inactivity, preventing excessive API calls.
class AppSearchBar extends StatefulWidget {
  const AppSearchBar({
    required this.onChanged,
    this.hintText = 'Search products...',
    this.debounceDuration = const Duration(milliseconds: 500),
    super.key,
  });

  final ValueChanged<String> onChanged;
  final String hintText;
  final Duration debounceDuration;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(widget.debounceDuration, () {
      widget.onChanged(value.trim());
    });
  }

  void _clear() {
    _controller.clear();
    _debounce?.cancel();
    widget.onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: TextField(
        controller: _controller,
        onChanged: _onTextChanged,
        style: theme.textTheme.bodyMedium,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: Icon(
            Icons.search_rounded,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          suffixIcon: ListenableBuilder(
            listenable: _controller,
            builder: (context, _) {
              if (_controller.text.isEmpty) return const SizedBox.shrink();
              return IconButton(
                icon: Icon(
                  Icons.close_rounded,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                onPressed: _clear,
              );
            },
          ),
        ),
      ),
    );
  }
}

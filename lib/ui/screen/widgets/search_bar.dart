import 'package:flutter/material.dart';
import 'package:places/main.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';

class SearchBar extends StatefulWidget {
  const SearchBar(
      {super.key,
      required this.isEnabled,
      this.hideHistory,
      this.showHistory,
      required this.isFocused,
      this.searchRequest,
      this.initValue});
  final String? initValue;
  final bool isEnabled;
  final VoidCallback? hideHistory;
  final VoidCallback? showHistory;
  final Function(String)? searchRequest;
  final bool isFocused;
  @override
  State<SearchBar> createState() => SearchBarState();
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class SearchBarState extends State<SearchBar> {
  late TextEditingController? controller;
  late FocusNode focusNode;
  @override
  void initState() {
    focusNode = FocusNode();
    controller = TextEditingController();
    controller!.addListener(() {
      if (controller!.text.isNotEmpty) {
        widget.hideHistory!();
      } else if (controller!.text.isEmpty) {
        widget.showHistory!();
      }
      if (controller!.text.endsWith(' ')) {
        widget.searchRequest!(controller!.text);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    controller?.dispose();
    super.dispose();
  }

  void fillControllerWithValue(String str) {
    controller!.text = str;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      enableInteractiveSelection:
          widget.isEnabled ? true : false, // will disable paste operation
      focusNode: widget.isEnabled ? focusNode : AlwaysDisabledFocusNode(),
      enabled: widget.isEnabled ? true : false,
      onSubmitted: controller!.text == "" ? null : widget.searchRequest,
      autofocus: widget.isFocused ? true : false,
      controller: controller,
      cursorWidth: 1,
      cursorHeight: 24,
      cursorColor: themeProvider.appTheme.cursorColor,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon:
            const Icon(Icons.search_rounded, color: AppColors.inactiveBlack),
        suffix: InkWell(
          child: Icon(
            Icons.cancel,
            color: themeProvider.appTheme.badgeColors[0],
            size: 18,
          ),
          onTap: () {
            clear();
          },
        ),
        suffixIconColor: themeProvider.appTheme.filterButtonColor,
        fillColor: themeProvider.appTheme.cardColor,
        filled: true,
        label: const Text(AppStrings.search),
        labelStyle:
            AppTypography.formLabel.copyWith(color: AppColors.inactiveBlack),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(
            width: 0,
            color: Colors.transparent,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(
            width: 0,
            color: Colors.transparent,
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(
            width: 0,
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }

  void clear() {
    controller!.clear();
  }
}

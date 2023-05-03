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
  final Function(String, bool)? searchRequest;
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
    controller!.addListener(
      () {
        if (controller!.text.isNotEmpty) {
          widget.hideHistory!();
        } else if (controller!.text.isEmpty) {
          widget.showHistory!();
        }
        if (controller!.text.endsWith(' ')) {
          // В историю поиска добавляются только строки поиска по нажатию Enter
          widget.searchRequest!(controller!.text, false);
        }
      },
    );
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
    controller!.selection = TextSelection.collapsed(offset: str.length);
  }

  // В историю поиска добавляются только строки поиска по нажатию Enter
  void parseString(str) {
    widget.searchRequest!(str, true);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      enableInteractiveSelection:
          widget.isEnabled ? true : false, // will disable paste operation
      focusNode: widget.isEnabled ? focusNode : AlwaysDisabledFocusNode(),
      enabled: widget.isEnabled ? true : false,
      onSubmitted: controller!.text == "" ? null : parseString,
      autofocus: widget.isFocused ? true : false,
      controller: controller,
      cursorWidth: 1,
      cursorHeight: 24,
      cursorColor: themeInteractor.appTheme.cursorColor,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon:
            const Icon(Icons.search_rounded, color: AppColors.inactiveBlack),
        suffix: controller!.text == ""
            ? null
            : InkWell(
                child: Icon(
                  Icons.cancel,
                  color: themeInteractor.appTheme.badgeColors[0],
                  size: 18,
                ),
                onTap: () {
                  clear();
                },
              ),
        suffixIconColor: themeInteractor.appTheme.filterButtonColor,
        fillColor: themeInteractor.appTheme.cardColor,
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

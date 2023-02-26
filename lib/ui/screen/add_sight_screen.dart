import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/domain/sight.dart';
import 'package:places/main.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/ui/screen/categories_screen.dart';

// Екран Добавления нового места
class AddSightScreen extends StatefulWidget {
  const AddSightScreen({super.key});

  @override
  State<AddSightScreen> createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  late FocusNode fn1, fn2, fn3, fn4;
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  late TextEditingController? controller,
      nameController,
      widthController,
      heightController,
      descriptionController;
  Future<dynamic>? chosenCategory;
  bool _isButtonEnabled = false;
  bool _nameFieldFocused = false;
  bool _widthFieldFocused = false;
  bool _heightFieldFocused = false;
  bool _descriptionFieldFocused = false;

  void _clearAllFocusFlags() {
    _nameFieldFocused = false;
    _widthFieldFocused = false;
    _heightFieldFocused = false;
    _descriptionFieldFocused = false;
  }

  @override
  void initState() {
    controller = TextEditingController();
    nameController = TextEditingController();
    widthController = TextEditingController();
    heightController = TextEditingController();
    descriptionController = TextEditingController();
    fn1 = FocusNode();
    fn2 = FocusNode();
    fn3 = FocusNode();
    fn4 = FocusNode();
    fn1.addListener(() {
      _clearAllFocusFlags();
      if (fn1.hasFocus) {
        setState(() {
          _nameFieldFocused = true;
        });
      }
    });
    fn2.addListener(() {
      if (fn2.hasFocus) {
        setState(() {
          _widthFieldFocused = true;
        });
      }
    });

    fn3.addListener(() {
      if (fn3.hasFocus) {
        setState(() {
          _heightFieldFocused = true;
        });
      }
    });
    fn4.addListener(() {
      _clearAllFocusFlags();
      if (fn4.hasFocus) {
        setState(() {
          _descriptionFieldFocused = true;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    nameController?.dispose();
    widthController?.dispose();
    heightController?.dispose();
    descriptionController?.dispose();

    fn1.dispose();
    fn2.dispose();
    fn3.dispose();
    fn4.dispose();
    super.dispose();
  }

  // Перед отправкой формы все поля нужно заполнить
  void _checkEmptyFields() {
    if (controller?.text == '' ||
        nameController?.text == '' ||
        widthController?.text == '' ||
        widthController?.text == '' ||
        descriptionController?.text == '') {
      setState(() => _isButtonEnabled = false);
    } else {
      setState(() => _isButtonEnabled = true);
    }
  }

  String? _validateCoordinates(String? coordinate) {
    RegExp regex = RegExp(r'\d{1,3}.\d+'); // translates to 22.222222
    if (coordinate == null) {
      return 'We need the coordinate';
    } else if (!regex.hasMatch(coordinate)) {
      return "Sure?";
    } else {
      return null;
    }
  }

  // Поля не могут быть пустыми
  String? _validate(String? type) {
    if (type == "") {
      return '';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double heightVisible = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        elevation: 0,
        title: const Text(
          AppStrings.newPlace,
          style: AppTypography.subtitle,
        ),
        centerTitle: true,
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            AppStrings.cancel,
            style: AppTypography.simpleText
                .copyWith(color: themeProvider.appTheme.appLeading),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          // Получить возможность прокрутки, потому что клавиатура закрывает поля
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: _keyForm,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Text(
                          AppStrings.category.toUpperCase(),
                          style: AppTypography.superSmall.copyWith(
                              color:
                                  themeProvider.appTheme.addFormInactiveLabel),
                        ),
                      ),
                      _TypeFormField(
                          validate: _validate,
                          controller: controller,
                          onChanged: (string) {
                            _checkEmptyFields();
                          },
                          focusNode: fn1),
                      Padding(
                        padding: const EdgeInsets.only(top: 24, bottom: 12),
                        child: Text(
                          AppStrings.name.toUpperCase(),
                          style: AppTypography.superSmall.copyWith(
                              color:
                                  themeProvider.appTheme.addFormInactiveLabel),
                        ),
                      ),
                      TextFormField(
                        onTap: () => FocusScope.of(context).requestFocus(fn1),
                        focusNode: fn1,
                        controller: nameController,
                        validator: _validate,
                        onEditingComplete: () {
                          _checkEmptyFields();
                        },
                        onChanged: (value) {
                          FocusScope.of(context).requestFocus(fn1);
                        },
                        textCapitalization: TextCapitalization.sentences,
                        style: AppTypography.formLabel.copyWith(
                            color: themeProvider.appTheme.cursorColor),
                        cursorWidth: 1,
                        cursorHeight: 24,
                        cursorColor: themeProvider.appTheme.cursorColor,
                        decoration: _inputDecoration(
                            label: AppStrings.name,
                            clear: () => nameController?.clear(),
                            showSuffix: _nameFieldFocused),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 150,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Text(
                                      AppStrings.width.toUpperCase(),
                                      style: AppTypography.superSmall.copyWith(
                                          color: themeProvider
                                              .appTheme.addFormInactiveLabel),
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: TextFormField(
                                      textAlignVertical: TextAlignVertical.top,
                                      focusNode: fn2,
                                      controller: widthController,
                                      cursorWidth: 1,
                                      cursorHeight: 24,
                                      cursorColor:
                                          themeProvider.appTheme.cursorColor,
                                      onEditingComplete: () {
                                        _checkEmptyFields();
                                        fn2.unfocus();
                                        fn3.requestFocus();
                                      },
                                      onChanged: (value) {
                                        FocusScope.of(context)
                                            .requestFocus(fn2);
                                      },
                                      validator: _validateCoordinates,
                                      keyboardType: TextInputType.number,
                                      decoration: _inputDecoration(
                                          label: AppStrings.width,
                                          clear: () => widthController?.clear(),
                                          showSuffix: _widthFieldFocused),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                          RegExp('[0-9.]'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Text(
                                      AppStrings.height.toUpperCase(),
                                      style: AppTypography.superSmall.copyWith(
                                          color: themeProvider
                                              .appTheme.addFormInactiveLabel),
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: TextFormField(
                                      focusNode: fn3,
                                      controller: heightController,
                                      cursorWidth: 1,
                                      cursorHeight: 24,
                                      cursorColor:
                                          themeProvider.appTheme.cursorColor,
                                      onEditingComplete: () {
                                        _checkEmptyFields();
                                        fn3.unfocus();
                                        fn4.requestFocus();
                                      },
                                      onChanged: (value) {
                                        FocusScope.of(context)
                                            .requestFocus(fn3);
                                      },
                                      validator: _validateCoordinates,
                                      keyboardType: TextInputType.number,
                                      decoration: _inputDecoration(
                                          label: AppStrings.height,
                                          clear: () =>
                                              heightController?.clear(),
                                          showSuffix: _heightFieldFocused),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[0-9.]')),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: TextButton(
                          onPressed: () {
                            print("Put on map pressed");
                          },
                          child: Text(
                            AppStrings.putOnMap,
                            style: AppTypography.simpleText.copyWith(
                                color: themeProvider.appTheme.clearButtonColor),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 37.0),
                        child: Text(
                          AppStrings.description.toUpperCase(),
                          style: AppTypography.superSmall.copyWith(
                              color:
                                  themeProvider.appTheme.addFormInactiveLabel),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: TextFormField(
                          focusNode: fn4,
                          validator: _validate,
                          controller: descriptionController,
                          onEditingComplete: () {
                            _checkEmptyFields();
                            fn4.unfocus();
                          },
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          style: AppTypography.formLabel.copyWith(
                              color: themeProvider.appTheme.cursorColor),
                          cursorWidth: 1,
                          cursorHeight: 24,
                          cursorColor: themeProvider.appTheme.cursorColor,
                          minLines: 3,
                          maxLines: 8,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: _inputDecoration(
                              label: AppStrings.inputText,
                              clear: (() => descriptionController?.clear()),
                              showSuffix: _descriptionFieldFocused),
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                height: heightVisible > 0 ? 0 : height / 4,
              ), // Когда показана вирутальная клавиатура
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: OutlinedButton(
                  onPressed: _saveButtonOnTap,
                  style: OutlinedButton.styleFrom(
                    side:
                        const BorderSide(width: 0.0, color: Colors.transparent),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    backgroundColor: !_isButtonEnabled
                        ? themeProvider.appTheme.cardColor
                        : themeProvider.appTheme.routeButtonColor,
                    minimumSize: const Size(328, 48),
                    alignment: Alignment.center,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.create.toUpperCase(),
                        style: AppTypography.button.copyWith(
                            color: !_isButtonEnabled
                                ? themeProvider.appTheme.addFormInactiveLabel
                                : themeProvider.appTheme.addFormActiveLabel),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _saveButtonOnTap() {
    if (!_isButtonEnabled) {
    } else {
      if (_keyForm.currentState!.validate()) {
        Sight newItem = Sight(
          name: nameController!.text,
          details: descriptionController!.text,
          imagePath:
              'https://content.foto.my.mail.ru/mail/nordprod7/boxitogorsk/h-7455.jpg',
          lat: double.parse(widthController!.text),
          lon: double.parse(heightController!.text),
          type: '',
          workTime: '',
        );
        mocks.contains(newItem) ? null : mocks.add(newItem);

        Navigator.of(context).pop(true);
      }
    }
  }
}

// Общий InputDecoration для полей
InputDecoration _inputDecoration({
  required String label,
  required VoidCallback clear,
  required bool showSuffix,
}) {
  return InputDecoration(
    suffix: showSuffix
        ? InkWell(
            child: Icon(
              Icons.cancel,
              color: themeProvider.appTheme.badgeColors[0],
              size: 18,
            ),
            onTap: () {
              clear();
            },
          )
        : null,
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
      borderSide: BorderSide(
        width: 2,
        color: Colors.red.withOpacity(0.3),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
      borderSide: BorderSide(
        width: 2,
        color: Colors.red.withOpacity(0.3),
      ),
    ),
    isCollapsed: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
      borderSide:
          BorderSide(width: 2, color: themeProvider.appTheme.addFormBorder),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
      borderSide: BorderSide(color: themeProvider.appTheme.addFormBorder),
    ),
    labelText: label,
    labelStyle: AppTypography.formLabel
        .copyWith(color: themeProvider.appTheme.addFormInactiveLabel),
  );
}

// Филд типа места
class _TypeFormField extends StatelessWidget {
  final String? Function(String?)? validate;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  final FocusNode focusNode;
  const _TypeFormField({
    required this.validate,
    required this.controller,
    required this.onChanged,
    required this.focusNode,
  });

  @override
  build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => const CategoriesScreen(),
          ),
        )
            .then((value) {
          // Заполним Филд выбранным значением
          (value == null || value == '' || value == false)
              ? null
              : controller?.text = value as String;
          focusNode
              .requestFocus(); // После выбора типа фокус автоматически переходит на имя
        });
      },
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        enabled: false,
        validator: validate,
        textInputAction: TextInputAction.none,
        textCapitalization: TextCapitalization.sentences,
        style: AppTypography.formLabel
            .copyWith(color: themeProvider.appTheme.cursorColor),
        showCursor: false,
        decoration: InputDecoration(
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(
              width: 2,
              color: Colors.red.withOpacity(0.3),
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          suffixIcon: Icon(
            Icons.arrow_forward_ios_sharp,
            color: themeProvider.appTheme.cursorColor,
          ),
          isDense: true,
          border: const UnderlineInputBorder(),
          labelText: AppStrings.doesntChosen,
          labelStyle: AppTypography.formLabel
              .copyWith(color: AppColors.whiteSecondary2),
        ),
      ),
    );
  }
}

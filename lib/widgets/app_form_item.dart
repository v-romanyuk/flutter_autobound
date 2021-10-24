import 'package:Autobound/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppFormItem extends FormField<String> {
  AppFormItem({
    Key? key,
    this.controller,
    String? initialValue,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    bool obscureText = false,
    EdgeInsetsGeometry? padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
    bool autofocus = false,
    bool readOnly = false,
    ValueChanged<String>? onChanged,
    GestureTapCallback? onTap,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onFieldSubmitted,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    bool? enabled,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    String? placeholder,
  })  : assert(initialValue == null || controller == null),
        assert(autofocus != null),
        assert(readOnly != null),
        super(
          key: key,
          initialValue: controller?.text ?? initialValue ?? '',
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<String> field) {
            final _AppFormItemState state = field as _AppFormItemState;

            void onChangedHandler(String value) {
              field.didChange(value);
              if (onChanged != null) {
                onChanged(value);
              }
            }

            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 60,
              child: Stack(
                  children: [
                    CupertinoTextField(
                      controller: state._effectiveController,
                      focusNode: focusNode,
                      keyboardType: keyboardType,
                      textInputAction: textInputAction,
                      obscureText: obscureText,
                      clearButtonMode: OverlayVisibilityMode.editing,
                      decoration: BoxDecoration(
                          border: Border.all(color: field.errorText != null ? AppColors.danger : AppColors.border),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      padding: padding!,
                      onChanged: onChangedHandler,
                      onTap: onTap,
                      onEditingComplete: onEditingComplete,
                      onSubmitted: onFieldSubmitted,
                      enabled: enabled,
                      placeholder: placeholder,
                      placeholderStyle: const TextStyle(color: AppColors.greyDark),
                    ),
                      Positioned(
                        left: 2,
                        bottom: 0,
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: AnimatedOpacity(
                              duration: const Duration(seconds: 5),
                              opacity: 1,
                              child: Text(
                                field.errorText ?? '',
                                style: const TextStyle(
                                  color: CupertinoColors.destructiveRed,
                                  fontSize: 13
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ]),
            );
          },
        );

  // final Widget? prefix;
  final TextEditingController? controller;

  @override
  FormFieldState<String> createState() => _AppFormItemState();
}

class _AppFormItemState extends FormFieldState<String> {
  TextEditingController? _controller;

  TextEditingController? get _effectiveController => widget.controller ?? _controller;

  @override
  AppFormItem get widget => super.widget as AppFormItem;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    } else {
      widget.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(AppFormItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = TextEditingController.fromValue(oldWidget.controller!.value);
      }

      if (widget.controller != null) {
        setValue(widget.controller!.text);
        if (oldWidget.controller == null) {
          _controller = null;
        }
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (value != null && _effectiveController!.text != value) {
      _effectiveController!.text = value;
    }
  }

  @override
  void reset() {
    super.reset();

    if (widget.initialValue != null) {
      setState(() {
        _effectiveController!.text = widget.initialValue!;
      });
    }
  }

  void _handleControllerChanged() {
    if (_effectiveController!.text != value) {
      didChange(_effectiveController!.text);
    }
  }
}

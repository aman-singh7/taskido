import 'package:flutter/material.dart';
import 'package:task_dot_do/locator.dart';
import 'package:provider/provider.dart';
import 'package:task_dot_do/viewmodels/base_viewmodel.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  const BaseView({
    Key? key,
    required this.builder,
    this.onModelReady,
    this.onModelDestroy,
  }) : super(key: key);
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final void Function()? onModelReady;
  final void Function()? onModelDestroy;

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView> {
  T model = locator<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady!();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: model,
      child: Consumer<T>(
        builder: widget.builder,
      ),
    );
  }

  @override
  void dispose() {
    if (widget.onModelDestroy != null) {
      widget.onModelDestroy!();
    }
    super.dispose();
  }
}

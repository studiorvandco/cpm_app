import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RequestPlaceholder extends StatelessWidget {
  const RequestPlaceholder({super.key, required this.placeholder});

  final Widget placeholder;

  @override
  Widget build(BuildContext context) {
    return Center(child: placeholder);
  }
}

final RequestPlaceholder requestPlaceholderError = RequestPlaceholder(placeholder: Text('error.request_failed'.tr()));
const RequestPlaceholder requestPlaceholderLoading = RequestPlaceholder(placeholder: CircularProgressIndicator());

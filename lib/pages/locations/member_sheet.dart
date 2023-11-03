import 'package:cpm/common/placeholders/request_placeholder.dart';
import 'package:cpm/models/location/location.dart';
import 'package:cpm/models/member/member.dart';
import 'package:cpm/providers/locations/locations.dart';
import 'package:cpm/providers/members/members.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/extensions/string_validators.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LocationSheet extends ConsumerStatefulWidget {
  const LocationSheet({super.key});

  @override
  ConsumerState<LocationSheet> createState() => _MemberSheetState();
}

class _MemberSheetState extends ConsumerState<LocationSheet> with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController position = TextEditingController();

  @override
  void initState() {
    super.initState();

    final location = ref.read(currentLocationProvider).value;
    name.text = location?.name ?? '';
    position.text = location?.position ?? '';
  }

  String? _validatePhone(String? phone) {
    if (phone == null || phone.isEmpty && phone.isValidPhone) return null;

    return localizations.error_invalid_phone;
  }

  String? _validateEmail(String? email) {
    if (email == null || email.isEmpty || email.isValidEmail) return null;

    return localizations.error_invalid_email;
  }

  void _onSubmitted(Location location) {
    if (name.text == location.name &&
        position.text == location.position &&
        !formKey.currentState!.validate()) return;

    _edit(location);
  }

  void _edit(Location location) {
    location.name = name.text;
    location.position = position.text;

    ref.read(locationsProvider.notifier).edit(location);
    ref.read(currentLocationProvider.notifier).set(location);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 2 / 3,
      child: SingleChildScrollView(
        child: Padding(
          padding: Paddings.custom.drawer,
          child: ref.watch(currentLocationProvider).when(
            data: (location) {
              return Form(
                key: formKey,
                child: Column(
                  children: [
                    Focus(
                      onFocusChange: (hasFocus) => !hasFocus ? _onSubmitted(location) : null,
                      child: TextFormField(
                        controller: name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration.collapsed(
                          hintText: localizations.dialog_field_name,
                        ),
                        onFieldSubmitted: (_) => _onSubmitted(location),
                      ),
                    ),
                    Padding(padding: Paddings.padding8.vertical),
                    Focus(
                      onFocusChange: (hasFocus) => !hasFocus ? _onSubmitted(location) : null,
                      child: TextFormField(
                        controller: position,
                        decoration: InputDecoration.collapsed(
                          hintText: localizations.dialog_field_position,
                        ),
                        onFieldSubmitted: (_) => _onSubmitted(location),
                      ),
                    ),
                  ],
                ),
              );
            },
            error: (Object error, StackTrace stackTrace) {
              return requestPlaceholderError;
            },
            loading: () {
              return requestPlaceholderLoading;
            },
          ),
        ),
      ),
    );
  }
}

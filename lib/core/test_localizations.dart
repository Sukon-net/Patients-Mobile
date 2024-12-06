import 'package:clients/core/utils/extensions/context_extension.dart';
import 'package:clients/core/widgets/primary_filled_button.dart';
import 'package:clients/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TestingWidget extends StatelessWidget {
  const TestingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(context.tr(LocaleKeys.hello)),
          TextButton(
            onPressed: context.switchLanguage,
            child: Text(context.tr(LocaleKeys.switch_locale)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: PrimaryFilledButton(
              text: 'Test',
              isActive: true,
              onClick: () {},
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

extension Messages on BuildContext {
  void messageSuccess({
    required String title,
    required String message,
  }) {
    final materialBanner = MaterialBanner(
      elevation: 0,
      backgroundColor: Colors.transparent,
      forceActionsBelow: true,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: ContentType.success,
        inMaterialBanner: true,
      ),
      actions: const [
        SizedBox.shrink(),
      ],
    );

    ScaffoldMessenger.of(this)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(materialBanner);
  }

  void messageError({
    required String title,
    required String message,
  }) {
    final materialBanner = MaterialBanner(
      elevation: 0,
      backgroundColor: Colors.transparent,
      forceActionsBelow: true,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: ContentType.failure,
        inMaterialBanner: true,
      ),
      actions: const [
        SizedBox.shrink(),
      ],
    );

    ScaffoldMessenger.of(this)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(materialBanner);
  }

  void messageWarning({
    required String title,
    required String message,
  }) {
    final materialBanner = MaterialBanner(
      elevation: 0,
      backgroundColor: Colors.transparent,
      forceActionsBelow: true,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: ContentType.warning,
        inMaterialBanner: true,
      ),
      actions: const [
        SizedBox.shrink(),
      ],
    );

    ScaffoldMessenger.of(this)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(materialBanner);
  }
}

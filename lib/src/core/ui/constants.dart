import 'dart:ui';

sealed class ColorsConstants {
  static const brown = Color(0xffB08B01);
  static const grey = Color(0xff999999);
  static const greyLight = Color(0xffE6E2E9);
  static const red = Color(0xffEB1212);
}

sealed class FontConstants {
  static const fontFamilyPoppins = 'Poppins';
}

sealed class ImageConstants {
  static const String imageLogo = 'assets/images/imgLogo.png';
  static const String backgroundChair =
      'assets/images/background_image_chair.jpg';
  static const String avatar = 'assets/images/avatar.png';
}

sealed class DescriptionKeysConstants {
  static const String dioAuthKey = 'DIO_AUTH_KEY';
}

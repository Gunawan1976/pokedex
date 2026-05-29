// ignore_for_file: constant_identifier_names

import 'package:flutter/services.dart';

class Constant {
  static const MethodChannel methodChannel = MethodChannel('custom_keyboard_channel');
  static const MethodChannel signatureMethodChannel = MethodChannel('signature_channel');

  //BASE URL PROD
  static const String BASE_URL = 'https://dummyjson.com/';

  static const String APP_STATE_ONBOARDING_KEY = "APP_STATE_ONBOARDING";
  static const String APP_STATE_USER_CREDENTIAL_KEY = 'APP_STATE_USER_CREDENTIAL';
  static const String APP_STATE_USER_DEVICE_TOKEN_KEY = 'APP_STATE_USER_DEVICE_TOKEN';

  static const appMaincolor = "#00A2B9";

}
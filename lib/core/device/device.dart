import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  final String name;
  final String systemName;
  final String systemVersion;
  final String model;
  final String localizedModel;
  final bool isPhysicalDevice;

  DeviceInfo({
    required this.name,
    required this.systemName,
    required this.systemVersion,
    required this.model,
    required this.localizedModel,
    required this.isPhysicalDevice,
  });

  static Future<DeviceInfo?> init() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      return DeviceInfo(
        name: iosInfo.name,
        systemName: iosInfo.systemName,
        systemVersion: iosInfo.systemVersion,
        model: iosInfo.model,
        localizedModel: iosInfo.localizedModel,
        isPhysicalDevice: iosInfo.isPhysicalDevice,
      );
    } else if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      return DeviceInfo(
        name: androidInfo.model,
        systemName: "Android",
        systemVersion: androidInfo.version.release,
        model: androidInfo.model,
        localizedModel: androidInfo.device,
        isPhysicalDevice: androidInfo.isPhysicalDevice,
      );
    }
    return null;
  }
}

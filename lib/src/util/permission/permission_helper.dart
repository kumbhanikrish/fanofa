import 'dart:io';

import 'package:core/core.dart';
import 'package:fanofa/src/common/alerts.dart';
import 'package:fanofa/src/l10n/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../packages/components/components.dart';
import 'permission_dialog.dart';

class PermissionHelper {
  final BuildContext _context;
  final Permission _permission;
  final String permissionName;
  final IconData icon;
  final String description;

  PermissionHelper({
    required BuildContext context,
    required Permission permission,
    required this.permissionName,
    required this.icon,
    required this.description,
  })  : _context = context,
        _permission = permission;

  /*factory PermissionHelper.camera(BuildContext context) {
    return PermissionHelper(
      context: context,
      permission: Permission.camera,
      icon: Icons.camera_alt_outlined,
      description: S.current.descCameraPermission,
      permissionName: S.current.permissionCamera,
    );
  }

  factory PermissionHelper.photos(BuildContext context) {
    return PermissionHelper(
      context: context,
      permission: Permission.photos,
      icon: Icons.photo_library_outlined,
      description: S.current.descPhotosPermission,
      permissionName: S.current.permissionPhotos,
    );
  }*/

  Future<bool> get hasPermission => _permission.isGranted;

  Future<bool> requestPermission() async {
    bool? isContinue = await showPermissionDialog(
      context: _context,
      title: permissionName,
      description: description,
      icon: icon,
    );
    if (isContinue != true) return false;
    var result = await _permission.request();
    if (result.isGranted || result.isLimited) return true;
    if (result.isPermanentlyDenied || result.isPermanentlyDenied) {
      onPermissionDenied();
    }
    return false;
  }

  Future<bool> checkPermission() async {
    var status = await _permission.status;
    if (status.isGranted || (Platform.isIOS && status.isLimited)) return true;
    if (status.isPermanentlyDenied || status.isPermanentlyDenied) {
      onPermissionDenied();
      return false;
    }
    return requestPermission();
  }

  factory PermissionHelper.notification(BuildContext context) {
    return PermissionHelper(
      context: context,
      permission: Permission.notification,
      icon: Icons.notifications_outlined,
      description: 'We will keep you updated with latest updates and send your account information timely through the push notifications.',
      permissionName: 'Notification',
    );
  }

  void onPermissionDenied() {
    showAppDialog(
      context: _context,
      title: S.current.titlePermissionDenied,
      content: S.current.descPermissionDenied(permissionName),
      positiveButton: ModalButton(
        label: S.current.btnGoToSettings,
        onPressed: () => _context.navigator.pop(openAppSettings()),
      ),
      negativeButton: ModalButton(label: S.current.btnCancel, onPressed: null),
    );
  }
}

import 'package:component_gallery/app/app_provider.dart';
import 'package:device_frame/device_frame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileFrameWidget extends StatelessWidget {
  const MobileFrameWidget({
    Key? key,
    required this.title,
    required this.height,
    required this.widget,
  }) : super(key: key);

  final String title;
  final double height;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
      height: height,
      child: DeviceFrame(
        device: Devices.android.pixel3,
        isFrameVisible: true,
        orientation: Orientation.portrait,
        screen: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(title),
          ),
          body: Container(
            padding: EdgeInsets.all(16),
            child: Center(
              child: widget,
            ),
          ),
        ),
      ),
    );
  }
}

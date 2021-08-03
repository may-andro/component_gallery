import 'package:component_gallery/app/component_gallery_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;

  runApp(
    ProviderScope(
      child: const ComponentGalleryApp(),
    ),
  );
}

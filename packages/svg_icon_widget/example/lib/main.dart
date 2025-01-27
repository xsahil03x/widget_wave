import 'package:flutter/material.dart';
import 'package:svg_icon_widget/svg_icon_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SVG Icon Showcase',
      theme: ThemeData(colorSchemeSeed: Colors.teal),
      home: const SvgIconShowcase(),
    );
  }
}

class SvgIconShowcase extends StatelessWidget {
  const SvgIconShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SVG Icon Showcase'),
        leading: IconButton(
          color: Colors.green,
          icon: const SvgIcon(MySvgIcons.back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            color: Colors.blue,
            icon: const SvgIcon(MySvgIcons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Simple SvgIcon with default styling
            const SvgIcon(MySvgIcons.heart),

            // Customized SvgIcon with size and color
            const SvgIcon(
              MySvgIcons.heart,
              size: 48.0,
              color: Colors.orange,
            ),

            // Icon button with SvgIcon
            IconButton(
              color: Colors.pink,
              icon: const SvgIcon(MySvgIcons.heart),
              onPressed: () {},
            ),

            // Outlined button with SvgIcon
            OutlinedButton.icon(
              label: const Text('Go Back'),
              icon: const SvgIcon(
                size: 24.0,
                MySvgIcons.back,
                color: Colors.purple,
              ),
              onPressed: () {},
            ),

            // Complex svg icons with multiple colors.
            ...[
              const SvgIcon(MySvgIcons.crab, size: 72.0),
              const SvgIcon(MySvgIcons.dinosaur, size: 72.0),
              const SvgIcon(MySvgIcons.rabbit, size: 72.0),
              const SvgIcon(MySvgIcons.raccoon, size: 72.0),
            ].map(
              (icon) => IconButton(
                icon: icon,
                color: Colors.teal,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const SvgIcon(
          MySvgIcons.heart,
          color: Colors.white,
        ),
      ),
    );
  }
}

/// Identifiers for the supported SVG icons.
///
/// Use with the [SvgIcon] class to show specific icons. Icons are
/// identified by their name as listed below, e.g. [MySvgIcons.reactionLol].
abstract final class MySvgIcons {
  // Regular svg icons.

  /// SVG icon named 'back'.
  static const SvgIconData back = SvgIconData('assets/ic_back.svg');

  /// SVG icon named 'heart'.
  static const SvgIconData heart = SvgIconData('assets/ic_heart.svg');

  /// SVG icon named 'settings'.
  static const SvgIconData settings = SvgIconData('assets/ic_settings.svg');

  // Complex svg icons with multiple colors.
  //
  // Note: We are using preserveColors: true in the SvgIconData to preserve the
  // original predefined colors of the icons.

  /// SVG icon named 'crab'.
  static const SvgIconData crab = SvgIconData(
    'assets/ic_crab.svg',
    preserveColors: true,
  );

  /// SVG icon named 'dinosaur'.
  static const SvgIconData dinosaur = SvgIconData(
    'assets/ic_dinosaur.svg',
    preserveColors: true,
  );

  /// SVG icon named 'rabbit'.
  static const SvgIconData rabbit = SvgIconData(
    'assets/ic_rabbit.svg',
    preserveColors: true,
  );

  /// SVG icon named 'raccoon'.
  static const SvgIconData raccoon = SvgIconData(
    'assets/ic_raccoon.svg',
    preserveColors: true,
  );
}

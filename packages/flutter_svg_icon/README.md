# Flutter SVG Icon

[![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.svg?v=102)](https://opensource.org/licenses/MIT)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/xsahil03x/widget_wave/blob/main/packages/flutter_svg_icon/LICENSE)
[![Dart CI](https://github.com/xsahil03x/widget_wave/workflows/widget_wave/badge.svg)](https://github.com/xsahil03x/widget_wave/actions)
[![Version](https://img.shields.io/pub/v/flutter_svg_icon.svg)](https://pub.dartlang.org/packages/flutter_svg_icon)

A Flutter package that provides a simple way to use SVG icons in your Flutter app. It wraps the
[flutter_svg](https://pub.dev/packages/flutter_svg) package to provide a more convenient way to use SVG icons.

**Show some ❤️ and star the repo to support the project**

<p>
  <img src="https://github.com/xsahil03x/widget_wave/blob/main/packages/flutter_svg_icon/assets/showcase.png" alt="A showcase of FlutterSvgIcon" height="400"/>
</p>

## Features

- 🎯 Easy to use API similar to Flutter's built-in Icon widget
- 🎨 Supports colorizing SVG icons
- 🎭 Respects IconTheme like built-in Icons
- 📏 Supports custom size

## Installation

Add the following to your  `pubspec.yaml`  and replace  `[version]`  with the latest version:

```yaml
dependencies:
  flutter_svg_icon: ^[version]
```

## Usage

To get started, import the package:

```dart
import 'package:flutter_svg_icon/flutter_svg_icon.dart';
```

Then, create the `SvgIconData` object with the SVG icon data:

```dart
const reactionLol = SvgIconData('assets/ic_reaction_lol.svg');
```

Finally, use the `SvgIcon` widget to display the SVG icon:

```dart
IconButton(
  icon: SvgIcon(reactionLol),
  onPressed: () {
    // Handle button press
  },
),
```

That's it! You can now use SVG icons in your Flutter app.

### Preserving Original Colors

By default, `SvgIcon` will colorize the SVG icon using the current `IconTheme` color. This is useful
for most cases where you want to use the same color as the surrounding icons. However, some SVGs have intentional color schemes that you may want to preserve.
For these cases, you can use the `preserveColors` property:

```dart
const reactionLol = SvgIconData(
  'assets/ic_reaction_lol.svg'
   preserveColors: true, // Preserve original colors
);
```

## License

[MIT License](LICENSE)

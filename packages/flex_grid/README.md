# FlexGrid

[![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.svg?v=102)](https://opensource.org/licenses/MIT)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/xsahil03x/widget_wave/blob/main/packages/flex_grid/LICENSE)
[![Dart CI](https://github.com/xsahil03x/widget_wave/workflows/widget_wave/badge.svg)](https://github.com/xsahil03x/widget_wave/actions)
[![Version](https://img.shields.io/pub/v/flex_grid.svg)](https://pub.dartlang.org/packages/flex_grid)

A Flutter package that provides a flexible grid widget that arranges its children based on a provided pattern.

**Show some ❤️ and star the repo to support the project**

<p>
  <img src="https://github.com/xsahil03x/widget_wave/blob/main/packages/flex_grid/assets/showcase.png?raw=true" alt="A showcase of FlexGrid" height="700"/>
</p>

## Features

- 🧩 Create grid layouts with flexible sizing for each cell
- 📐 Configure the grid with custom pattern matrix where each cell can have different flex values
- 📏 Customize row heights with run patterns
- 🔢 Option to limit the number of displayed children
- 💫 Show remaining items count with a customizable overlay
- 🔄 Reversible direction for either rows or columns as the primary direction

## Installation

Add the following to your `pubspec.yaml` and replace `[version]` with the latest version:

```yaml
dependencies:
  flex_grid: ^[version]
```

## Usage

To get started, import the package:

```dart
import 'package:flex_grid/flex_grid.dart';
```

### Basic grid with equal cells

```dart
FlexGrid(
  pattern: const [
    [1, 1],
    [1, 1],
  ],
  children: [
    Container(color: Colors.red),
    Container(color: Colors.blue),
    Container(color: Colors.green),
    Container(color: Colors.yellow),
  ],
)
```

### With cells of different sizes

```dart
FlexGrid(
  pattern: const [
    [2, 1], // First row: first cell is twice as wide as second cell
    [1, 3], // Second row: second cell is three times as wide as first cell
  ],
  children: [
    Container(color: Colors.red),    // 2/3 of first row width
    Container(color: Colors.blue),   // 1/3 of first row width
    Container(color: Colors.green),  // 1/4 of second row width
    Container(color: Colors.yellow), // 3/4 of second row width
  ],
)
```

### With custom row heights

```dart
FlexGrid(
  pattern: const [
    [1, 1],
    [1, 1],
  ],
  runPattern: const [3, 1], // First row has 3x height of second row
  children: [
    Container(color: Colors.red),
    Container(color: Colors.blue),
    Container(color: Colors.green),
    Container(color: Colors.yellow),
  ],
)
```

### With maximum children limit

```dart
FlexGrid(
  pattern: const [
    [1, 1],
    [1, 1],
    [1, 1],
  ],
  children: [
    Container(color: Colors.red),
    Container(color: Colors.blue),
    Container(color: Colors.green),
    Container(color: Colors.yellow),
    Container(color: Colors.purple),
    Container(color: Colors.orange),
  ],
  maxChildren: 4,
  overlayBuilder: (context, remaining) => Center(
    child: Text('+$remaining', style: TextStyle(color: Colors.white)),
  ),
)
```

## License

[MIT License](LICENSE)

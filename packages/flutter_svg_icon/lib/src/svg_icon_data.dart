import 'package:flutter/foundation.dart';

/// A description of an svg icon.
@immutable
class SvgIconData {
  /// Creates svg icon data.
  ///
  /// The [package] argument must be non-null when using svg that is
  /// included in a package. This is used when selecting the svg.
  const SvgIconData(
    this.path, {
    this.package,
    this.preserveColors = false,
    this.matchTextDirection = false,
  });

  /// The path of the svg icon, e.g. 'assets/icons/heart.svg'.
  final String path;

  /// The name of the package from which the svg asset is included.
  ///
  /// The name is used by the [SvgIcon] widget to obtain the svg icon from
  /// the appropriate asset.
  final String? package;

  /// Whether this icon should preserve its original predefined colors.
  ///
  /// The [SvgIcon] widget respects this value by preserving the original
  /// predefined color of the icon.
  ///
  /// Useful for SVGs with complex or intentional color schemes that should
  /// remain unchanged.
  final bool preserveColors;

  /// Whether this icon should be automatically mirrored in right-to-left
  /// environments.
  ///
  /// The [SvgIcon] widget respects this value by mirroring the icon when the
  /// [Directionality] is [TextDirection.rtl].
  final bool matchTextDirection;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is SvgIconData &&
        other.path == path &&
        other.package == package &&
        other.preserveColors == preserveColors &&
        other.matchTextDirection == matchTextDirection;
  }

  @override
  int get hashCode {
    return Object.hash(path, package, preserveColors, matchTextDirection);
  }

  @override
  String toString() => 'SvgIconData($path)';
}

/// [DiagnosticsProperty] that has an [SvgIconData] as value.
class SvgIconDataProperty extends DiagnosticsProperty<SvgIconData> {
  /// Create a diagnostics property for [SvgIconData].
  SvgIconDataProperty(
    String super.name,
    super.value, {
    super.ifNull,
    super.showName,
    super.style,
    super.level,
  });

  @override
  Map<String, Object?> toJsonMap(DiagnosticsSerializationDelegate delegate) {
    final json = super.toJsonMap(delegate);
    if (value case final iconData?) {
      json['valueProperties'] = <String, Object>{
        'path': iconData.path,
      };
    }
    return json;
  }
}

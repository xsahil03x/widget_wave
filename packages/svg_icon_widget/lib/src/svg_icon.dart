import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:svg_icon_widget/src/svg_icon_data.dart';

/// A icon widget drawn from a provided SVG asset described in an [SvgIconData].
///
/// There must be an ambient [Directionality] widget when using [SvgIcon].
/// Typically this is introduced automatically by the [WidgetsApp] or
/// [MaterialApp].
///
/// This widget assumes that the rendered icon is squared. Non-squared icons may
/// render incorrectly.
///
/// See also:
///
///  * [IconButton], for interactive icons.
///  * [IconTheme], which provides ambient configuration for icons.
class SvgIcon extends StatelessWidget {
  /// Creates a svg icon widget.
  const SvgIcon(
    this.icon, {
    super.key,
    this.size,
    this.color,
    this.textDirection,
    this.applyTextScaling,
    this.semanticLabel,
  });

  /// The icon to display.
  ///
  /// The icon can be null, in which case the widget will render as an empty
  /// space of the specified [size].
  final SvgIconData? icon;

  /// The size of the icon in logical pixels.
  ///
  /// Icons occupy a square with width and height equal to size.
  ///
  /// Defaults to the nearest [IconTheme]'s [IconThemeData.size].
  ///
  /// If this [SvgIcon] is being placed inside an [IconButton], then use
  /// [IconButton.iconSize] instead, so that the [IconButton] can make the
  /// splash area the appropriate size as well. The [IconButton] uses an
  /// [IconTheme] to pass down the size to the [Icon].
  final double? size;

  /// The color to use when drawing the icon.
  ///
  /// Defaults to the nearest [IconTheme]'s [IconThemeData.color].
  ///
  /// The color (whether specified explicitly here or obtained from the
  /// [IconTheme]) will be further adjusted by the nearest [IconTheme]'s
  /// [IconThemeData.opacity].
  ///
  /// {@tool snippet}
  /// Typically, a Material Design color will be used, as follows:
  ///
  /// ```dart
  /// SvgIcon(
  ///   SvgIcons.heart,
  ///   color: Colors.blue.shade400,
  /// )
  /// ```
  /// {@end-tool}
  final Color? color;

  /// The text direction to use for rendering the icon.
  ///
  /// If this is null, the ambient [Directionality] is used instead.
  ///
  /// Some icons follow the reading direction. For example, "back" buttons point
  /// left in left-to-right environments and right in right-to-left
  /// environments. Such icons have their [SvgIconData.matchTextDirection] field
  /// set to true, and the [SvgIcon] widget uses the [textDirection] to
  /// determine the orientation in which to draw the icon.
  ///
  /// This property has no effect if the [icon]'s
  /// [SvgIconData.matchTextDirection] field is false, but for consistency a
  /// text direction value must always be specified, either directly using this
  /// property or using [Directionality].
  final TextDirection? textDirection;

  /// Whether to scale the size of this widget using the ambient [MediaQuery]'s
  /// [TextScaler].
  ///
  /// This is specially useful when you have an icon associated with a text, as
  /// scaling the text without scaling the icon would result in a confusing
  /// interface.
  ///
  /// Defaults to the nearest [IconTheme]'s
  /// [IconThemeData.applyTextScaling].
  final bool? applyTextScaling;

  /// Semantic label for the icon.
  ///
  /// Announced by assistive technologies (e.g TalkBack/VoiceOver).
  /// This label does not show in the UI.
  ///
  ///  * [SemanticsProperties.label], which is set to [semanticLabel] in the
  ///    underlying	 [Semantics] widget.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    assert(this.textDirection != null || debugCheckHasDirectionality(context));
    final textDirection = this.textDirection ?? Directionality.of(context);

    final theme = IconTheme.of(context);

    final tentativeIconSize = size ?? theme.size ?? kDefaultFontSize;
    final iconSize = switch (applyTextScaling ?? theme.applyTextScaling) {
      true => MediaQuery.textScalerOf(context).scale(tentativeIconSize),
      _ => tentativeIconSize,
    };

    final icon = this.icon;
    if (icon == null) {
      return Semantics(
        label: semanticLabel,
        child: SizedBox(width: iconSize, height: iconSize),
      );
    }

    final iconOpacity = theme.opacity ?? 1.0;
    var iconColor = color ?? theme.color;
    if (iconOpacity != 1.0) {
      // ignore: deprecated_member_use
      iconColor = iconColor?.withOpacity(iconColor.opacity * iconOpacity);
    }

    Widget iconWidget = SvgPicture.asset(
      icon.path,
      package: icon.package,
      width: iconSize,
      height: iconSize,
      clipBehavior: Clip.none, // Never clip.
      // Set the icon color if it's not null and the icon is not set to
      // preserve its color.
      colorFilter: switch ((icon.preserveColors, iconColor)) {
        (false, final color?) => ColorFilter.mode(color, BlendMode.srcIn),
        _ => null,
      },
    );

    if (icon.matchTextDirection) {
      iconWidget = switch (textDirection) {
        TextDirection.rtl => Transform(
            transform: Matrix4.identity()..scale(-1.0, 1, 1),
            alignment: Alignment.center,
            transformHitTests: false,
            child: iconWidget,
          ),
        TextDirection.ltr => iconWidget,
      };
    }

    return Semantics(
      label: semanticLabel,
      child: ExcludeSemantics(
        child: SizedBox(
          width: iconSize,
          height: iconSize,
          child: Center(
            child: iconWidget,
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final svgIconProperties = [
      SvgIconDataProperty('icon', icon, ifNull: '<empty>', showName: false),
      DoubleProperty('size', size, defaultValue: null),
      ColorProperty('color', color, defaultValue: null),
      StringProperty('semanticLabel', semanticLabel, defaultValue: null),
      EnumProperty('textDirection', textDirection, defaultValue: null),
      DiagnosticsProperty(
        'applyTextScaling',
        applyTextScaling,
        defaultValue: null,
      ),
    ];

    return svgIconProperties.forEach(properties.add);
  }
}

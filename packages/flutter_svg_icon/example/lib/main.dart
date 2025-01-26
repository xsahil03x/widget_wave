import 'package:flutter/material.dart';
import 'package:flutter_svg_icon/flutter_svg_icon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {},
              color: Colors.red,
              icon: SvgIcon(SvgIcons.reactionLol),
            ),
            IconButton(
              onPressed: () {},
              color: Colors.green,
              icon: SvgIcon(SvgIcons.reactionLove),
            ),
            IconButton(
              onPressed: () {},
              color: Colors.blue,
              icon: SvgIcon(SvgIcons.reactionThumbsDown),
            ),
            IconButton(
              onPressed: () {},
              color: Colors.orange,
              icon: SvgIcon(SvgIcons.reactionThumbsUp),
            ),
            IconButton(
              onPressed: () {},
              color: Colors.purple,
              icon: SvgIcon(SvgIcons.reactionWut),
            ),
          ],
        ),
      ),
    );
  }
}

/// Identifiers for the supported Stream SVG icons.
///
/// Use with the [SvgIcon] class to show specific icons. Icons are
/// identified by their name as listed below, e.g. [SvgIcons.reactionLol].
abstract final class SvgIcons {
  // Some simple SVG icons.

  /// SVG icon named 'reaction_lol'.
  static const SvgIconData reactionLol = SvgIconData(
    'assets/ic_reaction_lol.svg',
  );

  /// SVG icon named 'reaction_love'.
  static const SvgIconData reactionLove = SvgIconData(
    'assets/ic_reaction_love.svg',
  );

  /// SVG icon named 'reaction_thumbs_down'.
  static const SvgIconData reactionThumbsDown = SvgIconData(
    'assets/ic_reaction_thumbs_down.svg',
  );

  /// SVG icon named 'reaction_thumbs_up'.
  static const SvgIconData reactionThumbsUp = SvgIconData(
    'assets/ic_reaction_thumbs_up.svg',
  );

  /// SVG icon named 'reaction_wut'.
  static const SvgIconData reactionWut = SvgIconData(
    'assets/ic_reaction_wut.svg',
  );

  // Some complex SVG icons with predefined colors.
}

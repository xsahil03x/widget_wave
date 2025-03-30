import 'dart:async';
import 'dart:io';

import 'package:alchemist/alchemist.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  final runningOnCi = Platform.environment.containsKey('GITHUB_ACTIONS');

  return AlchemistConfig.runWithConfig(
    run: testMain,
    config: AlchemistConfig(
      platformGoldensConfig: PlatformGoldensConfig(
        enabled: !runningOnCi,
      ),
    ),
  );
}

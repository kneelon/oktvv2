import 'dart:math';

import 'package:oktvv2/presentation/utility/constants.dart';


String getDefaultUrl() {
  final List<String> stockUrls = [
    'https://www.youtube.com/watch?v=JEpZGccAZAk${AppStrings.cTime}',
    'https://www.youtube.com/watch?v=Qx68B1mHyGQ${AppStrings.cTime}',
    'https://www.youtube.com/watch?v=v7hRpilP2sg${AppStrings.cTime}',
    'https://www.youtube.com/watch?v=CHgI3_8k9wk${AppStrings.cTime}',
    'https://www.youtube.com/watch?v=8s_es7Hgnqo${AppStrings.cTime}',
    'https://www.youtube.com/watch?v=CA4S4oduut4${AppStrings.cTime}',
    'https://www.youtube.com/watch?v=C8twukz-0g0${AppStrings.cTime}',
    'https://www.youtube.com/watch?v=lCIVOFIZlO8${AppStrings.cTime}',
    'https://www.youtube.com/watch?v=VwuOa2F9jk4${AppStrings.cTime}',
    'https://www.youtube.com/watch?v=9nwGKSAfU1I${AppStrings.cTime}',
    'https://www.youtube.com/watch?v=lfkZmMSXqvE${AppStrings.cTime}',
    'https://www.youtube.com/watch?v=i-3aeVNQ6nc${AppStrings.cTime}',
  ];

  final random = Random();
  int randomIndex = random.nextInt(stockUrls.length);
  return stockUrls[randomIndex];

  // String _pickOneUrl() {
  //   final random = Random();
  //   int randomIndex = random.nextInt(stockUrls.length);
  //   return stockUrls[randomIndex];
  // }
}

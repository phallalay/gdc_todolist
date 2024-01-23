import 'package:flutter/cupertino.dart';
import 'package:gdc_todolist/pages/all_list.dart';
import 'package:gdc_todolist/pages/done_list.dart';

import '../pages/main_page.dart';

part 'app_routes.dart';

class AppPages {
  static final Map<String, Widget Function(BuildContext)> routes = {
    Routes.HOME_PAGE: (_) => MainPage(currentIndex: 0),
    Routes.ALL_LIST_PAGE: (_) => const AllListPage(),
    Routes.DONE_LIST_PAGE: (_) => const DoneListPage(),
  };
}

import 'package:flutter/material.dart';

import '../../schedule/view/schedule.dart';

import '../../managers/colors.dart';
import '../../managers/strings.dart';
import '../../managers/values.dart';

import '../../public_widgets/bar_bottom.dart';
import '../../public_widgets/bar_title.dart';

class BoardAppBar extends StatelessWidget {
  const BoardAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const BarTitle(title: StringsManager.board),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: DoubleManager.value20),
          child: IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(ScheduleScreen.routeName),
            icon: const Icon(
              Icons.calendar_today_sharp,
              color: ColorsManager.buttonColor,
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(DoubleManager.value50),
        child: BarBottomHelper(child: _tapBar),
      ),
    );
  }

//_________________________________Helper functions________________________________
  Widget get _tapBar {
    return const TabBar(
        indicatorColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        indicatorSize: TabBarIndicatorSize.label,
        labelPadding: EdgeInsets.symmetric(horizontal: DoubleManager.value15),
        isScrollable: true,
        tabs: [
          Tab(child: Text(StringsManager.all)),
          Tab(child: Text(StringsManager.completed)),
          Tab(child: Text(StringsManager.uncompleted)),
          Tab(child: Text(StringsManager.favorites)),
        ]);
  }
}

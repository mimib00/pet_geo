import 'package:flutter/material.dart';

import '../history.dart';

class AccrualOfBonuses extends StatelessWidget {
  const AccrualOfBonuses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HistoryTiles(
          title: 'Сегодня',
          subtitle: 'Приглашение друга',
        ),
        HistoryTiles(
          title: '17 апреля, сб',
          subtitle: 'Передержка',
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pet_geo/view/map/list_page_tabs/tabs/everything.dart';

class ListPageMain extends StatefulWidget {
  const ListPageMain({Key? key}) : super(key: key);

  @override
  State<ListPageMain> createState() => _ListPageMainState();
}

class _ListPageMainState extends State<ListPageMain> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Everything(),
    );
  }
}

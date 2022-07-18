import 'package:flutter/material.dart';

class NormalCard extends StatelessWidget {
  final String title;
  final Function ontap;
  const NormalCard({
    Key? key,
    required this.title,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          ontap();
        },
        child: ListTile(
          title: Text(title),
        ),
      ),
    );
  }
}

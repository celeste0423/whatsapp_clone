import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/extension/custom_theme_extension.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.title,
    required this.leading,
    this.subTitle,
    this.trailing,
  }) : super(key: key);

  final String title;
  final IconData leading;
  final String? subTitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      contentPadding: EdgeInsets.fromLTRB(25, 5, 10, 5),
      title: Text(title),
      subtitle: subTitle != null
          ? Text(
              subTitle!,
              style: TextStyle(
                color: context.theme.greyColor,
              ),
            )
          : null,
      leading: Icon(leading),
      trailing: trailing,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pokemon_app/utils/theme_colors.dart';
import 'package:pokemon_app/utils/theme_text.dart';

class Subtitle extends StatelessWidget {
  final String title;
  final Color color;
  Subtitle({@required this.title, this.color = ThemeColors.black100});

  @override
  Widget build(BuildContext context) {
    return Text('$title',
        style: ThemeText.proximaBody
            .copyWith(color: color, fontWeight: FontWeight.w600));
  }
}

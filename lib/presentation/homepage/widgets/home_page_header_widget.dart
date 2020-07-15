import 'package:flutter/material.dart';
import 'package:pokemon_app/utils/theme_colors.dart';
import 'package:pokemon_app/utils/theme_text.dart';

class HomePageHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
          child: Text('Pokedex', style: ThemeText.proximaTitle3),
        ),
        Text('Browse your favorites pokemon and find the details below',
            style: ThemeText.proximaBody.copyWith(color: ThemeColors.black80)),
        SizedBox(height: 20.0),
      ],
    );
  }
}

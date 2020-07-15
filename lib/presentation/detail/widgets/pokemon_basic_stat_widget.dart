import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pokemon_app/model/pokemon_detail_model.dart';
import 'package:pokemon_app/presentation/detail/widgets/subtitle.dart';
import 'package:pokemon_app/utils/theme_colors.dart';
import 'package:pokemon_app/utils/theme_text.dart';

const BASE_STAT_MAX = 250;

class PokemonBasicStatWidget extends StatelessWidget {
  final PaletteGenerator paletteGenerator;
  final PokemonDetailModel pokemonDetail;
  PokemonBasicStatWidget(
      {@required this.paletteGenerator, @required this.pokemonDetail});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Subtitle(
            title: 'BASIC STAT',
            color: paletteGenerator?.dominantColor?.color,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            padding: const EdgeInsets.only(top: 10.0),
            itemCount: pokemonDetail?.stats?.length ?? 0,
            itemBuilder: (context, index) {
              final item = pokemonDetail?.stats[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: RowLinearProgressWidget(
                  title: item?.stat?.name,
                  baseStat: item?.baseStat,
                  color: item.baseStat > 50 ? Colors.green : Colors.red,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class RowLinearProgressWidget extends StatelessWidget {
  final String title;
  final int baseStat;
  final Color color;
  RowLinearProgressWidget(
      {this.title, this.baseStat, this.color = Colors.green});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 120.0,
          child: Text(
            title.capitalize,
            style: ThemeText.proximaFootNote.copyWith(
                color: ThemeColors.black80, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          width: 40.0,
          child: Text('$baseStat',
              style:
                  ThemeText.proximaBody.copyWith(fontWeight: FontWeight.w600)),
        ),
        LinearPercentIndicator(
          width: 170.0,
          animation: true,
          lineHeight: 5.0,
          backgroundColor: ThemeColors.black20,
          percent: baseStat / BASE_STAT_MAX,
          progressColor: color,
        )
      ],
    );
  }
}

extension StringExtension on String {
  String get capitalize {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokemon_app/model/pokemon_detail_model.dart';
import 'package:pokemon_app/presentation/detail/widgets/subtitle.dart';
import 'package:pokemon_app/utils/theme_colors.dart';
import 'package:pokemon_app/utils/theme_text.dart';

class PokemonBasicInfoWidget extends StatelessWidget {
  final PaletteGenerator paletteGenerator;
  final PokemonDetailModel pokemonDetail;
  PokemonBasicInfoWidget(
      {@required this.paletteGenerator, @required this.pokemonDetail});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Subtitle(
            title: 'BASIC INFORMATION',
            color: paletteGenerator?.dominantColor?.color,
          ),
          SizedBox(height: 10.0),
          rowInformation(
              'Height', '${pokemonDetail?.height?.toMetersInHeight}m'),
          rowInformation(
              'Weight', '${pokemonDetail?.weight?.toKiloInWeight}kg'),
          rowInformation('Species', '${pokemonDetail?.species?.name}'),
        ],
      ),
    );
  }

  rowInformation(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 60.0,
            child: Text(
              title,
              style: ThemeText.proximaCaption
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(width: 20.0),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.left,
              style: ThemeText.proximaBody.copyWith(
                  color: ThemeColors.black80, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

extension on int {
  double get toMetersInHeight {
    return this / 10;
  }

  double get toKiloInWeight {
    return this / 10;
  }
}

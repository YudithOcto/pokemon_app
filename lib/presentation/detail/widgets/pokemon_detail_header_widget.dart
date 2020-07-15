import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokemon_app/components/custom_image_radius.dart';
import 'package:pokemon_app/model/pokemon_detail_model.dart';
import 'package:pokemon_app/utils/theme_colors.dart';
import 'package:pokemon_app/utils/theme_text.dart';

class PokemonDetailHeaderWidget extends StatelessWidget {
  final PaletteGenerator paletteGenerator;
  final PokemonDetailModel pokemonDetail;
  PokemonDetailHeaderWidget(
      {@required this.paletteGenerator, this.pokemonDetail});

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.35,
          width: double.maxFinite,
          color: paletteGenerator?.dominantColor?.color,
        ),
        Positioned(
          top: kToolbarHeight,
          left: 20.0,
          child: Icon(Icons.arrow_back,
              color: paletteGenerator?.dominantColor?.titleTextColor),
        ),
        Positioned(
          right: -40.0,
          top: kToolbarHeight,
          child: SvgPicture.asset(
            'images/pokeball_background.svg',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.2,
            color: ThemeColors.black0.withOpacity(0.1),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.1,
          left: MediaQuery.of(context).size.width * 0.1,
          right: 10.0,
          child: Row(
            children: <Widget>[
              Container(
                width: 150,
                height: 150,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CustomImageRadius(
                    imageUrl: pokemonDetail?.pokemonImage ?? '',
                  ),
                ),
              ),
              SizedBox(width: 15.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${pokemonDetail?.id?.pokemonId ?? ''}',
                      style: ThemeText.proximaBody.copyWith(
                          color:
                              paletteGenerator?.dominantColor?.titleTextColor),
                    ),
                    Text(
                      '${pokemonDetail?.name ?? ''}',
                      maxLines: 2,
                      style: ThemeText.proximaTitle1.copyWith(
                          color:
                              paletteGenerator?.dominantColor?.bodyTextColor),
                    ),
                    SizedBox(height: 5.0),
                    Row(
                        children: List.generate(pokemonDetail?.types?.length,
                            (index) {
                      return Container(
                          margin: EdgeInsets.only(left: index == 0 ? 0 : 5.0),
                          decoration: BoxDecoration(
                              color:
                                  paletteGenerator?.mutedColor?.bodyTextColor,
                              borderRadius: BorderRadius.circular(4.0)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 6.0),
                            child: Text(
                              '${pokemonDetail?.types[index]?.type?.name}',
                              style: ThemeText.proximaBody.copyWith(
                                  color: paletteGenerator?.mutedColor?.color,
                                  fontWeight: FontWeight.w600),
                            ),
                          ));
                    }))
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

extension on int {
  String get pokemonId {
    if (this == null) return '0';
    if (this > 99) {
      return '#$this';
    } else if (this > 9) {
      return '#0$this';
    } else {
      return '#00$this';
    }
  }
}

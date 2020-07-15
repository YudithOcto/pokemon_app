import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokemon_app/components/custom_image_radius.dart';
import 'package:pokemon_app/model/pokemon_form_response_model.dart';
import 'package:pokemon_app/presentation/detail/pokemon_detail_page.dart';
import 'package:pokemon_app/utils/theme_colors.dart';
import 'package:pokemon_app/utils/theme_text.dart';

class HomePageSinglePokemonContentWidget extends StatelessWidget {
  final PokemonFormResponseModel pokemonDetail;
  final PaletteGenerator paletteGenerator;

  HomePageSinglePokemonContentWidget(
      {this.pokemonDetail, this.paletteGenerator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(PokemonDetailPage.routeName, arguments: {
            PokemonDetailPage.paletteColor: paletteGenerator,
            PokemonDetailPage.pokemonDetailUrl: pokemonDetail.pokemonModel.url,
          });
        },
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Container(
              width: double.maxFinite,
              height: 100.0,
              decoration: BoxDecoration(
                color: paletteGenerator?.dominantColor?.color,
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            Positioned(
              right: 0.0,
              child: SvgPicture.asset(
                'images/pokeball_background.svg',
                fit: BoxFit.cover,
                height: 100.0,
                color: ThemeColors.black0.withOpacity(0.2),
              ),
            ),
            Positioned(
              right: 10.0,
              top: -20.0,
              child: Container(
                height: 100,
                width: 100,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CustomImageRadius(
                    imageUrl: pokemonDetail?.sprites?.frontDefault ?? '',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 20.0,
              top: 0.0,
              bottom: 0.0,
              child: Container(
                alignment: FractionalOffset.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(pokemonDetail?.name ?? '',
                        textAlign: TextAlign.center,
                        style: ThemeText.proximaHeadline.copyWith(
                            color: paletteGenerator
                                ?.dominantColor?.bodyTextColor)),
                    SizedBox(height: 5.0),
                    Container(
                      height: 5,
                      width: 80.0,
                      decoration: BoxDecoration(
                        color: paletteGenerator?.dominantColor?.titleTextColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

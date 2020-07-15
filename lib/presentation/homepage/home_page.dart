import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokemon_app/api/state.dart';
import 'package:pokemon_app/components/custom_image_radius.dart';
import 'package:pokemon_app/presentation/detail/pokemon_detail_page.dart';
import 'package:pokemon_app/presentation/homepage/providers/home_providers.dart';
import 'package:pokemon_app/utils/theme_colors.dart';
import 'package:pokemon_app/utils/theme_text.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'HomePage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isInit = true;
  final _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    if (_isInit) {
      loadData(isRefresh: true);
      _scrollController.addListener(_listener);
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  _listener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      loadData(isRefresh: false);
    }
  }

  loadData({bool isRefresh = true}) {
    Provider.of<HomeProviders>(context, listen: false)
        .getPokemonList(isRefresh: isRefresh);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20.0),
                Text('Pokedex', style: ThemeText.proximaTitle3),
                SizedBox(height: 5.0),
                Text('Browse your favorites pokemon and find the details below',
                    style: ThemeText.proximaBody
                        .copyWith(color: ThemeColors.black80)),
                SizedBox(height: 20.0),
                StreamBuilder<apiState>(
                    stream:
                        Provider.of<HomeProviders>(context).pokemonListStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        final provider = Provider.of<HomeProviders>(context);
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: provider.pokemonList.length + 1,
                          itemBuilder: (context, index) {
                            if (provider.pokemonList.isEmpty) {
                              return Container();
                            } else if (index < provider.pokemonList.length) {
                              final pokemon = provider.pokemonList[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        PokemonDetailPage.routeName,
                                        arguments: {
                                          PokemonDetailPage.paletteColor:
                                              provider.pokemonBackgroundColor[
                                                  index],
                                          PokemonDetailPage.pokemonDetailUrl:
                                              pokemon.pokemonModel.url,
                                        });
                                  },
                                  child: Stack(
                                    overflow: Overflow.visible,
                                    children: <Widget>[
                                      Container(
                                        width: double.maxFinite,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          color: provider
                                              .pokemonBackgroundColor[index]
                                              ?.dominantColor
                                              ?.color,
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0.0,
                                        child: SvgPicture.asset(
                                          'images/pokeball_background.svg',
                                          fit: BoxFit.cover,
                                          height: 100.0,
                                          color: ThemeColors.black0
                                              .withOpacity(0.2),
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
                                              imageUrl: pokemon
                                                      ?.sprites?.frontDefault ??
                                                  '',
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(pokemon?.name ?? '',
                                                  textAlign: TextAlign.center,
                                                  style: ThemeText
                                                      .proximaHeadline
                                                      .copyWith(
                                                          color: provider
                                                              .pokemonBackgroundColor[
                                                                  index]
                                                              ?.dominantColor
                                                              ?.bodyTextColor)),
                                              SizedBox(height: 5.0),
                                              Container(
                                                height: 5,
                                                width: 80.0,
                                                decoration: BoxDecoration(
                                                  color: provider
                                                      .pokemonBackgroundColor[
                                                          index]
                                                      ?.dominantColor
                                                      ?.titleTextColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
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
                            } else if (provider.canLoadMore) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              return Container();
                            }
                          },
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

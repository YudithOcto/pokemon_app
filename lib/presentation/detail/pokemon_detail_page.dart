import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokemon_app/model/pokemon_detail_model.dart';
import 'package:pokemon_app/presentation/detail/providers/pokemon_detail_provider.dart';
import 'package:pokemon_app/presentation/detail/widgets/pokemon_basic_info_widget.dart';
import 'package:pokemon_app/presentation/detail/widgets/pokemon_basic_stat_widget.dart';
import 'package:pokemon_app/presentation/detail/widgets/pokemon_detail_header_widget.dart';
import 'package:pokemon_app/presentation/shared_widgets/empty_widget.dart';
import 'package:provider/provider.dart';

class PokemonDetailPage extends StatefulWidget {
  static const routeName = 'PokemonDetailPage';
  static const paletteColor = 'PaletteColor';
  static const pokemonDetailUrl = 'PokemonDetailUrl';

  @override
  _PokemonDetailPageState createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  bool _isInit = true;
  PaletteGenerator _paletteGenerator;
  Future _getPokemonDetail;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      if (routeArgs != null) {
        _getPokemonDetail = Provider.of<PokemonDetailProvider>(context,
                listen: false)
            .getPokemonDetail(routeArgs[PokemonDetailPage.pokemonDetailUrl]);
        _paletteGenerator = routeArgs[PokemonDetailPage.paletteColor];
      }
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<PokemonDetailModel>(
          future: _getPokemonDetail,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData && snapshot.data.message == null) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      PokemonDetailHeaderWidget(
                        paletteGenerator: _paletteGenerator,
                        pokemonDetail: snapshot.data,
                      ),
                      PokemonBasicInfoWidget(
                        pokemonDetail: snapshot.data,
                        paletteGenerator: _paletteGenerator,
                      ),
                      PokemonBasicStatWidget(
                        pokemonDetail: snapshot.data,
                        paletteGenerator: _paletteGenerator,
                      ),
                    ],
                  ),
                );
              } else {
                return EmptyWidget(
                  onRetry: () {
                    final routeArgs = ModalRoute.of(context).settings.arguments
                        as Map<String, dynamic>;
                    if (routeArgs != null) {
                      _getPokemonDetail = Provider.of<PokemonDetailProvider>(
                              context,
                              listen: false)
                          .getPokemonDetail(
                              routeArgs[PokemonDetailPage.pokemonDetailUrl]);
                      setState(() {});
                    }
                  },
                );
              }
            }
          }),
    );
  }
}

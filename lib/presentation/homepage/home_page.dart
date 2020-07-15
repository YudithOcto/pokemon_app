import 'package:flutter/material.dart';
import 'package:pokemon_app/api/state.dart';
import 'package:pokemon_app/presentation/homepage/providers/home_providers.dart';
import 'package:pokemon_app/presentation/homepage/widgets/home_page_header_widget.dart';
import 'package:pokemon_app/presentation/homepage/widgets/home_page_single_pokemon_content_widget.dart';
import 'package:pokemon_app/presentation/shared_widgets/empty_widget.dart';
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
                HomePageHeaderWidget(),
                StreamBuilder<apiState>(
                    stream:
                        Provider.of<HomeProviders>(context).pokemonListStream,
                    builder: (context, snapshot) {
                      print(snapshot);
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          (Provider.of<HomeProviders>(context).offset < 1 &&
                              snapshot.data == apiState.loading)) {
                        return Container(
                          alignment: FractionalOffset.center,
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.3),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        final provider = Provider.of<HomeProviders>(context);
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: provider.pokemonList.length + 1,
                          itemBuilder: (context, index) {
                            if (snapshot.data == apiState.empty) {
                              return EmptyWidget(
                                onRetry: () {
                                  Provider.of<HomeProviders>(context,
                                          listen: false)
                                      .getPokemonList(isRefresh: true);
                                },
                              );
                            } else if (index < provider.pokemonList.length) {
                              final pokemon = provider.pokemonList[index];
                              return HomePageSinglePokemonContentWidget(
                                pokemonDetail: pokemon,
                                paletteGenerator:
                                    provider.pokemonBackgroundColor[index],
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

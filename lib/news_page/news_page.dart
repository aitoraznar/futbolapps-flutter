// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:futbolapps/app_config.dart';
import 'styles.dart';
import '../model/news_piece_model.dart';
import 'news_page_module.dart';
import 'newsDetailPage/news_detail_page.dart';

//TODO Duplicated declaration
const double _kAppBarHeight = 64.0;
const double _kRecipePageMaxWidth = 500.0;

//TODO Duplicated declaration
final ThemeData _kTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.red,
  accentColor: Colors.teal,
);

class PestoDemo extends StatelessWidget {
  const PestoDemo({ Key key }) : super(key: key);

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) => PestoHome();
}

class PestoHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const RecipeGridPage();
  }
}

// Displays a grid of recipe cards.
class RecipeGridPage extends StatefulWidget {
  const RecipeGridPage();

  @override
  _RecipeGridPageState createState() => _RecipeGridPageState();
}

class _RecipeGridPageState extends State<RecipeGridPage> {
  AppConfig config;
  ScrollController controller;
  NewsPageModule newsPageModule;
  List<NewsPiece> newsPieces = new List<NewsPiece>();
  int initialEmptyBoxes = 3;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      config = AppConfig.of(context);

      String teamName = 'athletic';
      newsPageModule = new NewsPageModule(config, teamName);
      newsPageModule.getInitialPage()
        .then((page) => {
          setState(() {
            newsPieces.addAll(page.newsPieces);
          })
        });
    });

    controller = new ScrollController()..addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    if (newsPieces != null && newsPieces.length == 0) {
      return Center(
        child: CircularProgressIndicator(),
      );

    } else {
      return Theme(
        data: _kTheme.copyWith(platform: Theme.of(context).platform),
        child: Scaffold(
          key: scaffoldKey,
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.edit),
            onPressed: () {
              scaffoldKey.currentState.showSnackBar(const SnackBar(
                content: Text('Not supported.'),
              ));
            },
          ),
          body: CustomScrollView(
            controller: controller,
            semanticChildCount: newsPieces.length,
            slivers: <Widget>[
              _buildAppBar(context, statusBarHeight),
              _buildBodyNews(context, statusBarHeight),
            ],
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  Widget _buildAppBar(BuildContext context, double statusBarHeight) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: _kAppBarHeight,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'Search',
          onPressed: () {
            scaffoldKey.currentState.showSnackBar(const SnackBar(
              content: Text('Not supported.'),
            ));
          },
        ),
      ],
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final Size size = constraints.biggest;
          final double appBarHeight = size.height - statusBarHeight;
          final double t = (appBarHeight - kToolbarHeight) / (_kAppBarHeight - kToolbarHeight);
          final double extraPadding = Tween<double>(begin: 10.0, end: 24.0).transform(t);
          final double logoHeight = appBarHeight - 1.5 * extraPadding;
          return Padding(
            padding: EdgeInsets.only(
              top: statusBarHeight,
            ),
            child: Center(
                child: PestoLogo(height: logoHeight, t: t.clamp(0.0, 1.0))
            ),
          );
        },
      ),
    );
  }

  Widget _buildBodyNews(BuildContext context, double statusBarHeight) {
    final EdgeInsets mediaPadding = MediaQuery.of(context).padding;
    final EdgeInsets padding = EdgeInsets.only(
        top: 8.0,
        left: 8.0 + mediaPadding.left,
        right: 8.0 + mediaPadding.right,
        bottom: 8.0
    );

    return SliverPadding(
      padding: padding,
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: _kRecipePageMaxWidth,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            final NewsPiece newsPiece = newsPieces[index];

            return NewsPieceCard(
              newsPiece: newsPiece,
              onTap: () {
                showNewsDetailPage(context, newsPiece);
              },
            );
          },
          childCount: newsPieces.length,
        ),
      ),
    );
  }

  void _scrollListener() {
    //print(controller.position.extentAfter);
    if (controller.position.extentAfter < 1000) {
      setState(() {
        newsPageModule.getNextPage().then((page) => {
        setState(() {
          newsPieces.addAll(page.newsPieces);
        })
        });
      });
    }
  }

  void showNewsDetailPage(BuildContext context, NewsPiece newsPiece) {
    Navigator.push(context, MaterialPageRoute<void>(
      settings: const RouteSettings(name: '/news/detail'),
      builder: (BuildContext context) {
        return Theme(
          data: _kTheme.copyWith(platform: Theme.of(context).platform),
          child: NewsDetailPage(newsPiece: newsPiece),
        );
      },
    ));
  }
}

class PestoLogo extends StatefulWidget {
  const PestoLogo({this.height, this.t});

  final double height;
  final double t;

  @override
  _PestoLogoState createState() => _PestoLogoState();
}

class _PestoLogoState extends State<PestoLogo> {
  // Native sizes for logo and its image/text components.
  static const double kLogoHeight = 81.0;
  static const double kLogoWidth = 330.0;
  static const double kImageHeight = 54.0;
  static const double kTextHeight = 24.0;
  final TextStyle titleStyle = const PestoStyle(fontSize: kTextHeight, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 3.0);
  final RectTween _textRectTween = RectTween(
      begin: Rect.fromLTWH(0.0, kTextHeight, 330.0, kTextHeight),
      end: Rect.fromLTWH(0.0, kTextHeight, 330.0, kTextHeight)
  );
  final Curve _textOpacity = const Interval(0.4, 1.0, curve: Curves.easeInOut);

  @override
  Widget build(BuildContext context) {
    AppConfig config = AppConfig.of(context);

    return Semantics(
      namesRoute: true,
      child: SizedBox(
        width: kLogoWidth,
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Positioned.fromRect(
              rect: _textRectTween.lerp(widget.t),
              child: Opacity(
                opacity: _textOpacity.transform(widget.t),
                child: Text(config.appName, style: titleStyle, textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsPieceCard extends StatelessWidget {
  const NewsPieceCard({ Key key, this.newsPiece, this.onTap }) : super(key: key);

  final NewsPiece newsPiece;
  final VoidCallback onTap;

  TextStyle get titleStyle => const PestoStyle(fontSize: 24.0, fontWeight: FontWeight.w600);
  TextStyle get authorStyle => const PestoStyle(fontWeight: FontWeight.w500, color: Colors.black54);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: newsPiece.slug,
              child: AspectRatio(
                aspectRatio: 4.0 / 3.0,
                child: Image.network(
                  newsPiece.imagen,
                  fit: BoxFit.cover,
                  semanticLabel: newsPiece.titulo,
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.network(
                      newsPiece.imagen,
                      semanticLabel: newsPiece.titulo,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(newsPiece.titulo, style: titleStyle, softWrap: false, overflow: TextOverflow.ellipsis),
                        Text(newsPiece.fuente, style: authorStyle),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
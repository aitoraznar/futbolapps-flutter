// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../styles.dart';
import '../../model/news_piece_model.dart';

//TODO Duplicated declaration
const double _kFabHalfSize = 28.0; // TODO(mpcomplete): needs to adapt to screen size
const double _kRecipePageMaxWidth = 500.0;

//TODO Duplicated declaration
final ThemeData _kTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.red,
  accentColor: Colors.teal,
);

// Displays one News piece. Includes the detail with a background image.
class NewsDetailPage extends StatefulWidget {
  const NewsDetailPage({ Key key, this.newsPiece }) : super(key: key);

  final NewsPiece newsPiece;

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}


class _NewsDetailPageState extends State<NewsDetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextStyle menuItemStyle = const PestoStyle(fontSize: 15.0, color: Colors.black54, height: 24.0/15.0);
  bool isFavorite = false;

  double _getAppBarHeight(BuildContext context) => MediaQuery.of(context).size.height * 0.3;

  @override
  Widget build(BuildContext context) {
    // The full page content with the recipe's image behind it. This
    // adjusts based on the size of the screen. If the recipe sheet touches
    // the edge of the screen, use a slightly different layout.
    final double appBarHeight = _getAppBarHeight(context);
    final Size screenSize = MediaQuery.of(context).size;
    final bool fullWidth = screenSize.width < _kRecipePageMaxWidth;
    //final bool isFavorite = _favoriteRecipes.contains(widget.recipe);

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            height: appBarHeight + _kFabHalfSize,
            child: Hero(
              tag: widget.newsPiece.slug,
              child: AspectRatio(
                aspectRatio: 4.0 / 3.0,
                child: Image.network(
                  widget.newsPiece.imagen,
                  fit: BoxFit.cover,
                  semanticLabel: widget.newsPiece.titulo,
                ),
              ),
            ),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: appBarHeight - _kFabHalfSize,
                backgroundColor: Colors.transparent,
                actions: <Widget>[
                  PopupMenuButton<String>(
                    onSelected: (String item) {},
                    itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                      _buildMenuItem(Icons.share, 'Share on Twitter'),
                      _buildMenuItem(Icons.people, 'Share on Facebook'),
                      _buildMenuItem(Icons.email, 'Send by Email'),
                      _buildMenuItem(Icons.message, 'Send by Message'),
                    ],
                  ),
                ],
                flexibleSpace: const FlexibleSpaceBar(
                  background: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, -1.0),
                        end: Alignment(0.0, -0.2),
                        colors: <Color>[Color(0x60000000), Color(0x00000000)],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(top: _kFabHalfSize),
                        width: fullWidth ? null : _kRecipePageMaxWidth,
                        child: NewsPieceBody(newsPiece: widget.newsPiece),
                      ),
                      Positioned(
                        right: 16.0,
                        child: FloatingActionButton(
                          child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                          onPressed: () => _toggleFavorite,
                        ),
                      ),
                    ],
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildMenuItem(IconData icon, String label) {
    return PopupMenuItem<String>(
      child: Row(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: Icon(icon, color: Colors.black54)
          ),
          Text(label, style: menuItemStyle),
        ],
      ),
    );
  }

  void _toggleFavorite() {
    //TODO Make it work
    setState(() {
      isFavorite = !isFavorite;
    });
  }
}

/// Displays the detail.
class NewsPieceBody extends StatelessWidget {
  NewsPieceBody({ Key key, this.newsPiece }) : super(key: key);

  final TextStyle titleStyle = const PestoStyle(fontSize: 24.0);
  final TextStyle descriptionStyle = const PestoStyle(fontSize: 15.0, color: Colors.black54, height: 24.0/15.0);
  final TextStyle itemStyle = const PestoStyle(fontSize: 15.0, height: 24.0/15.0);
  final TextStyle itemAmountStyle = PestoStyle(fontSize: 15.0, color: _kTheme.primaryColor, height: 24.0/15.0);
  final TextStyle headingStyle = const PestoStyle(fontSize: 16.0, fontWeight: FontWeight.bold, height: 24.0/15.0);

  final NewsPiece newsPiece;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        top: false,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
          child: Table(
            children: <TableRow>[
              TableRow(
                  children: <Widget>[
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Text(newsPiece.titulo, style: titleStyle)
                    ),
                  ]
              ),
              TableRow(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                        child: Text(newsPiece.descripcion, style: descriptionStyle)
                    ),
                  ]
              ),
            ],
          ),
        ),
      ),
    );
  }
}
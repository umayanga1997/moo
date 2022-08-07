import 'package:flutter/material.dart';
import 'package:moo/helper/colors.dart';
import 'package:moo/helper/fonts.dart';
import 'package:moo/models/movie_model.dart';
import 'package:moo/screens/mobile/movie_add_screen.dart';
import 'package:moo/screens/mobile/movie_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:moo/widgets/progressor.dart';

class MovieCard extends StatelessWidget {
  final String index;
  final MovieModel? movieModel;
  const MovieCard({
    Key? key,
    required this.index,
    required this.movieModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsScreen(
              index: index,
              movie: movieModel,
            ),
          ),
        );
      },
      splashColor: greenColorOpacity,
      focusColor: greenColorOpacity,
      highlightColor: greenColorOpacity,
      borderRadius: BorderRadius.circular(8),
      child: Hero(
        tag: index,
        child: Card(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    placeholder: (context, url) => const SizedBox(
                      height: 50,
                      child: Progressor(
                        width: 20,
                        height: 20,
                        strokeWidth: 2,
                      ),
                    ),
                    imageUrl: movieModel?.thumbnailURl ?? "",
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movieModel?.name ?? "",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1?.color,
                            fontSize:
                                Theme.of(context).textTheme.bodyText1?.fontSize,
                            letterSpacing: 0.4,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            movieModel?.description ?? "",
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText2?.color,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.fontSize,
                              // letterSpacing: 0.4,
                            ),
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          blurStyle: BlurStyle.solid,
                          color: greyColor1,
                          // spreadRadius: 1,
                        )
                      ]),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieAddScreen(
                            isUpdate: true,
                            movieModel: movieModel,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.history,
                    ),
                    splashRadius: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

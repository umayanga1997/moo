import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moo/helper/colors.dart';
import 'package:moo/helper/fonts.dart';
import 'package:moo/screens/mobile/movie_add_screen.dart';
import 'package:moo/screens/mobile/movie_details.dart';

class MovieCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String index;
  const MovieCard({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsScreen(
              image: image,
              index: index,
            ),
          ),
        );
      },
      splashColor: btnColorOpacity,
      focusColor: btnColorOpacity,
      highlightColor: btnColorOpacity,
      borderRadius: BorderRadius.circular(8),
      child: Hero(
        tag: index,
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/$image",
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
                          title,
                          style: TextStyle(
                            color: blColor,
                            fontSize: lf,
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
                            description,
                            style: TextStyle(
                              color: fcolorGrey,
                              fontSize: mf,
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
                  padding: const EdgeInsets.all(2),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          blurStyle: BlurStyle.solid,
                          color: fcolorGrey,
                          // spreadRadius: 1,
                        )
                      ]),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MovieAddScreen(
                            isUpdate: true,
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.history,
                      color: btnColor,
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

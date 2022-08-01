import 'package:flutter/material.dart';
import 'package:moo/helper/fonts.dart';
import 'package:moo/widgets/download_button.dart';
import 'package:moo/widgets/widget.dart';

class MovieDetailsScreen extends StatelessWidget {
  final String image;
  final String index;
  const MovieDetailsScreen({Key? key, required this.image, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: index,
      // transitionOnUserGestures: true,
      // flightShuttleBuilder: (flightContext, animation, flightDirection,
      //     fromHeroContext, toHeroContext) {
      //   return Transform(
      //     transform: Matrix4.identity()..rotateX(-pi * animation.value),
      //     alignment: FractionalOffset.center,
      //     child: fromHeroContext.widget,
      //   );
      // },
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/$image",
                width: double.infinity,
                fit: BoxFit.contain,
                alignment: Alignment.topCenter,
              ),
              const DetailCard(
                title: "Name of the movie",
                value: 'Chello Chello',
              ),
              const DetailCard(
                title: "Year of the movie",
                value: '2018',
              ),
              const DetailCard(
                title: "Language",
                value: 'English',
              ),
              const DetailCard(
                title: "Category",
                value: 'Horror',
              ),
              const DetailCard(
                title: "Director",
                value: 'Mr.Rahul',
              ),
              const DetailCard(
                title: "Actors",
                value: 'Srinath, pallawi, gowind',
              ),
              const DetailCard(
                title: "About the movie",
                value:
                    'This movie is very romance movie that giving the truth of message for our life.',
              ),
              const DownloadButton(),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 60,
                ),
                child: Center(
                  child: Text(
                    'Size of file\n 450MB',
                    style: TextStyle(
                      fontSize: mf,
                      color: Colors.grey,
                      decoration: TextDecoration.none,
                    ),
                    textAlign: TextAlign.center,
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

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moo/helper/colors.dart';
import 'package:moo/helper/fonts.dart';
import 'package:moo/helper/raw_data.dart';
import 'package:moo/services/firebase.dart';
import 'package:moo/widgets/widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              centerTitle: true,
              floating: false,
              pinned: true,
              collapsedHeight: 60,
              expandedHeight: 120,
              title: Image.asset(
                'assets/logos/Logo.png',
                height: 60,
                width: 60,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.medium,
                // alignment: Alignment.center,
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () => {},
                          icon: FaIcon(
                            FontAwesomeIcons.barsStaggered,
                            color: btnColor,
                          ),
                          splashRadius: 28,
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: btnColor,
                                  style: BorderStyle.solid,
                                  width: 0.5,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 8.0,
                                ),
                                child: Text(
                                  'Search...',
                                  style: TextStyle(
                                    fontSize: mf,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            // MdiIcons.lightbulbOn,
                            Icons.dark_mode,
                            color: btnColor,
                            size: 27,
                          ),
                          splashRadius: 28,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ];
        },
        body: Container(
          margin: const EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListData(
                  listTitle: "Categories",
                  padding: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  items: categories,
                  widgetType: WidgetType.circle,
                ),
                ListData(
                  listTitle: "Languages",
                  padding: const EdgeInsets.only(
                    bottom: 10,
                    // top: 10,
                  ),
                  items: languages,
                  widgetType: WidgetType.textbutton,
                ),
                StreamBuilder(
                  // stream: () {},
                  builder: (context, snapshot) {
                    return MasonryGridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      shrinkWrap: true,
                      itemCount: movies.length,
                      padding: const EdgeInsets.all(10),
                      physics: const NeverScrollableScrollPhysics(),
                      addAutomaticKeepAlives: true,
                      itemBuilder: (context, index) {
                        return MovieCard(
                          image: movies[index]["image"].toString(),
                          title: movies[index]["title"].toString(),
                          description:
                              " is a best of movie that the movie of your best and best",
                        );
                      },
                    );
                  },
                ),
                // GridView.builder(
                //   itemCount: movies.length,
                //   physics: const NeverScrollableScrollPhysics(),
                //   padding: const EdgeInsets.all(10),
                //   shrinkWrap: true,
                //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2,
                //     mainAxisSpacing: 5,
                //     crossAxisSpacing: 5,
                //     mainAxisExtent: 300,
                //   ),
                //   itemBuilder: (context, index) {
                //     return MovieCard(
                //       image: movies[index]["image"].toString(),
                //       title: movies[index]["title"].toString(),
                //     );
                //   },
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

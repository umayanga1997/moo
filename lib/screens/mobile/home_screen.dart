import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moo/controllers/category_controller.dart';
import 'package:moo/controllers/language_controller.dart';
import 'package:moo/controllers/search_controller.dart';
import 'package:moo/controllers/theme_controller.dart';
import 'package:moo/helper/colors.dart';
import 'package:moo/helper/fonts.dart';
import 'package:moo/helper/help_functions.dart';
import 'package:moo/helper/raw_data.dart';
import 'package:moo/models/movie_model.dart';
import 'package:moo/screens/mobile/movie_add_screen.dart';
import 'package:moo/services/firebase.dart';
import 'package:moo/widgets/widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _serachController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  static List<MovieModel> filterMovies(
      List<MovieModel> _movies, String cat, String lan) {
    if (cat != "al") {
      _movies = _movies.where((element) => element.category == cat).toList();
    }
    if (lan != "al") {
      _movies = _movies.where((element) => element.language == lan).toList();
    }
    return _movies;
  }

  static List<MovieModel> filterMoviesWithValue(
      List<MovieModel> _movies, String value) {
    _movies = _movies
        .where(
          (element) =>
              element.year!
                  .toString()
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||
              element.name!
                  .toString()
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||
              element.catName!
                  .toString()
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||
              element.lanName!
                  .toString()
                  .toLowerCase()
                  .contains(value.toLowerCase()),
        )
        .toList();

    return _movies;
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
                isDark(context)
                    ? 'assets/logos/Logo_white.png'
                    : 'assets/logos/Logo.png',
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
                          child: InputField(
                            textEditingController: _serachController,
                            padding: const EdgeInsets.all(0),
                            hintText: "Search...",
                            borderSide: BorderSide(
                              color: btnColor,
                              style: BorderStyle.solid,
                              width: 0.7,
                            ),
                            onChanged: (value) {
                              context
                                  .read<SearchController>()
                                  .changeSearchValue(value);
                            },
                          ),
                        ),
                        // Expanded(
                        //   child: GestureDetector(
                        //     onTap: () {},
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(8.0),
                        //         border: Border.all(
                        //           color: btnColor,
                        //           style: BorderStyle.solid,
                        //           width: 0.5,
                        //         ),
                        //       ),
                        //       child: Padding(
                        //         padding: const EdgeInsets.symmetric(
                        //           vertical: 10.0,
                        //           horizontal: 8.0,
                        //         ),
                        //         child: Text(
                        //           'Search...',
                        //           style: TextStyle(
                        //             fontSize: mf,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(width: 10.0),
                        IconButton(
                          onPressed: () {
                            context.read<ThemeController>().changeTheme();
                          },
                          icon: Icon(
                            // MdiIcons.lightbulbOn,
                            context.watch<ThemeController>().isDark
                                ? Icons.light_mode
                                : Icons.dark_mode,
                            color: btnColor,
                            size: 27,
                          ),
                          splashRadius: 28,
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MovieAddScreen(
                                  movieModel: null,
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.add,
                            color: btnColor,
                            size: 27,
                          ),
                          splashRadius: 28,
                        ),
                        IconButton(
                          onPressed: () async {
                            await auth.signOut();
                            await googleSignIn.signOut();
                          },
                          icon: Icon(
                            Icons.logout,
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

                StreamBuilder<QuerySnapshot>(
                  stream: fireStore.collection('movies').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Progressor(
                        isCircular: false,
                        strokeWidth: 2,
                      );
                    } else if (!snapshot.hasData) {
                      return const Center(child: Text('Data not Found!'));
                    }

                    List<MovieModel>? snapData = snapshot.data!.docs
                        .map((e) => MovieModel.fromJson(e.data()))
                        .toList();

                    // With Filter
                    String cat =
                        context.watch<Categorycontroller>().catSearchKey;
                    String lan =
                        context.watch<LanguageController>().lanSearchKey;

                    snapData = filterMovies(snapData, cat, lan);

                    // With search value filter
                    String pureSearch =
                        context.watch<SearchController>().searchKey ?? "";
                    snapData = filterMoviesWithValue(snapData, pureSearch);

                    return snapData.isEmpty
                        ? Center(
                            heightFactor: 25,
                            child: Text(
                              'Data not found!',
                              style: TextStyle(
                                fontSize: lf,
                              ),
                            ),
                          )
                        : MasonryGridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            shrinkWrap: true,
                            itemCount: snapData.length,
                            padding: const EdgeInsets.all(10),
                            physics: const NeverScrollableScrollPhysics(),
                            addAutomaticKeepAlives: true,
                            itemBuilder: (context, index) {
                              return MovieCard(
                                index: index.toString(),
                                movieModel: snapData![index],
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

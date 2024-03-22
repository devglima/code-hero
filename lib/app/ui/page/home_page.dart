import 'package:codehero/app/domain/cubit/home_cubit.dart';
import 'package:codehero/app/domain/cubit/pagination_cubit.dart';
import 'package:codehero/app/ui/widget/hero_library_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit homeCubit;
  late PaginationCubit paginationCubit;
  @override
  void initState() {
    super.initState();

    homeCubit = Modular.get<HomeCubit>();
    paginationCubit = Modular.get<PaginationCubit>();
    homeCubit.fetchHeroes(limit: 4, offset: 0);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    TextEditingController _searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/marvel_logo.png",
          fit: BoxFit.fitHeight,
          height: 40,
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          bloc: homeCubit,
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HomeError) {
              return Center(
                child: Text(state.error),
              );
            } else if (state is HomeSuccess) {
              var heroes = state.heroes.data!.results!;

              return SizedBox(
                height: size.height,
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 12),
                      child: SizedBox(
                        height: 60,
                        width: size.width,
                        child: TextFormField(
                          controller: _searchController,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Search Hero',
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(36))),
                            prefixIcon: const Icon(Icons.person),
                            suffix: IconButton(
                              onPressed: () {
                                homeCubit.fetchHeroes(
                                    offset: paginationCubit.state,
                                    name: _searchController.text);
                              },
                              icon: const Icon(
                                Icons.search,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (heroes.isEmpty)
                      const Center(
                        child: Text(
                          "No hero found!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    if (heroes.isNotEmpty)
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: heroes.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.66,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              border:
                                  Border.all(width: 0.5, color: Colors.black),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(2.0),
                                    child: Image.network(
                                      "${heroes[index].thumbnail!.path!}.${heroes[index].thumbnail!.extension!}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  heroes[index].name!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                HeroLibraryWidget(
                                    icon: Icons.book,
                                    title: 'Comics',
                                    quantity:
                                        heroes[index].comics!.items!.length),
                                HeroLibraryWidget(
                                    icon: Icons.tv,
                                    title: 'Series',
                                    quantity:
                                        heroes[index].series!.items!.length),
                                HeroLibraryWidget(
                                    icon: Icons.apartment,
                                    title: 'Events',
                                    quantity:
                                        heroes[index].events!.items!.length),
                                HeroLibraryWidget(
                                    icon: Icons.book_online,
                                    title: 'Stories',
                                    quantity:
                                        heroes[index].stories!.items!.length),
                              ],
                            ),
                          );
                        },
                      ),
                    if (heroes.isNotEmpty)
                      BlocConsumer<PaginationCubit, int>(
                        listener: (context, paginationState) {
                          homeCubit.fetchHeroes(
                              offset: paginationState,
                              name: _searchController.text != ''
                                  ? _searchController.text
                                  : '');
                        },
                        bloc: paginationCubit,
                        builder: (context, paginationState) {
                          return Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_circle_left,
                                    size: 40,
                                    color: state.heroes.data!.offset! <=
                                                paginationState &&
                                            paginationState != 0
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                  onPressed: () {
                                    if (state.heroes.data!.offset! <=
                                            paginationState &&
                                        paginationState != 0) {
                                      paginationCubit.backPage();
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_circle_right,
                                    size: 40,
                                    color: state.heroes.data!.total! >
                                            paginationState
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                  onPressed: () {
                                    if (state.heroes.data!.total! >
                                        paginationState) {
                                      paginationCubit.nextPage();
                                    }
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      )
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

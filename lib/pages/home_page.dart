import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_wall_layout/flutter_wall_layout.dart';
import 'package:my_app/database/databaseoperation.dart';
import 'package:my_app/database/models/category_schema.dart';
import 'package:my_app/database/models/storedesign_schema.dart';
import 'package:my_app/pages/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Category> categories = [];
  List<StoreDesign> storeDesigns = [];
  @override
  void initState() {
    super.initState();
    loadCategories();
    loadStoreDesign();
  }

  Future<void> loadCategories() async {
    final List<Category> fetchedCategories = await getCategories();
    setState(() {
      categories = fetchedCategories;
    });
  }

  Future<void> loadStoreDesign() async {
    final List<StoreDesign> fetchedStoreDesign = await getStoreDesigns();
    setState(() {
      storeDesigns = fetchedStoreDesign;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        leadingWidth: 200.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Image.asset(
            'assets/images/companyLogo.png',
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              // Add your onTap logic here
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(
                'assets/images/burger_icon.svg',
                width: 24.0,
                height: 24.0,
              ),
            ),
          ),
        ],
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return SafeArea(
      child: categories.isEmpty || storeDesigns.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          "Category",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SvgPicture.asset("assets/images/forward_icon.svg")
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 20.0, bottom: 20.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: categories.map((category) {
                          return circularCategory(category);
                        }).toList(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          "Popular Store",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SvgPicture.asset("assets/images/forward_icon.svg")
                      ],
                    ),
                  ),
                  layout(storeDesigns),
                ],
              ),
            ),
    );
  }

  Widget circularCategory(Category category) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: <Widget>[
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(category.image), fit: BoxFit.cover)),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(category.name)
        ],
      ),
    );
  }

  String findCategoryImage(List<Category> categories, String categoryName) {
    try {
      Category category = categories.firstWhere(
          (category) => category.name == categoryName,
          orElse: () => Category(name: '', image: ''));
      return category.image;
    } catch (error) {
      return ''; // Or provide a default image URL
    }
  }

  Widget layout(List<StoreDesign> storeDesigns) {
    return WallLayout(
      stones: _buildStonesList(storeDesigns),
      layersCount: 2,
      scrollDirection: Axis.vertical,
      reverse: false,
    );
  }

  List<Stone> _buildStonesList(List<StoreDesign> storeDesigns) {
    return storeDesigns.map((storeInfo) {
      return Stone(
        id: storeDesigns.indexOf(storeInfo),
        width: storeInfo.width,
        height: storeInfo.height,
        child: __buildStoneChild(
          storeDesign: storeInfo,
          surface: (storeInfo.width * storeInfo.height).toDouble(),
        ),
      );
    }).toList();
  }

  Widget __buildStoneChild(
      {required StoreDesign storeDesign, required double surface}) {
    final String categoryImage =
        findCategoryImage(categories, storeDesign.category);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => DetailPage(
                    storeDesign: storeDesign, categoryImage: categoryImage)));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(storeDesign.mainDesignImage)),
          ),
        ),
      ),
    );
  }
}


  // SingleChildScrollView(
            //   scrollDirection: Axis.vertical,
            //   child: storeDesigns.isEmpty
            //       ? const CircularProgressIndicator()
            //       : Row(
            //           children: storeDesigns.map((storeDesign) {
            //             return store(storeDesign);
            //           }).toList(),
            //         ),
            // ),

  // Widget store(StoreDesign storeDesign) {
  //   final String categoryImage =
  //       findCategoryImage(categories, storeDesign.category);
  //   return InkWell(
  //       onTap: () {
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (_) => DetailPage(
  //                     storeDesign: storeDesign, categoryImage: categoryImage)));
  //       },
  //       child: Padding(
  //         padding: const EdgeInsets.all(5.0),
  //         child: Container(
  //           width: MediaQuery.of(context).size.width * 0.5,
  //           height: 150,
  //           decoration: BoxDecoration(
  //               image: DecorationImage(
  //                   image: NetworkImage(storeDesign.mainDesignImage))),
  //         ),
  //       ));
  // }
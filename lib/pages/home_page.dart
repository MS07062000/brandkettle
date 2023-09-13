import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leadingWidth: 200.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Image.asset(
            'assets/images/companyLogo.png',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Add your menu tap logic her
            },
          ),
        ],
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return SafeArea(
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: <Widget>[
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Top Categories",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: categories.isEmpty
                  ? const CircularProgressIndicator()
                  : Row(
                      children: categories.map((category) {
                        return circularCategory(category);
                      }).toList(),
                    ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  "Store Design",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SvgPicture.asset("assets/images/forward_icon.svg")
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: categories.isEmpty
                  ? const CircularProgressIndicator()
                  : Row(
                      children: storeDesigns.map((storeDesign) {
                        return store(storeDesign);
                      }).toList(),
                    ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget circularCategory(Category category) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(category.image), fit: BoxFit.cover)),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(category.name)
        ],
      ),
    );
  }

  Widget store(StoreDesign storeDesign) {
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
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 150,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(storeDesign.mainDesignImage))),
          ),
        ));
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
}

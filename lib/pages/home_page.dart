import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/database/databaseoperation.dart';
import 'package:my_app/database/models/category_schema.dart';
import 'package:my_app/pages/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://images.unsplash.com/photo-1525879000488-bff3b1c387cf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text("Jean-Luis")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text("Phillinpe")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://images.unsplash.com/photo-1521572267360-ee0c2909d518?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text("Lesly Juarez")
                      ],
                    ),
                  )
                ],
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
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const DetailPage()));
              },
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/image_1.png"))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: (MediaQuery.of(context).size.width - 80) / 2,
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              image: AssetImage("assets/images/image_2.png"),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width - 80) / 2,
                      height: 230,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              image: AssetImage("assets/images/image_3.png"),
                              fit: BoxFit.cover)),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: <Widget>[
                    Container(
                      width: (MediaQuery.of(context).size.width - 80) / 2,
                      height: 230,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              image: AssetImage("assets/images/image_4.png"),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width - 80) / 2,
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              image: AssetImage("assets/images/image_5.png"),
                              fit: BoxFit.cover)),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    ));
  }

  Widget category(String categoryName, String categoryImage) {
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
                    image: NetworkImage(categoryImage), fit: BoxFit.cover)),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(categoryName)
        ],
      ),
    );
  }

  Widget store(String storeDesignImage) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const DetailPage()));
      },
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(storeDesignImage))),
      ),
    );
  }
}

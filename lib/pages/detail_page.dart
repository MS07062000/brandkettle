import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/database/models/storedesign_schema.dart';
import 'package:my_app/pages/contact_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailPage extends StatefulWidget {
  final StoreDesign storeDesign;
  final String categoryImage;
  const DetailPage(
      {super.key, required this.storeDesign, required this.categoryImage});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: getBody(),
      floatingActionButton: Container(
        padding: const EdgeInsets.only(left: 30.0),
        width: double.infinity,
        child: FloatingActionButton(
          shape:
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 10,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const ContactUsForm(submissionSuccessful: true),
              ),
            );
          },
          child: const Text(
            'Book a call',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: size.height * 0.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.storeDesign.mainDesignImage),
                  fit: BoxFit.cover),
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          padding:
                              const EdgeInsets.only(right: 10.0, bottom: 10.0),
                          child:
                              SvgPicture.asset("assets/images/back_icon.svg")),
                    ),
                    Row(
                      children: <Widget>[
                        SvgPicture.asset("assets/images/heart_icon.svg"),
                        const SizedBox(
                          width: 20,
                        ),
                        SvgPicture.asset("assets/images/share_icon.svg"),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.45),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    child: Container(
                      width: 150,
                      height: 7,
                      decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(widget.categoryImage),
                                fit: BoxFit.cover)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.storeDesign.category,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.storeDesign.description,
                    style: const TextStyle(height: 1.6),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Gallery",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: widget.storeDesign.gallery
                            .map((galleryImageURL) =>
                                galleryImageContainer(galleryImageURL))
                            .toList()),
                  ),
                  const SizedBox(
                    height: 55,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget galleryImageContainer(String galleryImageURL) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: CachedNetworkImageProvider(galleryImageURL),
                fit: BoxFit.cover)),
      ),
    );
  }
}

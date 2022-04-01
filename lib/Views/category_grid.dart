import 'package:flutter/material.dart';
import 'package:quotes/Modules/quote_category.dart';
import 'package:quotes/Views/category_details.dart';
import 'package:quotes/Modules/wp_api.dart';

class AllCategory extends StatefulWidget {
  @override
  _AllCategoryState createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
  //late List<QuoteCategory> _allCategoryItems;

  //@override
  // void initState() {
  //   _allCategoryItems = getAllCategories();
  //   super.initState();
  // }

  // var color;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: FutureBuilder<List>(
          future: fetchQuote(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: false,
                  itemCount: snapshot.data!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0),
                  itemBuilder: (BuildContext context, int index) {
                    Map wpquotes = snapshot.data![index];
                    var imageurl = wpquotes['x_featured_media'];

                    //Center(child: Text('Hi'));
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (Context) => CategoryDetails()));
                      },
                      child: Stack(children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              //  BoxShadow(color: Colors.black12, offset: Offset(0, 3))
                            ],
                            image: imageurl != null
                                ? DecorationImage(
                                    image: NetworkImage(imageurl),
                                    fit: BoxFit.cover,
                                  )
                                : DecorationImage(
                                    image: AssetImage(
                                        'assets/images/placeholder-image.png'),
                                    fit: BoxFit.cover),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(top: 90),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)),
                              gradient: LinearGradient(colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                              ], stops: [
                                0.0,
                                1
                              ], begin: Alignment.topRight),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 125.0, left: 20.0, right: 10.0),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              wpquotes['x_categories'],
                              style: TextStyle(
                                  //fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ]),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    ));
  }
}

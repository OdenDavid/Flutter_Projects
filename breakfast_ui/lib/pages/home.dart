import 'package:breakfast_ui/models/category_model.dart';
import 'package:breakfast_ui/models/diet_model.dart';
import 'package:breakfast_ui/models/popular_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<DietModel> diets = [];
  List<PopularModel> popularDiets = [];

  void _getAll() {
    categories = CategoryModel.getCategories();
    diets = DietModel.getDiets();
    popularDiets = PopularModel.getPopularDiets();
  }

  @override
  void initState() {
    _getAll();
  }

  @override
  Widget build(BuildContext context) {
    _getAll();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Breakfast',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
          ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xffF7F8F8),
            borderRadius: BorderRadius.circular(10)
          ),
          child: SvgPicture.asset(  
                'assets/icons/Arrow - Left 2.svg',
                height: 20,
                width: 20
                ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            decoration: BoxDecoration(
              color: const Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10)
            ),
            child: SvgPicture.asset(
              'assets/icons/dots.svg',
              height: 4,
              width: 4
              ),
          ),
        ]
      ),
      backgroundColor: Colors.white,
      body: ListView(

        children: [
          _searchField(),
          const SizedBox(height: 30,),
          _categorySection(),
          const SizedBox(height: 30,),
          _recommendSection(),
          const SizedBox(height: 20,),
          _popularSection(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Column _popularSection() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Popular',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                )
              ),
            ),
            const SizedBox(height: 15,),
            ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 20, right: 20),
              separatorBuilder: (context, index) => const SizedBox(height: 25),
              itemCount: popularDiets.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 115,
                  decoration: BoxDecoration(
                    color: popularDiets[index].boxIsSelected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: popularDiets[index].boxIsSelected ? [
                      BoxShadow(
                        color: const Color(0xff1D1617).withOpacity(0.07),
                        offset: const Offset(0,10),
                        blurRadius: 40,
                        spreadRadius: 0
                      )
                    ] : []
                  ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                      popularDiets[index].iconPath,
                      width: 65,
                      height: 65
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          popularDiets[index].name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                          )
                        ),
                        Text(
                          popularDiets[index].level +' | '+ popularDiets[index].duration +' | '+ popularDiets[index].calorie,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.black
                          )
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: (){},
                      child: SvgPicture.asset(
                        'assets/icons/button.svg',
                        width: 30,
                        height: 30, 
                      )
                  )
                  ]
                ),
                );
              },
            ),
          ],
        );
  }

  Column _recommendSection() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Diet Recommender",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                )
                ),
            ),
            const SizedBox(height: 15,),
            Container(
              padding: const EdgeInsets.only(left: 5),
              height: 240,
              color: Colors.white,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    width: 210,
                    decoration: BoxDecoration(
                      color: diets[index].boxColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(diets[index].iconPath),
                        Column(
                          children: [
                            Text(
                              diets[index].name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.black,
                              )
                            ),
                            Text(
                              diets[index].level +' | '+ diets[index].duration +' | '+ diets[index].calorie,
                              style: const TextStyle(
                                color: Color(0xff7B6F72),
                                fontSize: 13,
                                fontWeight: FontWeight.w400
                              )  
                            ),
                          ],
                        ),  
                        Container(
                          height: 45,
                          width: 130,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [diets[index].boxColor, Color(0xff92A3FD)]
                              ),
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child: const Center(
                            child: Text(
                              'View',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white
                              )
                            ),)
                        ),
                      ],
                    )
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 25),
                itemCount: diets.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20, right: 20)
              ),
            )
          ],
          );
  }

  Column _categorySection() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text('Category',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600
              )
              ),
            ),
            const SizedBox(height: 15,),
            Container(
              height: 120,
              color: Colors.white,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 25,),
                padding: const EdgeInsets.only(left: 20, right: 20),
                itemCount: categories.length,
                itemBuilder: (context, index){
                  return Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: categories[index].boxColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(categories[index].iconPath),
                          )
                        ),
                        Text(
                          categories[index].name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            color: Colors.black
                          )
                        )
                      ],
                    ),
                  );
                })
            ),
          ],
        );
  }

  Container _searchField() {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xff1D1617).withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search Me',
          hintStyle: const TextStyle(
            color: Color(0xffDDDADA),
            fontSize: 14
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(15),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(15),
            child: SvgPicture.asset('assets/icons/Search.svg'),
          ),
          suffixIcon: SizedBox(
            width: 100,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const VerticalDivider(
                    color: Color.fromARGB(255, 55, 50, 50),
                    thickness: 0.1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: SvgPicture.asset('assets/icons/Filter.svg'),
                  ),
                ],
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          )
        ),
      ),
    );
  }

}
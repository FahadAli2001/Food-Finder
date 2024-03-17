import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodfinder/const/images.dart';

class CustomSavedItemsContainer extends StatelessWidget {
  const CustomSavedItemsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Card(
      elevation: 20,
      child: Container(
        height: size.height * 0.2,
        width: size.width,
        color: Colors.grey.shade900,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                salan,
                width: 100,
                height: size.height,
                fit: BoxFit.cover,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Chicken Curry',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: size.height * 0.025),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 15,
                      ),
                      Text(
                        ' 4.5 (180 Review)',
                        style: TextStyle(
                            color: Colors.white, fontSize: size.height * 0.016),
                      ),
                    ],
                  ),
                  Text(
                      'Lorem ipsum dolor sit amet, \n consectetur adipiscing elit ...',
                      overflow: TextOverflow.ellipsis,
                      
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.height * 0.016,
                      )),
                ],
              ),
              const Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
              ),
              const Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

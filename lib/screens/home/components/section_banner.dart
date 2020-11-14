import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/home/section.dart';

class SectionBanner extends StatelessWidget {

  SectionBanner(this.section);

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: CarouselSlider.builder(
            itemCount: section.img.length,
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ),
            itemBuilder: (_, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      image: NetworkImage(section.img[index]),
                      fit: BoxFit.cover,
                    )
                  ),
                );
            },
          )
      ),
    );
  }
}

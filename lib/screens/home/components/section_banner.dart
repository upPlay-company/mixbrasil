import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/home/banners.dart';

class SectionBanner extends StatelessWidget {

  SectionBanner(this.banners);

  final Banners banners;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: CarouselSlider.builder(
            itemCount: banners.img.length,
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
                      image: NetworkImage(banners.img[index]),
                      fit: BoxFit.cover,
                    )),
              );
            },
          )
      ),
    );
  }
}

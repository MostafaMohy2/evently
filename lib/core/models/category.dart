import 'package:evently/core/utils/app_assets.dart';
import 'package:flutter/material.dart';

class Category {
  final String id;
  final String nameAr;
  final String nameEn;
  final IconData icon;
  final String imageLight;
  final String imageDark;

  Category(
    this.icon,
    this.id,
    this.nameAr,
    this.nameEn,
    this.imageLight,
    this.imageDark,
  );
}

List<Category> categoriesList = [
  Category(
    Icons.cake,
    'birthday',
    'عيد ميلاد',
    'Birthday',
    AppAssets.birthdayLight,
    AppAssets.birthdayDark,
  ),
  Category(
    Icons.menu_book,
    'book_club',
    'نادي الكتاب',
    'Book Club',
    AppAssets.bookClubLight,
    AppAssets.bookClubDark,
  ),
  Category(
    Icons.museum,
    'exhibition',
    'معرض',
    'Exhibition',
    AppAssets.exhibitionLight,
    AppAssets.exhibitionDark,
  ),
  Category(
    Icons.business,
    'meeting',
    'اجتماع',
    'Meeting',
    AppAssets.meetingLight,
    AppAssets.meetingDark,
  ),
  Category(
    Icons.sports_soccer,
    'sport',
    'رياضة',
    'Sport',
    AppAssets.sportLight,
    AppAssets.sportDark,
  ),
];

final Map<String,Category> categoriesMap = {
  for(final category in categoriesList) category.id : category
};
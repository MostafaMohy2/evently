import 'package:flutter/material.dart';

class Category {
  String nameAr;
  String nameEn;
  String id;
  IconData icon;

  Category(this.icon, this.id, this.nameAr, this.nameEn);
}

List<Category> categories = [
  Category(Icons.cake, 'birthday', 'عيد ميلاد', 'Birthday'),
  Category(Icons.menu_book, 'book_club', 'نادي الكتاب', 'Book Club'),
  Category(Icons.museum, 'exhibition', 'معرض', 'Exhibition'),
  Category(Icons.business, 'meeting', 'اجتماع', 'Meeting'),
  Category(Icons.sports_soccer, 'sport', 'رياضة', 'Sport'),
];

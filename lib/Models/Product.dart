import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './Ingredient.dart';

class Product
{
    /*[Attributes]*/
    late int id;
    late String name;
    late int category_id;
    late String company;
    late double price;
    late bool like;
    late String details;
    late double rating;
    late String image;
    late String hex;
    late List<Ingredient> ingredients;
    

    /*[Constructors]*/
    Product();

    //JSON serialization
    Product.fromJson(Map<String, dynamic> json):
        id = json['id'],
        name = json['name'],
        category_id = json['category_id'],
        company = json['company'],
        price = double.parse(json['price'].toString()),
        like = json['like'],
        details = json['details'],
        rating = json['rating'],
        image = json['image'],
        hex = json['hex'],
        ingredients = Ingredient.listFromJson(json['ingredients']);

    Map<String, dynamic> toJson() =>
    {
        'id': id,
        'name': name,
        'category_id': category_id,
        'company': company,
        'price': price,
        'like': like,
        'details': details,
        'rating': rating,
        'image': image,
        'hex': hex,
        'ingredients': ingredients
    };

    /*[Methods]*/
    int get getID{
        return this.id;
    }

}
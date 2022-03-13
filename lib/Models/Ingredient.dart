import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Ingredient
{
    /*[Attributes]*/
    late int id;
    late String name;
    late int amount;
    late String unit;
    late double percentage;
    late String hex;

    /*[Constructors]*/
    Ingredient();

    //JSON serialization
    Ingredient.fromJson(Map<String, dynamic> json):
        id = json['id'],
        name = json['name'],
        amount = json['amount'],
        unit = json['unit'],
        percentage = double.parse(json['percentage'].toString()),
        hex = json['hex'];

    Map<String, dynamic> toJson() =>
    {
        'id': id,
        'name': name,
        'amount': amount,
        'unit': unit,
        'percentage': percentage,
        'hex': hex
    };

    static List<Ingredient> listFromJson(List<dynamic> json){
        List<Ingredient> ingredients = [];

        json.forEach((element){
            ingredients.add(Ingredient.fromJson(element));
        });

        return ingredients;
    }

    /*[Methods]*/
    int get getID{
        return this.id;
    }

}
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:toast/toast.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../Models/ThemeAttribute.dart';
import '../Models/Utility.dart';
import '../Models/Product.dart';
import '../Services/ProductService.dart';

class ProductCardWidget extends StatefulWidget {
  int _state_id=0;
  late Product widgetDataObject;

  /*
  * @Description: Constructor
  *
  * @param:
  *
  * @return: void
  */
  ProductCardWidget();

  /*
  * @Description: Constructor
  *
  * @param:
  *
  * @return: void
  */
  ProductCardWidget.withData(Product productObject){
      this._state_id = 2;
      this.widgetDataObject = productObject;
  }

  @override
  State<StatefulWidget> createState() {
      switch(this._state_id)
      {
            case 2:
            {
                return _ProductCardWidgetState._withData(this._state_id, this.widgetDataObject);
                break;
            }

            default:
            {
                return _ProductCardWidgetState();
                break;
            }
      }
    }
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
    /*[Attributes]*/
    int _state_id=0;
    late Product widgetDataObject;
    Widget _view = Container();
    ThemeAttribute theme_attribute = ThemeAttribute();
    Utility utility = Utility();
    List<Widget> _productWidgets = [];
    bool _showProducts = false;
    int _contentIndex = 0;
    bool _liked = false;
    bool _isPageLoading = false;


    _ProductCardWidgetState();

    /*
    * @Description: Constructor
    *
    * @param:
    *
    * @return: void
    */
    _ProductCardWidgetState._withData(int state_id, Product productObject)
    {
        this._state_id = state_id;
        this.widgetDataObject = productObject;
    }


    /*[Live Cycle]*/

    @override
    void initState(){
        super.initState();

        //this._buildProductWidgetList(this.widgetDataObject.products);
    }
    

    @override
    Widget build(BuildContext context) {
        final double deviceHeight = MediaQuery.of(context).size.height;
        final double deviceWidth = MediaQuery.of(context).size.width;
        final double cardWidth = (deviceWidth/2) - 20;
        final double cardHeight = 250;

        //Set view
        switch(this._state_id)
        {
            case 0:
            {
                this._view = Container(
                  height: cardHeight,
                  width: cardWidth,
                  child: Shimmer.fromColors(
                    baseColor: HexColor("#d3d3d3").withOpacity(0.5),
                    highlightColor: Colors.white,
                    enabled: true,
                    child: Card(
                        color: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Container()
                    )
                  )
                );
                break;
            }

            case 1:
            {
                break;
            }

            case 2:
            {
                this._view = Container(
                    height: cardHeight,
                    width: cardWidth,
                    //padding: EdgeInsets.only(top: 5, bottom: 5, left: 0, right: 0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      //borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: Card(
                        color: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                            //padding: EdgeInsets.all(5),
                            child: Column(
                                children: [
                                  Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                              padding: EdgeInsets.only(
                                                right: 10,
                                                left: 10,
                                                top: 5,
                                                bottom: 5
                                              ),
                                              decoration: BoxDecoration(
                                                color: HexColor("#"+this.widgetDataObject.hex).withOpacity(0.1),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10)
                                                ),
                                              ),
                                              child: Text(
                                                "\$"+this.widgetDataObject.price.toStringAsFixed(0),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0,
                                                  color: HexColor("#"+this.widgetDataObject.hex)
                                                )
                                              ),
                                          )
                                        ],
                                      ),
                                  ),
                                  Container(
                                      child: Center(
                                        child: CachedNetworkImage(
                                            imageUrl: this.widgetDataObject.image,
                                            width: 120,
                                            height: 120,
                                            /*errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace){
                                                return Image.asset(
                                                    "lib/Projects/My_Pharmacy_App/Assets/Images/noimage.png",
                                                    width: 120,
                                                    height: 120
                                                );
                                            },*/
                                        ),
                                      ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Center(
                                    child: Container(
                                      child: Text(this.widgetDataObject.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black))
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Center(
                                    child: Container(
                                      child: Text(this.widgetDataObject.company, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0, color: Colors.black))
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          _likeIcon(),
                                          Text(this.widgetDataObject.rating.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black))
                                        ],
                                      ),
                                  ),
                                ],
                            )
                        )
                    ),
                );
                break;
            }

            default:
            {
                break;
            }
        }

        return this._view;
    }


    /*[Methods]*/

    /*
    * @Description: show liked icon
    *
    * @param:
    *
    * @return: Icon (Widget)
    */
    Icon _likeIcon()
    {
        if(this.widgetDataObject.like){
            return Icon(
                Icons.favorite,
                color: Colors.black,
            );
        }else{
            return Icon(
                Icons.favorite_border,
                color: Colors.black,
            );
        }
    }

}
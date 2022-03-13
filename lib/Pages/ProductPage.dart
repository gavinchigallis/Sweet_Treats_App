import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sweet_treats_app/Models/Ingredient.dart';
import 'package:sweet_treats_app/Models/WidgetState.dart';
import '../Widgets/MainAppBar.dart';
import 'dart:convert';
import 'package:toast/toast.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:math';

import '../Models/Constants.dart';
import '../Models/ThemeAttribute.dart';
import '../Models/Utility.dart';
import '../Models/Product.dart';
import '../Services/ProductService.dart';



/*
* @Description:
*
*/
class ProductPage extends StatefulWidget {
  /*[Attributes]*/
  WIDGET_STATE _state = WIDGET_STATE.INITIAL_STATE;
  late Product widgetDataObject;

  ProductPage()
  {

  }

  /*
  * @Description: Constructor
  *
  * @param:
  *
  * @return: void
  */
  ProductPage.withData(Product product){
      this._state = WIDGET_STATE.HAS_DATA;
      this.widgetDataObject = product;
  }

  /*
  * @Description:
  *
  * @param:
  *
  * @return: void
  */
  @override
  State<StatefulWidget> createState() {
    switch(this._state)
      {
            case WIDGET_STATE.HAS_DATA:
            {
                return _ProductPageState._withData(this._state, this.widgetDataObject);
                break;
            }

            default:
            {
                return _ProductPageState();
                break;
            }
      }
  }
}

/*
* @Description:
*
* @param:
*
* @return: void
*/
class _ProductPageState extends State<ProductPage> with WidgetsBindingObserver, TickerProviderStateMixin{
    /*[Attributes]*/
    WIDGET_STATE _state = WIDGET_STATE.HAS_DATA;
    WIDGET_STATE _mainDisplayState = WIDGET_STATE.HAS_DATA;
    late Product widgetDataObject;
    Widget _view = Container();
    ThemeAttribute theme_attribute = ThemeAttribute();
    Utility utility = new Utility();
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    bool _isPageLoading = false;
    ProductService _productService = new ProductService();

    /*[Constructors]*/


    /*
    * @Description: Constructor
    *
    * @param:
    *
    * @return: void
    */
    _ProductPageState()
    {

    }

    /*
    * @Description: Constructor
    *
    * @param:
    *
    * @return: void
    */
    _ProductPageState._withData(WIDGET_STATE state, Product product)
    {
        this._state = state;
        this.widgetDataObject = product;
    }

    /*[Live Cycle methods]*/

    /*
    * @Description: 
    *
    * @param:
    *
    * @return: void
    */
    @override
    void initState(){
        super.initState();
        WidgetsBinding.instance!.addObserver(this);

    }

    @override
    void dispose() {
        WidgetsBinding.instance!.removeObserver(this);
        super.dispose();
    }
    

    /*
    * @Description: 
    *
    * @param:
    *
    * @return: void
    */
    @override
    Widget build(BuildContext context) {
        //Variables
        //final ThemeAttribute theme_attribute = ThemeAttribute();
        final double deviceHeight = MediaQuery.of(context).size.height;
        final double deviceWidth = MediaQuery.of(context).size.width;

        //Set view
        switch(this._state)
        {
            case WIDGET_STATE.INITIAL_STATE:
            {
                this._view = SafeArea(
                    child: Scaffold(
                        key: _scaffoldKey,
                            appBar: MainAppBar(),
                            body: Container(
                                //color: Colors.red,
                            ),
                    )
                );
                break;
            }

            case WIDGET_STATE.IS_LOADING:
            {
                this._view = SafeArea(
                    child: Scaffold(
                        key: _scaffoldKey,
                            appBar: MainAppBar(),
                            body: Container(
                                //color: Colors.red,
                            ),
                    )
                );
                break;
            }

            case WIDGET_STATE.NO_DATA:
            {
                this._view = SafeArea(
                    child: Scaffold(
                        key: _scaffoldKey,
                            appBar: MainAppBar(),
                            body: Container(
                                //color: Colors.red,
                            ),
                    )
                );
                break;
            }

            case WIDGET_STATE.HAS_DATA:
            {
                this._view = SafeArea(
                  child: Scaffold(
                    key: _scaffoldKey,
                    backgroundColor: Colors.white,
                      appBar: AppBar(
                        centerTitle: true,
                        elevation: 0.0,
                        backgroundColor: Colors.white,
                        title: GestureDetector(
                          onTap: () => {},
                          child: Container(),
                        ),
                        leading: GestureDetector(
                          onTap: ()=>Navigator.of(context).pop(),
                          child: RotatedBox(
                              quarterTurns: 4,
                              child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                  size: 30,
                              ),
                          ),
                        ),
                        actions: [
                          GestureDetector(
                            child: Icon(
                              Icons.favorite_outline,
                              size: 30.0,
                              color: Colors.black
                            ),
                            onTap: () => (){},
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                      body: _mainDisplay(),
                  )
                );
                break;
            }

            case WIDGET_STATE.HAS_ERROR:
            {
                this._view = SafeArea(
                    child: Scaffold(
                        key: _scaffoldKey,
                        backgroundColor: Colors.white,
                            appBar: MainAppBar(),
                            body: _mainDisplay(),
                    )
                );
                break;
            }

            default:
            {
                this._view = SafeArea(
                    child: Scaffold(
                        key: _scaffoldKey,
                            appBar: MainAppBar(),
                            body: Container(
                                //color: Colors.red,
                            ),
                    )
                );
                break;
            }
        }


        return this._view;
    }


    /*[Methods]*/


    /*
    * @Description: 
    *
    * @param:
    *
    * @return: void
    */
    Widget _mainDisplay() {
        //Variables
        //final ThemeAttribute theme_attribute = ThemeAttribute();
        Utility utility = new Utility();
        final double deviceHeight = MediaQuery.of(context).size.height;
        final double deviceWidth = MediaQuery.of(context).size.width;

        

        switch(this._mainDisplayState)
        {
            case WIDGET_STATE.IS_LOADING:
            {
                return Container(
                    width: deviceWidth,
                    height: deviceHeight,
                    //color: Colors.blue,
                    //child: SingleChildScrollView(
                        child: Container(
                            child: Column(
                                children: <Widget>[
                                    this._pageLoader(),
                                ],
                            ),
                        ),
                    //),
                );
            }

            case WIDGET_STATE.NO_DATA:
            {
                return Container();
            }

            case WIDGET_STATE.HAS_DATA:
            {
                return Container(
                    width: deviceWidth,
                    height: deviceHeight,
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              width: deviceWidth,
                              height: deviceHeight * 0.3,
                              child: Center(
                                  child: CachedNetworkImage(
                                      imageUrl: this.widgetDataObject.image,
                                      fit: BoxFit.cover,
                                      placeholder: (BuildContext context, String text) {
                                        return Container(child:  Shimmer.fromColors(
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
                                        ));
                                      },
                                  ),
                              ),
                            ),
                            Container(
                              width: deviceWidth - 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: HexColor("#fafafa"),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 25, left: 25, right: 25),
                                    width: deviceWidth - 20,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Ingredients', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22.0, color: Colors.black)),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: widgetDataObject.ingredients.map((ingredient){
                                              return Container(
                                                width: 70,
                                                height: 130,
                                                padding: EdgeInsets.only(top: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(40),
                                                  color: HexColor("#"+ingredient.hex),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(ingredient.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.black)),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(ingredient.amount.toString()+' '+ingredient.unit, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12.0, color: Colors.black)),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      width: 60,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(40),
                                                        color: HexColor("#ffffff"),
                                                      ),
                                                      child: Center(
                                                        child: Text(ingredient.percentage.toStringAsFixed(0)+'%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0, color: Colors.black)),
                                                      )
                                                    )
                                                  ],
                                                ),
                                              );
                                              }).toList()
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20
                                        ),
                                        Text('Details', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22.0, color: Colors.black)),
                                        SizedBox(
                                          height: 10
                                        ),
                                        Container(
                                          child: Text(widgetDataObject.details/*'The sweet and subtle salty combo of chocolate meets caramel. Introduce the Caramel Duoto your mouth!'*/, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0, color: HexColor("#8f8f8f"))),
                                        ),
                                        SizedBox(
                                          height: 30
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 20, right: 20),
                                    width: deviceWidth - 20,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text('\$'+widgetDataObject.price.toStringAsFixed(0), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Colors.black)),
                                              SizedBox(
                                                height: 5
                                              ),
                                              Text('TOTAL PAYBLE', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12.0, color: HexColor("#8f8f8f"))),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          child: Center(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                top: 30
                                              ),
                                              padding: EdgeInsets.only(
                                                left: 30,
                                                right: 30,
                                                top: 15,
                                                bottom: 15
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.all(Radius.circular(25)),
                                              ),
                                              child: Text('Add to cart', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0, color: Colors.white)),
                                            ),
                                          ),
                                          onTap: (){
                                            
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                );
            }

            case WIDGET_STATE.HAS_ERROR:
            {
                return Container();
            }

            default:
            {
                return Container();
            }

        }
    }

    /*
    * @Description: 
    *
    * @param:
    *
    * @return: void
    */
    Widget _pageLoader()
    {
        //final ThemeAttribute theme_attribute = ThemeAttribute();
        Utility utility = new Utility();
        final double deviceHeight = MediaQuery.of(context).size.height;
        final double deviceWidth = MediaQuery.of(context).size.width;

        if(_isPageLoading)
        {
            return Container(
                height: 3,
                margin: const EdgeInsets.only(bottom: 5),
                child: const LinearProgressIndicator(
                    backgroundColor: Colors.black,
                ),
            );
        }
        else
        {
            return Container(
                height: 3,
                margin: const EdgeInsets.only(bottom: 5)
            );
        }
    }
    
   
    /*
    * @Description: 
    *
    * @param:
    *
    * @return: void
    */
    /*Future <List<dynamic>?> _getProductsByCategoryId(int id) async {
        this.utility.Custom_Print("START: _getProductsByCategoryId");
        //Variables
        

        setState(() {
            this._isPageLoading = true;
        });
        
        
        var result = await this._productService.getProductsByCategoryId(id)
        .then((value) {
            // Run extra code here
            utility.Custom_Print("Function Complete Successfully");
            utility.Custom_Print(value.toString());

            return value;
        },
        onError: (error) {
            utility.Custom_Print("Future returned Error");
            utility.Custom_Print(error.toString());
            //Toast.show(error['message'], context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

            setState(() {
                this._isPageLoading = false;
            });

            switch(error.runtimeType) { 

                case SocketException: {

                    SnackBar snackBar = SnackBar(
                        content: Text("Could not login at this time"),
                        action: SnackBarAction(
                            label: 'OK',
                            onPressed: () {
                                // Some code to undo the change.
                            },
                        ),
                    );
                    
                    //_scaffoldKey.currentState.showSnackBar(snackBar);

                    Toast.show("Could not login at this time", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    break;
                }


                default: {

                    SnackBar snackBar =  SnackBar(
                        content: Text(error['error']),
                        action: SnackBarAction(
                            label: 'OK',
                            onPressed: () {
                                // Some code to undo the change.
                            },
                        ),
                    );
                    
                    //_scaffoldKey.currentState.showSnackBar(snackBar);

                    Toast.show(error['error'].toString(), context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                }
            }
        })
        .catchError((error){
            utility.Custom_Print("Please try again later");
            utility.Custom_Print(error.toString());
            //Toast.show("Please try again later", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

            setState(() {
                this._isPageLoading = false;
            });
        });

        this.utility.Custom_Print("STOP: _getProductsByCategoryId");
        return result;
    }*/
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import '../Widgets/MainAppBar.dart';
import 'dart:convert';
import 'package:toast/toast.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:math';

import '../Models/Constants.dart';
import '../Models/ThemeAttribute.dart';
import '../Models/Utility.dart';
import '../Models/Product.dart';
import '../Widgets/ProductCardWidget.dart';
import '../Services/ProductService.dart';
import 'ProductPage.dart';



/*
* @Description:
*
*/
class HomePage extends StatefulWidget {
  /*[Attributes]*/

  HomePage()
  {

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
    return _HomePage();
  }
}

/*
* @Description:
*
* @param:
*
* @return: void
*/
class _HomePage extends State<HomePage> with WidgetsBindingObserver, TickerProviderStateMixin{
    /*[Attributes]*/
    int _state_id = 2;
    int mainDisplayState = 2;
    Widget _view = Container();
    ThemeAttribute theme_attribute = ThemeAttribute();
    Utility utility = new Utility();
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    bool _isPageLoading = false;
    ProductService _productService = new ProductService();
    List<dynamic> _donuts = [];
    bool _isLoadingDonuts = false;
    List<dynamic> _burgers = [];
    List<dynamic> _doctors = [];
    List<dynamic> _pancakes = [];
    List<dynamic> _smoothies = [];
    List<dynamic> _pizzas = [];
    int _selectedIndex = 0;
    late TabController _controller;

    /*[Constructors]*/


    /*
    * @Description: Constructor
    *
    * @param:
    *
    * @return: void
    */
    _HomePage()
    {

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
        WidgetsBinding.instance!.addObserver(this);
        
        this._getDonuts(false);
        this._getBurgers();
        this._getPancakes(false);
        this._getSmoothies();
        this._getPizzas();

        
        _controller = TabController(length: 5, vsync: this, initialIndex: 0);
        _controller.addListener(() {
            setState(() {
              this.utility.Custom_Print("addListener: _controller.index: "+_controller.index.toString());
              this._selectedIndex = _controller.index;
            });
        });

        super.initState();
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
        switch(this._state_id)
        {
            case 0:
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

            case 1:
            {
                break;
            }

            case 2:
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
                        appBar: AppBar(
                          title: Row(
                              children: <Widget>[
                                  //Image.asset('assets/icon.png'),
                                  SizedBox(width: 20),
                                  Text('Home', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0, color: Colors.grey))
                              ]
                          ),
                          backgroundColor: Colors.white,
                          elevation: 0.0,
                        ),
                        body: Container(),
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

        

        switch(this.mainDisplayState)
        {
            //is loading
            case 0:
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
                                    Container(
                                        padding: EdgeInsets.only(left: 20, right: 20),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              
                                            ],
                                        ),
                                    ),
                                    Container(
                                        height: deviceHeight-220,
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                                Icon(Icons.shopping_cart, color: Colors.grey[600], size: 100),
                                                SizedBox(height: 10),
                                            ],
                                        ),
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(left: 20, right: 20),
                                        margin: EdgeInsets.only(top: 10, bottom: 10),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                                
                                            ],
                                        ),
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(left: 20, right: 20),
                                        child: FlatButton(
                                            color: Colors.black,
                                            child: Container(
                                                constraints: BoxConstraints(
                                                    minWidth: deviceWidth-100
                                                ),
                                                margin: EdgeInsets.all(10),
                                                child: Center(
                                                    //child:,
                                                )
                                            ),
                                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                                            onPressed: (){
                                                
                                            },
                                        )
                                    ),
                                ],
                            ),
                        ),
                    //),
                );
                break;
            }

            //Empty State
            case 1:
            {
                return Container();
                break;
            }

            //has data
            case 2:
            {
                return Container(
                    width: deviceWidth,
                    height: deviceHeight,
                    child: DefaultTabController(
                        length: 5,
                        child: Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.only(left: 20, top: 0, right: 0, bottom: 0),
                                        child: Text('I want to Eat...', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0, color: Colors.black)),
                                    ),
                                    Container(
                                        width: deviceWidth,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                                        ),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                                Container(
                                                    margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                                                    child: TabBar(
                                                        indicatorColor: Colors.black,
                                                        unselectedLabelColor: Colors.grey,
                                                        controller: _controller,
                                                        onTap: (int index){
                                                            setState(() {
                                                              this._selectedIndex = index;  
                                                            });
                                                        },
                                                        tabs:
                                                        [
                                                            Tab(
                                                                text: "Donuts",
                                                                icon: Container(
                                                                    width: 40,
                                                                    height: 40,
                                                                    padding: EdgeInsets.all(5),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.white,
                                                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                                                    ),
                                                                    child: this._selectedIndex == 0 ? Image.asset(
                                                                        packagePath+"lib/Assets/Images/doughnut_128x128.png",
                                                                        width: 30,
                                                                        height: 30,
                                                                    ) : Image.asset(
                                                                        packagePath+"lib/Assets/Images/doughnut_BNW_128x128.png",
                                                                        width: 30,
                                                                        height: 30,
                                                                    ),
                                                                ),
                                                            ),
                                                            Tab(
                                                                text: "Burger",
                                                                icon: Container(
                                                                    width: 40,
                                                                    height: 40,
                                                                    padding: EdgeInsets.all(5),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.white,
                                                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                                                    ),
                                                                    child: this._selectedIndex == 1 ? Image.asset(
                                                                        packagePath+"lib/Assets/Images/burger_128x128.png",
                                                                        width: 30,
                                                                        height: 30,
                                                                    ) : Image.asset(
                                                                        packagePath+"lib/Assets/Images/burger_BNW_128x128.png",
                                                                        width: 30,
                                                                        height: 30,
                                                                    ),
                                                                ),
                                                            ),
                                                            Tab(
                                                                text: "PanCake",
                                                                icon: Container(
                                                                    width: 40,
                                                                    height: 40,
                                                                    padding: EdgeInsets.all(5),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.white,
                                                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                                                    ),
                                                                    child: this._selectedIndex == 2 ? Image.asset(
                                                                        packagePath+"lib/Assets/Images/pancake_128x128.png",
                                                                        width: 30,
                                                                        height: 30,
                                                                    ) : Image.asset(
                                                                        packagePath+"lib/Assets/Images/pancake_BNW_128x128.png",
                                                                        width: 30,
                                                                        height: 30,
                                                                    ),
                                                                ),
                                                            ),
                                                            Tab(
                                                                text: "Smoothies",
                                                                icon: Container(
                                                                    width: 40,
                                                                    height: 40,
                                                                    padding: EdgeInsets.all(5),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.white,
                                                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                                                    ),
                                                                    child: this._selectedIndex == 3 ? Image.asset(
                                                                        packagePath+"lib/Assets/Images/smoothie_128x128.png",
                                                                        width: 30,
                                                                        height: 30,
                                                                    ) : Image.asset(
                                                                        packagePath+"lib/Assets/Images/smoothie_BNW_128x128.png",
                                                                        width: 30,
                                                                        height: 30,
                                                                    ),
                                                                ),
                                                            ),
                                                            Tab(
                                                                text: "Pizza",
                                                                icon: Container(
                                                                    width: 40,
                                                                    height: 40,
                                                                    padding: EdgeInsets.all(5),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.white,
                                                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                                                    ),
                                                                    child: this._selectedIndex == 4 ? Image.asset(
                                                                        packagePath+"lib/Assets/Images/pizza_128x128.png",
                                                                        width: 30,
                                                                        height: 30,
                                                                    ) : Image.asset(
                                                                        packagePath+"lib/Assets/Images/pizza_BNW_128x128.png",
                                                                        width: 30,
                                                                        height: 30,
                                                                    ),
                                                                ),
                                                            ),
                                                        ]

                                                    ),
                                                )
                                            ],
                                        ),
                                    ),
                                    Container(
                                        color: Colors.grey[50],
                                        width: deviceWidth,
                                        height: deviceHeight - 215,
                                        child: TabBarView(
                                            controller: this._controller,
                                            children: [
                                                Container(
                                                    padding: EdgeInsets.only(top: 10), 
                                                    child: SingleChildScrollView(
                                                      child: Container(
                                                        child: Column(
                                                          children: [
                                                              this._isLoadingDonuts ? Container(
                                                                padding: EdgeInsets.only(left: 10, right: 10),  
                                                                child: GridView.builder(
                                                                  shrinkWrap: true,
                                                                  itemCount: 4,  
                                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(  
                                                                      crossAxisCount: 2,  
                                                                      crossAxisSpacing: 5.0,  
                                                                      mainAxisSpacing: 5.0,
                                                                      childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.6),
                                                                  ),  
                                                                  itemBuilder: (BuildContext context, int index){  
                                                                    
                                                                    return Container(
                                                                        //color: Colors.green,
                                                                        margin: EdgeInsets.only(left: 2, top: 0, right: 2, bottom: 0),
                                                                        padding: EdgeInsets.only(left: 2, top: 0, right: 2, bottom: 0),
                                                                        child: new ProductCardWidget(),
                                                                    );  
                                                                  },  
                                                                )
                                                              ) : Container(
                                                              height: deviceHeight - 350,
                                                              padding: EdgeInsets.only(left: 10, right: 10),  
                                                              child: GridView.builder(
                                                                shrinkWrap: true,
                                                                itemCount: this._donuts.length,  
                                                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(  
                                                                    crossAxisCount: 2,  
                                                                    crossAxisSpacing: 5.0,  
                                                                    mainAxisSpacing: 5.0,
                                                                    childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.6),
                                                                ),  
                                                                itemBuilder: (BuildContext context, int index){  
                                                                  Product product = new Product.fromJson(this._donuts[index]);
                                                                              
                                                                  return GestureDetector(
                                                                      child: Container(
                                                                          //color: Colors.green,
                                                                          margin: EdgeInsets.only(left: 2, top: 0, right: 2, bottom: 0),
                                                                          padding: EdgeInsets.only(left: 2, top: 0, right: 2, bottom: 0),
                                                                          child: new ProductCardWidget.withData(product),
                                                                      ),
                                                                      onTap: (){
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute<bool>(
                                                                                  builder: (BuildContext context) => new ProductPage.withData(product)
                                                                              )
                                                                          );
                                                                      }
                                                                  );  
                                                                },  
                                                              )
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
                                                                  child: Text('Show More', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0, color: Colors.white)),
                                                                ),
                                                              ),
                                                              onTap: (){
                                                                this._getDonuts(true);
                                                              },
                                                            )
                                                          ]
                                                      )
                                                    )
                                                  )
                                                ),
                                                Container(
                                                    padding: EdgeInsets.only(top: 10), 
                                                    color: Colors.transparent,
                                                    child: Container(  
                                                        padding: EdgeInsets.only(left: 10, right: 10),  
                                                        child: GridView.builder(  
                                                          shrinkWrap: true,
                                                          itemCount: this._burgers.length,  
                                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(  
                                                              crossAxisCount: 2,  
                                                              crossAxisSpacing: 5.0,  
                                                              mainAxisSpacing: 5.0,
                                                              childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.6),
                                                          ),  
                                                          itemBuilder: (BuildContext context, int index){  
                                                            Product product = new Product.fromJson(this._burgers[index]);
                                                                        
                                                            return GestureDetector(
                                                                child: Container(
                                                                    //color: Colors.green,
                                                                    margin: EdgeInsets.only(left: 2, top: 0, right: 2, bottom: 0),
                                                                    padding: EdgeInsets.only(left: 2, top: 0, right: 2, bottom: 0),
                                                                    child: new ProductCardWidget.withData(product),
                                                                ),
                                                                onTap: (){
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute<bool>(
                                                                            builder: (BuildContext context) => new ProductPage.withData(product)
                                                                        )
                                                                    );
                                                                }
                                                            );  
                                                          },  
                                                        )
                                                    ),
                                                ),
                                                Container(
                                                    padding: EdgeInsets.only(top: 10), 
                                                    color: Colors.transparent,
                                                    child: SingleChildScrollView(
                                                      child: Container(
                                                        child: Column(
                                                        children: [
                                                              Container(
                                                              height: deviceHeight - 350,
                                                              padding: EdgeInsets.only(left: 10, right: 10),  
                                                              child: GridView.builder(
                                                                shrinkWrap: true,  
                                                                itemCount: this._pancakes.length,  
                                                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(  
                                                                    crossAxisCount: 2,  
                                                                    crossAxisSpacing: 5.0,  
                                                                    mainAxisSpacing: 5.0,
                                                                    childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.6),
                                                                ),  
                                                                itemBuilder: (BuildContext context, int index){  
                                                                  Product product = new Product.fromJson(this._pancakes[index]);
                                                                              
                                                                  return GestureDetector(
                                                                      child: Container(
                                                                          //color: Colors.green,
                                                                          margin: EdgeInsets.only(left: 2, top: 0, right: 2, bottom: 0),
                                                                          padding: EdgeInsets.only(left: 2, top: 0, right: 2, bottom: 0),
                                                                          child: new ProductCardWidget.withData(product),
                                                                      ),
                                                                      onTap: (){
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute<bool>(
                                                                                  builder: (BuildContext context) => new ProductPage.withData(product)
                                                                              )
                                                                          );
                                                                      }
                                                                  );  
                                                                },  
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
                                                                    child: Text('Show More', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0, color: Colors.white)),
                                                                ),
                                                              ),
                                                              onTap: (){
                                                                this._getPancakes(true);
                                                              },
                                                            )
                                                        ]
                                                      )
                                                    ),
                                                  )
                                                ),
                                                Container(
                                                    padding: EdgeInsets.only(top: 10), 
                                                    color: Colors.transparent,
                                                    child: Container(  
                                                        padding: EdgeInsets.only(left: 10, right: 10),  
                                                        child: GridView.builder(
                                                          shrinkWrap: true,
                                                          itemCount: this._smoothies.length,  
                                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(  
                                                              crossAxisCount: 2,  
                                                              crossAxisSpacing: 5.0,  
                                                              mainAxisSpacing: 5.0,
                                                              childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.6),
                                                          ),  
                                                          itemBuilder: (BuildContext context, int index){  
                                                            Product product = new Product.fromJson(this._smoothies[index]);
                                                                        
                                                            return GestureDetector(
                                                                child: Container(
                                                                    //color: Colors.green,
                                                                    margin: EdgeInsets.only(left: 2, top: 0, right: 2, bottom: 0),
                                                                    padding: EdgeInsets.only(left: 2, top: 0, right: 2, bottom: 0),
                                                                    child: new ProductCardWidget.withData(product),
                                                                ),
                                                                onTap: (){
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute<bool>(
                                                                            builder: (BuildContext context) => new ProductPage.withData(product)
                                                                        )
                                                                    );
                                                                }
                                                            );  
                                                          },  
                                                        )
                                                    ),
                                                ),
                                                Container(
                                                    padding: EdgeInsets.only(top: 10), 
                                                    color: Colors.transparent,
                                                    child: Container(  
                                                        padding: EdgeInsets.only(left: 10, right: 10),  
                                                        child: GridView.builder(
                                                          shrinkWrap: true,
                                                          itemCount: this._pizzas.length,  
                                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(  
                                                              crossAxisCount: 2,  
                                                              crossAxisSpacing: 5.0,  
                                                              mainAxisSpacing: 5.0,
                                                              childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.6),
                                                          ),  
                                                          itemBuilder: (BuildContext context, int index){  
                                                            Product product = new Product.fromJson(this._pizzas[index]);
                                                                        
                                                            return GestureDetector(
                                                                child: Container(
                                                                    //color: Colors.green,
                                                                    margin: EdgeInsets.only(left: 2, top: 0, right: 2, bottom: 0),
                                                                    padding: EdgeInsets.only(left: 2, top: 0, right: 2, bottom: 0),
                                                                    child: new ProductCardWidget.withData(product),
                                                                ),
                                                                onTap: (){
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute<bool>(
                                                                            builder: (BuildContext context) => new ProductPage.withData(product)
                                                                        )
                                                                    );
                                                                }
                                                            );  
                                                          },  
                                                        )
                                                    ),
                                                ),
                                            ]
                                        )
                                    )
                                ]
                            )
                        )
                    )
                );
                break;
            }

            default:
            {
                return Container();
                break;
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

        if(this._isPageLoading)
        {
            return Container(
                height: 3,
                margin: EdgeInsets.only(bottom: 5),
                child: LinearProgressIndicator(
                    backgroundColor: Colors.black,
                ),
            );
        }
        else
        {
            return Container(
                height: 3,
                margin: EdgeInsets.only(bottom: 5)
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
    Future <List<dynamic>?> _getProductsByCategoryId(int id) async {
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
    }

    /*
    * @Description: 
    *
    * @param:
    *
    * @return: void
    */
    Future<void> _getDonuts(bool update) async {
        this.utility.Custom_Print("START: _getDonuts");
        //Variables

        setState((){
            if(!update){
              this._isLoadingDonuts = true;
            }
        });

        await this._getProductsByCategoryId(1).then((value){
          
          this.utility.Custom_Print("donuts: ");
          this.utility.Custom_Print(value.toString());

          setState((){
              if(update){
                value!.shuffle();
                this._donuts.addAll(value);
              }else{
                this._isLoadingDonuts = false;
                this._donuts = value!;
              }
              
          });
        });
        

        this.utility.Custom_Print("STOP: _getDonuts");
    }

    /*
    * @Description: 
    *
    * @param:
    *
    * @return: void
    */
    Future<void> _getBurgers() async {
        this.utility.Custom_Print("START: _getBurgers");
        //Variables

        await this._getProductsByCategoryId(2).then((value){
          
          this.utility.Custom_Print("Burgers: ");
          this.utility.Custom_Print(value.toString());

          setState((){
              this._burgers = value!;
          });
        });
        

        this.utility.Custom_Print("STOP: _getBurgers");
    }

    /*
    * @Description: 
    *
    * @param:
    *
    * @return: void
    */
    Future<void> _getPancakes(bool update) async {
        this.utility.Custom_Print("START: _getPancakes");
        //Variables

        await this._getProductsByCategoryId(3).then((value){
          
          this.utility.Custom_Print("Pancakes: ");
          this.utility.Custom_Print(value.toString());

          setState((){
              if(update){
                value!.shuffle();
                this._pancakes.addAll(value);
              }else{
                this._pancakes = value!;
              }
          });
        });
        

        this.utility.Custom_Print("STOP: _getPancakes");
    }

    /*
    * @Description: 
    *
    * @param:
    *
    * @return: void
    */
    Future<void> _getPizzas() async {
        this.utility.Custom_Print("START: _getPizzas");
        //Variables

        await this._getProductsByCategoryId(5).then((value){
          
          this.utility.Custom_Print("Pizzas: ");
          this.utility.Custom_Print(value.toString());

          setState((){
              this._pizzas = value!;
          });
        });
        

        this.utility.Custom_Print("STOP: _getPizzas");
    }

    /*
    * @Description: 
    *
    * @param:
    *
    * @return: void
    */
    Future<void> _getSmoothies() async {
        this.utility.Custom_Print("START: _getSmoothies");
        //Variables

        await this._getProductsByCategoryId(4).then((value){
          
          this.utility.Custom_Print("Smoothies: ");
          this.utility.Custom_Print(value.toString());

          setState((){
              this._smoothies = value!;
          });
        });
        

        this.utility.Custom_Print("STOP: _getSmoothies");
    }
}
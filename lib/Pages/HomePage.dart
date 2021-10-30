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

import '../Models/ThemeAttribute.dart';
import '../Models/Utility.dart';
import '../Models/Product.dart';
import '../Widgets/ProductCardWidget.dart';
import '../Widgets/DoctorCardWidget.dart';
import '../Services/ProductService.dart';



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
class _HomePage extends State<HomePage> with WidgetsBindingObserver{
    /*[Attributes]*/
    int _state_id = 2;
    int mainDisplayState = 2;
    Widget _view = Container();
    ThemeAttribute theme_attribute = ThemeAttribute();
    Utility utility = new Utility();
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    bool _isPageLoading = false;
    ProductService _productService = new ProductService();
    List _pills = [];
    List _first_aids = [];
    List _doctors = [];
    List _emergencys = [];

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

        this._getPills();
        this._getFirstAids();
        this._getDoctors();
        this._getEmergency();

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
                        length: 4,
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
                                        height: 125,
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
                                                                    child: Image.asset(
                                                                        "lib/Assets/Images/doughnut_BNW_128x128.png",
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
                                                                    child: Image.asset(
                                                                        "lib/Assets/Images/burger_BNW_128x128.png",
                                                                        width: 30,
                                                                        height: 30,
                                                                    ),
                                                                ),
                                                            ),
                                                            Tab(
                                                                text: "Doctor",
                                                                icon: Container(
                                                                    width: 40,
                                                                    height: 40,
                                                                    padding: EdgeInsets.all(5),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.white,
                                                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                                                    ),
                                                                    child: Image.asset(
                                                                        "lib/Projects/My_Pharmacy_App/Assets/Images/doctor_150x150.png",
                                                                        width: 30,
                                                                        height: 30,
                                                                    ),
                                                                ),
                                                            ),
                                                            Tab(
                                                                text: "Emergency",
                                                                icon: Container(
                                                                    width: 40,
                                                                    height: 40,
                                                                    padding: EdgeInsets.all(5),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.white,
                                                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                                                    ),
                                                                    child: Image.asset(
                                                                        "lib/Projects/My_Pharmacy_App/Assets/Images/emergency_150x150.png",
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
                                        color: Colors.transparent,
                                        width: deviceWidth,
                                        height: deviceHeight - 200,
                                        child: TabBarView(
                                            children: [
                                                new Container(
                                                    color: Colors.transparent,
                                                    child: SingleChildScrollView(
                                                        child: Column(
                                                            children: this._pills.map((item) {
                                                                return new Builder(
                                                                    builder: (BuildContext context) {
                                                                        Product product = new Product.fromJson(item);
                                                                        
                                                                        return GestureDetector(
                                                                            child: Container(
                                                                                //color: Colors.green,
                                                                                margin: EdgeInsets.only(left: 5, top: 0, right: 5, bottom: 0),
                                                                                padding: EdgeInsets.only(left: 5, top: 0, right: 5, bottom: 0),
                                                                                child: new ProductCardWidget.withData(product),
                                                                            ),
                                                                            onTap: (){
                                                                                /*Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute<bool>(
                                                                                        builder: (BuildContext context) => new HotelPage(hotel.id)
                                                                                    )
                                                                                );*/
                                                                            }
                                                                        );
                                                                    },
                                                                );
                                                            }).toList(),
                                                        ),
                                                    ),
                                                ),
                                                new Container(
                                                    color: Colors.transparent,
                                                    child: SingleChildScrollView(
                                                        child: Column(
                                                            children: this._first_aids.map((item) {
                                                                return new Builder(
                                                                    builder: (BuildContext context) {
                                                                        Product product = new Product.fromJson(item);
                                                                        
                                                                        return GestureDetector(
                                                                            child: Container(
                                                                                //color: Colors.green,
                                                                                margin: EdgeInsets.only(left: 5, top: 0, right: 5, bottom: 0),
                                                                                padding: EdgeInsets.only(left: 5, top: 0, right: 5, bottom: 0),
                                                                                child: new ProductCardWidget.withData(product),
                                                                            ),
                                                                            onTap: (){
                                                                                /*Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute<bool>(
                                                                                        builder: (BuildContext context) => new HotelPage(hotel.id)
                                                                                    )
                                                                                );*/
                                                                            }
                                                                        );
                                                                    },
                                                                );
                                                            }).toList(),
                                                        ),
                                                    ),
                                                ),
                                                new Container(
                                                    color: Colors.transparent,
                                                    child: SingleChildScrollView(
                                                        child: Column(
                                                            children: this._doctors.map((item) {
                                                                return new Builder(
                                                                    builder: (BuildContext context) {
                                                                        Product product = new Product.fromJson(item);
                                                                        
                                                                        return GestureDetector(
                                                                            child: Container(
                                                                                //color: Colors.green,
                                                                                margin: EdgeInsets.only(left: 5, top: 0, right: 5, bottom: 0),
                                                                                padding: EdgeInsets.only(left: 5, top: 0, right: 5, bottom: 0),
                                                                                child: new DoctorCardWidget.withData(product),
                                                                            ),
                                                                            onTap: (){
                                                                                /*Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute<bool>(
                                                                                        builder: (BuildContext context) => new HotelPage(hotel.id)
                                                                                    )
                                                                                );*/
                                                                            }
                                                                        );
                                                                    },
                                                                );
                                                            }).toList(),
                                                        ),
                                                    ),
                                                ),
                                                new Container(
                                                    color: Colors.transparent,
                                                    child: SingleChildScrollView(
                                                        child: Column(
                                                            children: this._emergencys.map((item) {
                                                                return new Builder(
                                                                    builder: (BuildContext context) {
                                                                        Product product = new Product.fromJson(item);
                                                                        
                                                                        return GestureDetector(
                                                                            child: Container(
                                                                                //color: Colors.green,
                                                                                margin: EdgeInsets.only(left: 5, top: 0, right: 5, bottom: 0),
                                                                                padding: EdgeInsets.only(left: 5, top: 0, right: 5, bottom: 0),
                                                                                child: new ProductCardWidget.withData(product),
                                                                            ),
                                                                            onTap: (){
                                                                                /*Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute<bool>(
                                                                                        builder: (BuildContext context) => new HotelPage(hotel.id)
                                                                                    )
                                                                                );*/
                                                                            }
                                                                        );
                                                                    },
                                                                );
                                                            }).toList(),
                                                        ),
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
    Future<void> _getPills() async {
        this.utility.Custom_Print("START: _getPills");
        //Variables

        setState(() {
            this._isPageLoading = true;
        });
        
        
        this._productService.getPills()
        .then((value) {
            // Run extra code here
            utility.Custom_Print("Function Complete Successfully");
            utility.Custom_Print(value.toString());

            setState(() {
                this._isPageLoading = false;
                //this._state_id = 2;
                //this.mainDisplayState = 2;
                this._pills = value;
            });
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

        this.utility.Custom_Print("STOP: _getPills");
    }


    /*
    * @Description: 
    *
    * @param:
    *
    * @return: void
    */
    Future<void> _getFirstAids() async {
        this.utility.Custom_Print("START: _getFirstAids");
        //Variables

        setState(() {
            this._isPageLoading = true;
        });
        
        
        this._productService.getFirstAids()
        .then((value) {
            // Run extra code here
            utility.Custom_Print("Function Complete Successfully");
            utility.Custom_Print(value.toString());

            setState(() {
                this._isPageLoading = false;
                //this._state_id = 2;
                //this.mainDisplayState = 2;
                this._first_aids = value;
            });
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

        this.utility.Custom_Print("STOP: _getFirstAids");
    }


    /*
    * @Description: 
    *
    * @param:
    *
    * @return: void
    */
    Future<void> _getDoctors() async {
        this.utility.Custom_Print("START: _getDoctors");
        //Variables

        setState(() {
            this._isPageLoading = true;
        });
        
        
        this._productService.getDoctors()
        .then((value) {
            // Run extra code here
            utility.Custom_Print("Function Complete Successfully");
            utility.Custom_Print(value.toString());

            setState(() {
                this._isPageLoading = false;
                //this._state_id = 2;
                //this.mainDisplayState = 2;
                this._doctors = value;
            });
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

        this.utility.Custom_Print("STOP: _getDoctors");
    }


    /*
    * @Description: 
    *
    * @param:
    *
    * @return: void
    */
    Future<void> _getEmergency() async {
        this.utility.Custom_Print("START: _getEmergency");
        //Variables

        setState(() {
            this._isPageLoading = true;
        });
        
        
        this._productService.getEmergencies()
        .then((value) {
            // Run extra code here
            utility.Custom_Print("Function Complete Successfully");
            utility.Custom_Print(value.toString());

            setState(() {
                this._isPageLoading = false;
                //this._state_id = 2;
                //this.mainDisplayState = 2;
                this._emergencys = value;
            });
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

        this.utility.Custom_Print("STOP: _getEmergency");
    }
}
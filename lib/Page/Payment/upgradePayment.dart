import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:matchfinder/Model/packages.dart';
import 'package:matchfinder/Model/plans.dart';
import 'package:matchfinder/Page/Home/home.dart';
import 'package:matchfinder/Utilities/Common.dart';
import 'package:matchfinder/Utilities/Function/function.dart';
import 'package:matchfinder/Utilities/Function/url.dart';
import 'package:matchfinder/Utilities/style.dart';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:matchfinder/Utilities/Function/url.dart';


class UpgradePayment extends StatefulWidget {
  @override
  _UpgradePaymentState createState() => _UpgradePaymentState();
}

class _UpgradePaymentState extends State<UpgradePayment> {

String packageTitle='Silver';
String packagePrice = '';
List<String> check =['N','N','N'];
String  cartcurrency;
double totalcartprice;
List<Plans> plans= List<Plans>();
List<Packages> packages = List<Packages>();
List<Items> item = List<Items>();
List<dynamic> planList = [];
List<dynamic> addonList = [];
@override
  void initState() {
    // TODO: implement initState
    super.initState();

   getData();
   setState(() {
     
   });
  }
  bool isLoading = false;
  bool dataLoading = false;

 getPlansData() async {
    try {
      var value = getSession();
      if (value != null) {
        Response response = await getPlans();
        if (await response.data != null) {
          
          
         
          planList =  await response.data['plans'];
        
          
        }
      } else {
        print('No cache value');
        Navigator.pop(context);
      }
    } catch (e) {}
  }



  getData() async {
    try {
      setState(() {
      isLoading = true;
    });
      var value = getSession();
      if (value != null) {
        Response d = await getPlans();
        if (await d.data != null) {
        planList =  await d.data['plans'];
         
        
        setState(() {
          isLoading = false;
        });
        }
      } else {
        print('No cache value');
        Navigator.pop(context);
      }
    } catch (e) {}
  }


  delete(String link, query) async {
  Dio dio = Dio();
  var cookieJar = CookieJar();
  dio.interceptors.add(CookieManager(cookieJar));
  Response response = await dio.post(link, queryParameters: query);
 print(response);
  return response;
}
 update(String link, query) async {
  Dio dio = Dio();
  var cookieJar = CookieJar();
  dio.interceptors.add(CookieManager(cookieJar));
  Response response = await dio.post(link, queryParameters: query);
 print(response);
  return response;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
        backgroundColor: appColor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text('Upgrade to Premium'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
       
       ),
      body: isLoading
          ?
           Center(child: CircularProgressIndicator())
          :
          SingleChildScrollView (child: Stack(children: [
        Container(color:Colors.white),
        
        Container(
          height: MediaQuery.of(context).size.height/3,
          color:appColor),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
          children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                offersTab('B'),
                offersTab('E'),
                offersTab('S'),
                offersTab('G'),
                offersTab('D'),
                offersTab('P'),
             ],
            ),
           
                  
                 Container(height: 350,
                   margin: EdgeInsets.only(left:10,right: 10),
                    child: ListView.builder(
                                      itemCount: planList.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (BuildContext context, int index) {
                                        return   Container(
                    margin: EdgeInsets.all(20),
                    height: 350,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(width: 1,color: Colors.white,style: BorderStyle.solid),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                  child:   Container(
                          child: Stack(
                            children: [
                                // header
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child:   Column(
                                          children: [
                                            Text(planList[index][1],
                                            style: smallGreyTextStyle,
                                            ),
                                            SizedBox(height: 20,),
                                            Divider(
                                              height: 2,
                                              thickness: 2,
                                            )
                                          ],)
                                 
                                      
                                                                 
                                    )
                                        ),
                                 
                                // body
                                 Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    padding: EdgeInsets.all(25),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(planList[index][3].toString(),
                                        style: TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Text(planList[index][3].toString()+' per month',
                                        ),
                                        SizedBox(height: 10,),
                                        Container(
                                          height: 150,
                                          child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            itemCount: planList[index][2].length,
                                            itemBuilder: (BuildContext context, int i){
                                              return  Row(
                                          
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: planList[index][2][i][1]=='Y'?appColor:Colors.white,
                                            ),
                                            SizedBox(width: 5,),
                                            Text(planList[index][2][i][0].toString(),
                                        ),

                                          ],);
                                       
                                          }),)
                                        ],)
                                  ), // Your fixed Footer here,
                                ),
                                // footer
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                     padding: EdgeInsets.all(10),
                                    child:  MaterialButton(
                                      onPressed: ()  async {
                                        double total;
                                        print('de');
                                        setState(() {
                                          dataLoading = true;
                                         addonList.clear();

                                        });
                                        if(dataLoading==true){
                                           Center(child: CircularProgressIndicator());
                                        
                                        }
                                                 Response response = await getPaymentPackages();
                                            if (await response.data != null) {
                                              
                                              
                                              cartcurrency = await response.data['cartcurrency'] != null
                                                  ? await response.data['cartcurrency']
                                                  : '';
                                              totalcartprice = await response.data['totalcartprice'] != null
                                                  ? await response.data['totalcartprice']
                                                  : '';
                                            addonList = await response.data['plans'];
                                               total = totalcartprice;
                                             
                                            }
                                           
                                           
                                                showDialog(context: context,
                                          //barrierDismissible: false,
                                          
                                          builder: (BuildContext context){
                                            totalcartprice =totalcartprice;
                                          dataLoading = false;
                                            return  Stack(children: [
                                            Positioned(
                                            bottom: 0,
                                            child:
                                            
                                               Container(
                                              color: Colors.white,
                                              height: 300,
                                              width: MediaQuery.of(context).size.width,
                                              child: Scaffold(
                                                body:dataLoading==true?
                                                 Center(child: CircularProgressIndicator())
                                                : Column(
                                                children: [
                                                  //header
                                                  Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width,
                                                      padding:EdgeInsets.all(10),
                                                      color:Colors.grey[200],
                                                      child:Text('Order Summary',
                                                      style: headingBlackStyle)
                                                    ),
                                                  ),
                                                  SizedBox(height: 10,),
                                                  //body
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Container(
                                                      height: 200,
                                                      width: MediaQuery.of(context).size.width,
                                                      padding: EdgeInsets.all(10),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                            Text(planList[index][1].toString()),
                                                            Text(planList[index][3].toString()),
                                                          ]),
                                                          Container(
                                                            height: 100,
                                                            
                                                            child:ListView.builder(                                                  
                                                              itemCount: addonList.length,
                                                              scrollDirection: Axis.vertical,
                                                              itemBuilder: (BuildContext context, int addonindex) {
                                                                 return StatefulBuilder(builder: (context, StateSetter setState) {
                                                                    return Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                     Row(
                                                                       children: [
                                                                        GestureDetector(
                                                                          child:Icon(
                                                                            addonList[addonindex][4]=='N'?Icons.check_box_outline_blank:Icons.check_box,
                                                                            color: addonList[addonindex][4]=='N'?Colors.black:appColor,
                                                                            ),
                                                                          onTap: ()async{
                                                                        
                                                                            setState(() {
                                                                              dataLoading = true;
                                                                            });
                                                                              var response ;
                                                                              if(addonList[addonindex][4]=="N"){
                                                                                  response =  await update(
                                                                                UrlLinks.addons, {'addonno': addonList[addonindex][1]});
                                                                         
                                                                              }else if(addonList[addonindex][4]=="Y"){
                                                                                  response =  await delete(
                                                                                UrlLinks.addons, {'addonno': addonList[addonindex][1],'del':"yes"});
                                                                         
                                                                              }
                                                                              addonList.clear();
                                                                              cartcurrency = await response.data['cartcurrency'] != null
                                                                                    ? await response.data['cartcurrency']
                                                                                    : '';
                                                                              totalcartprice = await response.data['totalcartprice'] != null
                                                                                    ? await response.data['totalcartprice']
                                                                                    : '';
                                                                              addonList = await response.data['plans'];
           
                                                                        setState(() {
                                                                         total = totalcartprice;
                                                                          print(response.data);
                                                                         
                                                                          dataLoading = false;
                                                                          print(total);
                                                                        });
                                                                         
                                                                        },),
                                                                      SizedBox(width: 5),
                                                                      Text(addonList[addonindex][2]),
                                                                     ],),
                                                                     Text(addonList[addonindex][3])
                                                                    
                                                                    ],
                                                                  );                                           
                                                              });
                                                              }
                                                          )),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                            Text('Total Amount'),
                                                            Text('Rs.$total'),
                                                          ]),

          
                                                          
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                 //footer
                                                  Container(
                                                    child:Align(
                                                    alignment: Alignment.bottomCenter,
                                                    child: RaisedButton(
                                                      color: appColor,
                                                      onPressed: ()async{
                                                         await checkoutData(
                                                          UrlLinks.checkout);
                                                           changeScreen(context, Home());
                                                      },
                                                      child: Text('Proceed',style:miniWhiteTextStyle),),
                                                  )
                                                  ),
                                                ],)
                                            
                                              )
                                             )
                                         )
                                        
                                            ]
                                           );
                                            
                                            });
                       
      
                                           
                                         
                                      },
                                      color: appColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(23.0),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 14,
                                          horizontal: 40,
                                        ),
                                        child: Text(
                                          'Continue',
                                          textAlign: TextAlign.center,
                                          style: miniWhiteTextStyle,
                                        ),
                                      ),
                                    ),
                                   
                                  ), // Your fixed Footer here,
                                ),
                            ],) 
                    )  
                  
                                        
                                              ); // Your fixed Footer here,
                                      }) ,
            ),
             SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              padding: EdgeInsets.only(left:20,right: 20),
              child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 12,
                    itemBuilder: (BuildContext context, int index) =>
                        Card(
                          child: Column(
                            children: [
                              Container(
                                width: 130,
                                height: 100,
                              ),
                              Container(
                                width: 130,
                                
                                color: Colors.grey[200],
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 1,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                          Text('Sumera Raj'),
                                          Text('20hours'),
                                      ],),
                                      SizedBox(height: 5,),
                                    Text('Hindu'),
                                  ],
                                )

                              ),
                            ],
                          ),
                        ),
                  ),
            ),
            SizedBox(height: 20,),
            Container(
               padding: EdgeInsets.all(10),
               alignment: Alignment.center,
               child:Text('Contact Profiles Instantly after making the payment')
            ),
            SizedBox(height: 50,),
        ],)
        
        
        
      ],
      
    )
    )
  );
  }
  Widget offersTab(String title){
    return GestureDetector(
      child: Container(
                    margin: EdgeInsets.all(5),
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: title==title+'+'?Colors.white:appColor,
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(width: 1,color: Colors.white,style: BorderStyle.solid)
                    ),
                    child: Center(
                      child: Text(title,
                      style: TextStyle(
                        color: title==title+'+'?Colors.black:Colors.white,
                        fontSize: 14,
                        ),
                      ),
                    )
                  ),
      onTap: (){
        print(title);
         print(packages);
         print(item);  
        setState(() {
          if(title=='B'){
            packageTitle = 'Best';
          }
          if(title=='E'){
            packageTitle = 'Excellent';
          }
          if(title=='S'){
            packageTitle = 'Silver';
          }
          if(title=='G'){
            packageTitle = 'Gold';
          }
          if(title=='D'){
            packageTitle = 'Diamond';
          }
          if(title=='P'){
            packageTitle = 'Premium';
          }
          title=title+'+';
          
        });
      },);
          
    }



}


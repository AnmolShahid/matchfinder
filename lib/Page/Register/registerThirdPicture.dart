import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:matchfinder/Model/image.dart';
import 'package:matchfinder/Page/Home/home.dart';
import 'package:matchfinder/Utilities/Common.dart';
import 'package:matchfinder/Utilities/Function/function.dart';
import 'package:matchfinder/Utilities/Function/url.dart';
import 'package:matchfinder/Utilities/sharedWidget/text_field.dart';
import 'package:matchfinder/Utilities/style.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class RegisterThird extends StatefulWidget {
  @override
  _RegisterThirdState createState() => _RegisterThirdState();
}

class _RegisterThirdState extends State<RegisterThird> {
  final _key = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController caption = TextEditingController();
  bool isLoading = false;
  bool inProcess = false;
  bool inUploading = false;
  bool isFirstImage = true;
  File profileImage;
   Response response;
  double percentage = 0.0;
  List<Images> imagesList = List<Images>();
  bool upload=false;

  String buttonText='Upload atleast one photo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      key: _key,
      appBar: AppBar(
        shadowColor: appColor,
        backgroundColor: appColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Image.asset(
          'assets/logowhite.png',
          // width: 142,
          height: 50,
        ),
        actions: [
          Row(
            children: [
              roundCircle(
                '1',
                borderColorField,
                miniWhiteTextStyle,
              ),
              Container(
                width: 10,
                child: Divider(
                  color: borderColorField,
                  thickness: 2,
                ),
              ),
              roundCircle(
                '2',
                borderColorField,
                miniWhiteTextStyle,
              ),
              Container(
                width: 10,
                child: Divider(
                  color: borderColorField,
                  thickness: 2,
                ),
              ),
              roundCirclePresent(
                '3',
               white,
                miniGreyColorStyle,
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Add photos to your profile to get '
                          '20 times more response!',
                          textAlign: TextAlign.center,
                          style: miniGreyColorStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      color: borderColorField,
                      height: 276,
                      width: MediaQuery.of(context).size.width,
                      child: profileImage != null
                          ? Image.file(
                              profileImage,
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                            )
                          :    Container(
                                     
                                      width: MediaQuery.of(context).size.width,
                                      height: 150,
                                      child: Stack(
                                      children: <Widget>[
                                     Container(
                                       padding: EdgeInsets.only(top:50,left: 20,right:20,bottom: 20),
                                       child:    ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: imagesList.length,
                                        padding: EdgeInsets.only(left:5,right: 5),

                                        itemBuilder: (BuildContext context, int index) =>  GestureDetector(
                                                child: Column(children: [

                                                
                                                  Stack(
                                                    overflow: Overflow.visible,
                                                    children: [
                                                        imagesList.elementAt(index).profileImage=="Y"?Text('Profile Image'):Text(''),
                                                      Image.network(imagesList.elementAt(index).photoUrl,height: 150,width: 150,fit: BoxFit.fill,),
                                                    
                                                     Positioned(
                                                      top: 5,
                                                      right: 10,
                                                      child: GestureDetector(
                                                          onTap: () async {
                                                            await submitData(UrlLinks.photoProfileUrl,
                                                                                                      {'photoId': imagesList.elementAt(index).photoId});
                                                                                                        _key.currentState.showSnackBar(
                                                                                                        snackBar(
                                                                                                          'Updated as profile image',
                                                                                                          Colors.green,
                                                                                                          Icons.verified_user,
                                                                                                        ),
                                                                                                      );
                                                          },
                                                          child: Icon(
                                                         imagesList.elementAt(index).profileImage=="Y"
                                                         ?
                                                         Icons.check_circle 
                                                         :
                                                          Icons.select_all_outlined,
                                                          color:Colors.green
                                                      ),
                                                    ),
                                                    ),
  
                                                    
                                                  ]),
                                                  Text(imagesList.elementAt(index).caption.toString())
                                              ],),
                                              onTap: () async {
                                                  await submitData(UrlLinks.photoProfileUrl,
                                                       {'photoId': imagesList.elementAt(index).photoId});
                                                        _key.currentState.showSnackBar(
                                                        snackBar(
                                                          'Updated as profile image',
                                                          Colors.green,
                                                          Icons.verified_user,
                                                        ),
                                                      );
                                              }, )
                                             
                                              
                                              
                                              
                                            ),
                                     ), 
                                      imagesList.length!=0||imagesList.length!=null?
                                      Positioned(
                                        top:5,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: Center(
                                            child:Text(
                                              'Select one of them as a profile picture.'
                                              ),
                                          )
                                        ),)
                                      :Container(),
                                     
  ],
)
                                      
                                      ),
                                  
                                    
                                 
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 290,
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 30,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if(profileImage == null && percentage==0.0)
                                Expanded(
                                  child: Text(
                                    isFirstImage
                                        ? 'Upload your profile photo!'
                                        : 'Upload any other photo',
                                    textAlign: TextAlign.center,
                                    style: headingBlackStyle,
                                  ),
                                ),
                                if( percentage!=0.0)
                                Expanded(
                                                  child:
                                                      new LinearPercentIndicator(
                                                    animation: true,
                                                    lineHeight: 20.0,
                                                    animationDuration: 200,
                                                    percent: percentage,
                                                    center: Text(
                                                      (percentage+99).toStringAsFixed(1)+"%",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    linearStrokeCap:
                                                        LinearStrokeCap
                                                            .roundAll,
                                                    progressColor: appColor,
                                                  ),
                                                ),
                                             
                              ],
                            ),
                          ),
                          profileImage != null
                              ? Column(
                                  children: [
                                    //if( percentage==1.0)
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 30,
                                        // vertical: 40,
                                      ),
                                      child: TextFieldCustom(
                                        controller: caption,
                                        style: miniGreyTextStyle,
                                        labelText:
                                            'Say something about this photo...',
                                        inputType: TextInputType.text,
                                       
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    
                                    SizedBox(
                                      height: 30,
                                    ),
                                    isLoading
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : MaterialButton(
                                            onPressed: () async {
                                              if(percentage == 0.0){
                                                 response = await   uploadImage(profileImage);
                                                 isFirstImage
                                                  ? uploadImageDataBase(true)
                                                  : uploadImageDataBase(false);
                                             /* }else if(caption.text==""||caption.text==null){
                                                 _key.currentState.showSnackBar(
                                                          snackBar(
                                                            'Caption missing',
                                                            Colors.red,
                                                            Icons.security,
                                                          ),
                                                        );
                                             */
                                              }
                                              
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
                                                percentage == 1.0
                                                ?
                                                'Update Caption'
                                                :
                                                'Upload Photo',
                                                textAlign: TextAlign.center,
                                                style: miniWhiteTextStyle,
                                              ),
                                            ),
                                          ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        displayFolder(() {
                                          selectImage(ImgSource.Gallery);
                                        }, 'Other Folders',
                                            Icons.snippet_folder_rounded),
                                        displayFolder(() {
                                          selectImage(ImgSource.Camera);
                                        }, 'Take A Photo', Icons.folder),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 55,
                                    ),
                                     gender=="female"?MaterialButton(
                                      onPressed: () async {
                                        if(imagesList.length!=null||imagesList.length!=0){
                                          changeScreenReplacementUtils(
                                            context, Home());
                                        }else{

                                        }
                                        
                                   //  print(imagesList[0].caption);
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
                                          buttonText,
                                          textAlign: TextAlign.center,
                                          style: miniWhiteTextStyle,
                                        ),
                                      ),
                                    ):MaterialButton(
                                      onPressed: () async {
                                        changeScreenReplacementUtils(
                                            context, Home());
                                   //  print(imagesList[0].caption);
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
                                          'Complete Registration',
                                          textAlign: TextAlign.center,
                                          style: miniWhiteTextStyle,
                                        ),
                                      ),
                                    ),
                                    gender=="male"?FlatButton(onPressed: (){

                                    }, child: Text('Skip')):Container(child: Text('Upload atleast one photo'),),
                                   
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  displayFolder(GestureTapCallback onTap, String text, IconData iconData) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: borderColorField,
              ),
            ),
            padding: EdgeInsets.all(
              10,
            ),
            child: Icon(
              iconData,
              color: Color(0xFFF6B863),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: extraMiniGreyColorStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future selectImage(ImgSource source) async {
    setState(() {
      inProcess = true;
    });
    File image = await imagePicker(source);
    if (image != null) {
      File cropped = await cropImage(image);

      setState(() {
        profileImage = cropped;
        inProcess = false;
        
      });
     
    } else {
      setState(()  {
        inProcess = false;
     
      });
     
    }
  }

  cropImage(File image) {
    return ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      compressQuality: 100,
      maxWidth: 700,
      maxHeight: 700,

      compressFormat: ImageCompressFormat.jpg,
      iosUiSettings: IOSUiSettings(
        title: 'Crop Your Image',
      ),
      androidUiSettings: AndroidUiSettings(
        toolbarTitle:'Crop Your Image',
        toolbarColor: appColor,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false
      ),
    );
  }

  imagePicker(ImgSource source) {
    return ImagePickerGC.pickImage(
      context: context,
      source: source,
      galleryText: Text(
        'Gallery',
        style: TextStyle(color: appColor),
      ),
      cameraText: Text(
        'Camera',
        style: TextStyle(color: appColor),
      ),
      galleryIcon: Icon(
        Icons.photo,
        color: appColor,
      ),
      cameraIcon: Icon(
        Icons.camera_alt,
        color: appColor,
      ),
    );
  }

  uploadImage(File file) async {
    final getAppraisalsKey = UrlLinks.photoUploadUrl;
    var formData = FormData();
    formData.files.addAll([
      MapEntry(
        "photoid",
        MultipartFile.fromFileSync(
          file.path,
          filename: "upload.jpg",
        ),
      ),
    ]);
    Dio dio = Dio();
    var cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    Response response = await dio.post(
      getAppraisalsKey,
      data: formData,
      onSendProgress: (int send, int total) {
        setState(() {
          percentage = (send / total);
        });
        print((send / total));
      },
    );
    return response;
  }

  uploadImageDataBase(bool isProfile) async {
    if (_formKey.currentState.validate() && profileImage != null) {
      FocusScope.of(context).requestFocus(new FocusNode());
      setState(() {
        isLoading = true;
        inUploading = true;
      });
   //   Response response = await uploadImage(profileImage);
      if (response.data['photos'] != null) {
        await submitData(UrlLinks.photoCaptionUrl, {
          'photoId': response.data['photos'][0]['photoId'],
          'comments': caption.text,
          'caption':caption.text,
        });
        setState(() {
          imagesList.add(
          Images(
          proId:response.data['photos'][0]['proId'],
          photoId: response.data['photos'][0]['photoId'],
          photoUrl: response.data['photos'][0]['url'],
          profileImage: response.data['photos'][0]['profilePhoto'],
          caption: caption.text,
         ));
         buttonText = 'Complete Registration';
        print(imagesList.length);
       });
        if (isProfile) {
          await submitData(UrlLinks.photoProfileUrl,
              {'photoId': response.data['photos'][0]['photoId']});
        } else {
          print('Not profile');
        }
        _key.currentState.showSnackBar(
          snackBar(
            'Image uploaded',
            Colors.green,
            Icons.verified_user,
          ),
        );
        setState(() {
          profileImage = null;
          percentage = 0.0;
          caption.clear();
          isFirstImage = false;
          isLoading = false;
          inUploading = false;
        });
      }
    } else {
      _key.currentState.showSnackBar(
        snackBar(
          'Add image',
          Colors.red,
          Icons.security,
        ),
      );
    }
  }
}

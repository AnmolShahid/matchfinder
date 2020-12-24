import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
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
  double percentage = 0.0;

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
              roundCircle(
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
                          : Container(),
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
                                Expanded(
                                  child: Text(
                                    isFirstImage
                                        ? 'Upload your profile photo!'
                                        : 'Upload any other photo',
                                    textAlign: TextAlign.center,
                                    style: headingBlackStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          profileImage != null
                              ? Column(
                                  children: [
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
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter your caption';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    inUploading
                                        ? Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 30,
                                              horizontal: 20,
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child:
                                                      new LinearPercentIndicator(
                                                    animation: true,
                                                    lineHeight: 20.0,
                                                    animationDuration: 200,
                                                    percent: percentage,
                                                    center: Text(
                                                      percentage
                                                          .toStringAsFixed(1),
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
                                          )
                                        : Container(),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    isLoading
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : MaterialButton(
                                            onPressed: () async {
                                              isFirstImage
                                                  ? uploadImageDataBase(true)
                                                  : uploadImageDataBase(false);
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
                                                'Upload Image',
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
                                    MaterialButton(
                                      onPressed: () async {
                                        changeScreenReplacementUtils(
                                            context, Home());
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
      setState(() {
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
        title: Common.appName + ' Cropper',
      ),
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: Common.appName + ' Cropper',
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
      Response response = await uploadImage(profileImage);
      if (response.data['photos'] != null) {
        await submitData(UrlLinks.photoCaptionUrl, {
          'photoId': response.data['photos'][0]['photoId'],
          'caption': '',
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

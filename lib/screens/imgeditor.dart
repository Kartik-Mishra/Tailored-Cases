import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../modules/all_emojies.dart';
import '../modules/bottombar_container.dart';
import '../modules/colors_picker.dart';
import '../modules/emoji.dart';
import '../modules/text.dart';
import '../modules/textview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:signature/signature.dart';
import 'package:dotted_border/dotted_border.dart';

TextEditingController heightcontroler = TextEditingController();
TextEditingController widthcontroler = TextEditingController();
var width = 250;
var height = 300;

List fontsize = [];
var howmuchwidgetis = 0;
List multiwidget = [];
Color currentcolors = Colors.white;
var opicity = 0.0;
SignatureController _controller =
    SignatureController(penStrokeWidth: 5, penColor: Colors.green);

class Customizer extends StatefulWidget {
  final Color appBarColor;
  final Color bottomBarColor;
  Customizer({this.appBarColor, this.bottomBarColor});

  @override
  _CustomizerState createState() => _CustomizerState();
}

var slider = 0.0;

class _CustomizerState extends State<Customizer> {
  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
    var points = _controller.points;
    _controller =
        SignatureController(penStrokeWidth: 5, penColor: color, points: points);
  }

  List<Offset> offsets = [];
  Offset offset1 = Offset.zero;
  Offset offset2 = Offset.zero;
  final scaf = GlobalKey<ScaffoldState>();
  var openbottomsheet = false;
  List<Offset> _points = <Offset>[];
  List type = [];
  List aligment = [];

  final GlobalKey container = GlobalKey();
  final GlobalKey globalKey = new GlobalKey();
  File _image;
  ScreenshotController screenshotController = ScreenshotController();
  Timer timeprediction;
  void timers() {
    Timer.periodic(Duration(milliseconds: 10), (tim) {
      setState(() {});
      timeprediction = tim;
    });
  }

  @override
  void dispose() {
    timeprediction.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    timers();
    _controller.clear();
    type.clear();
    fontsize.clear();
    offsets.clear();
    multiwidget.clear();
    howmuchwidgetis = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        key: scaf,
        /* appBar: new AppBar(
          actions: <Widget>[
            new IconButton(
                icon: Icon(FontAwesomeIcons.boxes),
                onPressed: () {
                  showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: new Text("Select Height Width"),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  setState(() {
                                    height = int.parse(heightcontroler.text);
                                    width = int.parse(widthcontroler.text);
                                  });
                                  heightcontroler.clear();
                                  widthcontroler.clear();
                                  Navigator.pop(context);
                                },
                                child: new Text("Done"))
                          ],
                          content: new SingleChildScrollView(
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text("Define Height"),
                                new SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                    controller: heightcontroler,
                                    keyboardType:
                                        TextInputType.numberWithOptions(),
                                    decoration: InputDecoration(
                                        hintText: 'Height',
                                        contentPadding:
                                            EdgeInsets.only(left: 10),
                                        border: OutlineInputBorder())),
                                new SizedBox(
                                  height: 10,
                                ),
                                new Text("Define Width"),
                                new SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                    controller: widthcontroler,
                                    keyboardType:
                                        TextInputType.numberWithOptions(),
                                    decoration: InputDecoration(
                                        hintText: 'Width',
                                        contentPadding:
                                            EdgeInsets.only(left: 10),
                                        border: OutlineInputBorder())),
                              ],
                            ),
                          ),
                        );
                      });
                }),
            new IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  _controller.points.clear();
                  setState(() {});
                }),
            new IconButton(
                icon: Icon(Icons.camera),
                onPressed: () {
                  bottomsheets();
                }),
            new FlatButton(
                child: new Text("Done"),
                textColor: Colors.white,
                onPressed: () {
                  File _imageFile;
                  _imageFile = null;
                  screenshotController
                      .capture(
                          delay: Duration(milliseconds: 500), pixelRatio: 1.5)
                      .then((File image) async {
                    //print("Capture Done");
                    setState(() {
                      _imageFile = image;
                    });
                    final paths = await getExternalStorageDirectory();
                    image.copy(paths.path +
                        '/' +
                        DateTime.now().millisecondsSinceEpoch.toString() +
                        '.png');
                    Navigator.pop(context, image);
                  }).catchError((onError) {
                    print(onError);
                  });
                }),
          ],
          backgroundColor: widget.appBarColor,
        ),*/
        body: Center(
          child: Screenshot(
            controller: screenshotController,
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                OverflowBox(
                  minWidth: 0.0,
                  minHeight: 0.0,
                  maxWidth: double.infinity,
                  maxHeight: double.infinity,
                  child: new Image.asset(
                    "images/oie_transparent.png",
                    height: 600,
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.all(0),
                    color: Colors.transparent,
                    width: width.toDouble(),
                    height: height.toDouble(),
                    child: DottedBorder(
                      color: Colors.white,
                      strokeWidth: 1,
                      strokeCap: StrokeCap.round,
                      dashPattern: [1, 10],
                      child: RepaintBoundary(
                        key: globalKey,
                        child: Stack(
                          overflow: Overflow.clip,
                          children: <Widget>[
                            _image != null
                                ? Image.file(
                                    _image,
                                    height: height.toDouble(),
                                    width: width.toDouble(),
                                    fit: BoxFit.cover,
                                  )
                                : Container(),
                            //------------------------Enables brush-----------------------------------
                            // Container(
                            //   child: GestureDetector(
                            //       onPanUpdate: (DragUpdateDetails details) {
                            //         setState(() {
                            //           RenderBox object =
                            //               context.findRenderObject();
                            //           Offset _localPosition =
                            //               object.globalToLocal(
                            //                   details.globalPosition);
                            //           _points = new List.from(_points)
                            //             ..add(_localPosition);
                            //         });
                            //       },
                            //       onPanEnd: (DragEndDetails details) {
                            //         _points.add(null);
                            //       },
                            //       child: Signat()),
                            // ),
                            Stack(
                              overflow: Overflow.clip,
                              children:
                                  // <Widget>[Container()] +      //remove containner ---------------------
                                  multiwidget.asMap().entries.map((f) {
                                return type[f.key] == 1
                                    ? EmojiView(
                                        left: offsets[f.key].dx,
                                        top: offsets[f.key].dy,
                                        ontap: () {
                                          print(offsets[f.key].toString());

                                          scaf.currentState
                                              .showBottomSheet((context) {
                                            return Sliders(
                                              size: f.key,
                                              sizevalue:
                                                  fontsize[f.key].toDouble(),
                                            );
                                          });
                                        },
                                        onpanupdate: (details) {
                                          setState(() {
                                            if ((offsets[f.key].dy +
                                                    details.delta.dy) >
                                                (height.toDouble() -
                                                    fontsize[f.key]
                                                        .toDouble())) {
                                              offsets[f.key] = Offset(
                                                  offsets[f.key].dx,
                                                  height.toDouble() -
                                                      fontsize[f.key]
                                                          .toDouble());
                                            }
                                            if (offsets[f.key].dy +
                                                    details.delta.dy <
                                                0.0) {
                                              offsets[f.key] =
                                                  Offset(offsets[f.key].dx, 0);
                                            }
                                            if ((offsets[f.key].dx +
                                                    details.delta.dx) >
                                                (width.toDouble() -
                                                    Image.file(f.value).width/Image.file(f.value).height*fontsize[f.key]
                                                          .toDouble())) {
                                              offsets[f.key] = Offset(
                                                  (width.toDouble() -
                                                      fontsize[f.key]
                                                          .toDouble()),
                                                  offsets[f.key].dy);
                                            }
                                            if ((offsets[f.key].dx +
                                                    details.delta.dx) <
                                                0.0) {
                                              offsets[f.key] =
                                                  Offset(0, offsets[f.key].dy);
                                            } else {
                                              offsets[f.key] = Offset(
                                                  offsets[f.key].dx +
                                                      details.delta.dx,
                                                  offsets[f.key].dy +
                                                      details.delta.dy);
                                            }
                                          });

                                          print(offsets[f.key].toString());
                                        },
                                        value: Image.file(f.value),
                                        fontsize: fontsize[f.key].toDouble(),
                                        align: TextAlign.center,
                                      )
                                    : type[f.key] == 2
                                        ? TextView(
                                            left: offsets[f.key].dx,
                                            top: offsets[f.key].dy,
                                            ontap: () {
                                              scaf.currentState
                                                  .showBottomSheet((context) {
                                                return Sliders(
                                                  size: f.key,
                                                  sizevalue: fontsize[f.key]
                                                      .toDouble(),
                                                );
                                              });
                                            },
                                            onpanupdate: (details) {
                                              setState(() {
                                                if ((offsets[f.key].dy +
                                                        details.delta.dy) >
                                                    (height.toDouble() -
                                                        fontsize[f.key]
                                                            .toDouble())) {
                                                  offsets[f.key] = Offset(
                                                      offsets[f.key].dx,
                                                      height.toDouble() -
                                                          fontsize[f.key]
                                                              .toDouble());
                                                }
                                                if (offsets[f.key].dy +
                                                        details.delta.dy <
                                                    0.0) {
                                                  offsets[f.key] = Offset(
                                                      offsets[f.key].dx, 0);
                                                }
                                                if ((offsets[f.key].dx +
                                                        details.delta.dx) >
                                                    (width.toDouble() -
                                                        fontsize[f.key]
                                                            .toDouble())) {
                                                  offsets[f.key] = Offset(
                                                      (width.toDouble() -
                                                          fontsize[f.key]
                                                              .toDouble()),
                                                      offsets[f.key].dy);
                                                }
                                                if ((offsets[f.key].dx +
                                                        details.delta.dx) <
                                                    0.0) {
                                                  offsets[f.key] = Offset(
                                                      0, offsets[f.key].dy);
                                                } else {
                                                  offsets[f.key] = Offset(
                                                      offsets[f.key].dx +
                                                          details.delta.dx,
                                                      offsets[f.key].dy +
                                                          details.delta.dy);
                                                }
                                              });
                                            },
                                            value: f.value,
                                            fontsize:
                                                fontsize[f.key].toDouble(),
                                            align: TextAlign.center,
                                          )
                                        : new Container();
                              }).toList(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: openbottomsheet
            ? new Container()
            : Container(
                decoration: BoxDecoration(
                    color: widget.bottomBarColor,
                    boxShadow: [BoxShadow(blurRadius: 10.9)]),
                height: 70,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    /*
                    BottomBarContainer(
                      colors: widget.bottomBarColor,
                      icons: FontAwesomeIcons.brush,
                      ontap: () {
                        // raise the [showDialog] widget
                        showDialog(
                            context: context,
                            child: AlertDialog(
                              title: const Text('Pick a color!'),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: pickerColor,
                                  onColorChanged: changeColor,
                                  showLabel: true,
                                  pickerAreaHeightPercent: 0.8,
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: const Text('Got it'),
                                  onPressed: () {
                                    setState(() => currentColor = pickerColor);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ));
                      },
                      title: 'Brush',
                    ),*/
                    IconButton(
                      icon: Icon(
                        Icons.format_color_text,
                      ),
                      onPressed: () async {
                        final value = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TextEditor()));
                        if (value.toString().isEmpty) {
                          print("true");
                        } else {
                          type.add(2);
                          fontsize.add(20);
                          offsets.add(Offset.zero);
                          multiwidget.add(value);
                          howmuchwidgetis++;
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        _controller.clear();
                        type.clear();
                        fontsize.clear();
                        offsets.clear();
                        multiwidget.clear();
                        howmuchwidgetis = 0;
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.sentiment_satisfied),
                      onPressed: () async {
                        // final value =
                        //     "https://cdn.iconscout.com/icon/premium/png-256-thumb/car-1549817-1313237.png";

                        type.add(1);
                        fontsize.add(20);
                        offsets.add(Offset.zero);
                        //   multiwidget.add(value);    need to uncomment
                        howmuchwidgetis++;
                      },
                    ),
                    new IconButton(
                        icon: Icon(Icons.add_photo_alternate),
                        onPressed: ()
                            //{bottomsheets();
                            async {
                          var image = await ImagePicker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            var decodedImage = await decodeImageFromList(
                                image.readAsBytesSync());

                            setState(() {
                              // height = 150;
                              //  width = 150;
                              type.add(1);
                              fontsize.add(20);
                              offsets.add(Offset.zero);
                                 multiwidget.add(image);    
                              howmuchwidgetis++;

                             // _image = image;
                            });
                          }
                          // setState(() => _controller.clear());
                        }),
                    new IconButton(
                        icon: Icon(Icons.done),
                        onPressed: () {
                          File _imageFile;
                          _imageFile = null;
                          screenshotController
                              .capture(
                                  delay: Duration(milliseconds: 500),
                                  pixelRatio: 1.5)
                              .then((File image) async {
                            //print("Capture Done");
                            setState(() {
                              _imageFile = image;
                            });
                            final paths = await getExternalStorageDirectory();
                            image.copy(paths.path +
                                '/' +
                                DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString() +
                                '.png');
                            Navigator.pop(context, image);
                          }).catchError((onError) {
                            print(onError);
                          });
                        }),
                  ],
                ),
              ));
  }

  void bottomsheets() {
    openbottomsheet = true;
    setState(() {});
    Future<void> future = showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return new Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(blurRadius: 10.9, color: Colors.grey[400])
          ]),
          height: 170,
          child: new Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: new Text("Select Image Options"),
              ),
              Divider(
                height: 1,
              ),
              new Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.photo_library),
                                  onPressed: () async {
                                    var image = await ImagePicker.pickImage(
                                        source: ImageSource.gallery);
                                    if (image != null) {
                                      var decodedImage =
                                          await decodeImageFromList(
                                              image.readAsBytesSync());

                                      setState(() {
                                        height = decodedImage.height;
                                        width = decodedImage.width;
                                        _image = image;
                                      });
                                    }
                                    setState(() => _controller.clear());
                                    Navigator.pop(context);
                                  }),
                              SizedBox(width: 10),
                              Text("Open Gallery")
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 24),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.camera_alt),
                                onPressed: () async {
                                  var image = await ImagePicker.pickImage(
                                      source: ImageSource.camera);
                                  var decodedImage = await decodeImageFromList(
                                      image.readAsBytesSync());

                                  setState(() {
                                    height = decodedImage.height;
                                    width = decodedImage.width;
                                    _image = image;
                                  });
                                  setState(() => _controller.clear());
                                  Navigator.pop(context);
                                }),
                            SizedBox(width: 10),
                            Text("Open Camera")
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
    future.then((void value) => _closeModal(value));
  }

  void _closeModal(void value) {
    openbottomsheet = false;
    setState(() {});
  }
}

class Signat extends StatefulWidget {
  @override
  _SignatState createState() => _SignatState();
}

class _SignatState extends State<Signat> {
  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print("Value changed"));
  }

  @override
  Widget build(BuildContext context) {
    return //SIGNATURE CANVAS
        //SIGNATURE CANVAS
        ListView(
      children: <Widget>[
        Signature(
            controller: _controller,
            height: height.toDouble(),
            width: width.toDouble(),
            backgroundColor: Colors.transparent),
      ],
    );
  }
}

class Sliders extends StatefulWidget {
  final int size;
  final sizevalue;
  const Sliders({Key key, this.size, this.sizevalue}) : super(key: key);
  @override
  _SlidersState createState() => _SlidersState();
}

class _SlidersState extends State<Sliders> {
  @override
  void initState() {
    slider = widget.sizevalue;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: new Text("Slider Size"),
            ),
            Divider(
              height: 1,
            ),
            new Slider(
                value: slider,
                min: 0.0,
                max: 100.0,
                onChangeEnd: (v) {
                  setState(() {
                    fontsize[widget.size] = v.toInt();
                  });
                },
                onChanged: (v) {
                  setState(() {
                    slider = v;
                    print(v.toInt());
                    fontsize[widget.size] = v.toInt();
                  });
                }),
          ],
        ));
  }
}

class ColorPiskersSlider extends StatefulWidget {
  @override
  _ColorPiskersSliderState createState() => _ColorPiskersSliderState();
}

class _ColorPiskersSliderState extends State<ColorPiskersSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 260,
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: new Text("Slider Filter Color"),
          ),
          Divider(
            height: 1,
          ),
          SizedBox(height: 20),
          new Text("Slider Color"),
          SizedBox(height: 10),
          BarColorPicker(
              width: 300,
              thumbColor: Colors.white,
              cornerRadius: 10,
              pickMode: PickMode.Color,
              colorListener: (int value) {
                setState(() {
                  //  currentColor = Color(value);
                });
              }),
          SizedBox(height: 20),
          new Text("Slider Opicity"),
          SizedBox(height: 10),
          Slider(value: 0.1, min: 0.0, max: 1.0, onChanged: (v) {})
        ],
      ),
    );
  }
}

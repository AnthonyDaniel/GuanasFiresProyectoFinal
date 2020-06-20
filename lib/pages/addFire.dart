import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guanasfires/models/fire.dart';
import 'package:guanasfires/pages/map_add_fire.dart';
import 'package:guanasfires/services/auth_services/sign_in.dart';
import 'package:guanasfires/services/fireService.dart';
import 'package:guanasfires/theme/colors/light_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:progress_indicators/progress_indicators.dart';
import 'package:video_player/video_player.dart';

String uploadedFileURLImage;
String uploadedFileURLVideo;

class AddFire extends StatefulWidget {
  BuildContext contextModal;
  AddFire(BuildContext context) {
    contextModal = context;
  }
  @override
  _AddFireState createState() => _AddFireState(contextModal);
}

class _AddFireState extends State<AddFire> {
  BuildContext contextModal;

  _AddFireState(BuildContext context) {
    contextModal = context;
  }

  FireService fireService = new FireService();

  VideoPlayerController _controller;

  File _image = null;
  File _video = null;

  String _opcionSeleccionadaCanton;
  String _opcionSeleccionadaDistrito;

  int _severidad = 1;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: LightColors.kLightWhite,
        body: SingleChildScrollView(
            child: Stack(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new ListTile(
                  leading: const Icon(Icons.location_searching),
                  title: Text('Tu ubicación actual',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13.0)),
                  subtitle: Column(
                    children: <Widget>[
                      Container(
                        height: 170, //MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Map(),
                      ),
                      Text('En esta ubicación se reportara el incendio (*)',
                          style: new TextStyle(fontSize: 9.0)),
                    ],
                  ),
                ),
                new ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text('Selecciona el cantón',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13.0)),
                  subtitle: new DropdownButton(
                    value: _opcionSeleccionadaCanton,
                    items: getOpcionesCantones(),
                    onChanged: (opt) {
                      setState(() {
                        _opcionSeleccionadaCanton = opt;
                        _opcionSeleccionadaDistrito = null;
                      });
                    },
                  ),
                ),
                new ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text('Selecciona el distrito',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13.0)),
                  subtitle: DropdownButton(
                    value: _opcionSeleccionadaDistrito,
                    items: getOpcionesDistrito(),
                    onChanged: (opt) {
                      setState(() {
                        _opcionSeleccionadaDistrito = opt;
                      });
                    },
                  ),
                ),
                new ListTile(
                  leading: const Icon(Icons.info),
                  title: Text('Seleciona la severidad',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13.0)),
                  subtitle: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Radio(
                        value: 1,
                        groupValue: _severidad,
                        onChanged: _changeSeveridad,
                      ),
                      new Text(
                        'Baja',
                        style: new TextStyle(fontSize: 9.0),
                      ),
                      new Radio(
                        value: 2,
                        groupValue: _severidad,
                        onChanged: _changeSeveridad,
                      ),
                      new Text(
                        'Media',
                        style: new TextStyle(
                          fontSize: 9.0,
                        ),
                      ),
                      new Radio(
                        value: 3,
                        groupValue: _severidad,
                        onChanged: _changeSeveridad,
                      ),
                      new Text(
                        'Alta',
                        style: new TextStyle(fontSize: 9.0),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 1.0,
                ),
                new ListTile(
                  leading: const Icon(Icons.photo),
                  title: Text('Multimedia',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13.0)),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _image == null
                          ? RaisedButton(
                              colorBrightness: Brightness.dark,
                              splashColor: LightColors.kLavender,
                              child: Icon(Icons.camera),
                              onPressed: chooseFileImage,
                              color: Colors.cyan,
                            )
                          : Container(
                              child: uploadedFileURLImage != null
                                  ? Text(
                                      "Imagen cargada con exito",
                                      style: new TextStyle(fontSize: 8),
                                    )
                                  : JumpingDotsProgressIndicator(
                                      fontSize: 13.0,
                                    )),
                      _video == null
                          ? RaisedButton(
                              colorBrightness: Brightness.dark,
                              splashColor: LightColors.kLavender,
                              child: Icon(Icons.videocam),
                              onPressed: chooseFileVideo,
                              color: Colors.cyan,
                            )
                          : Container(
                              child: uploadedFileURLVideo != null
                                  ? Text(
                                      "Video cargado con exito",
                                      style: new TextStyle(fontSize: 8),
                                    )
                                  : JumpingDotsProgressIndicator(
                                      fontSize: 13.0,
                                    )),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 250,
                        margin: const EdgeInsets.only(top: 8),
                        child: RaisedButton(
                          colorBrightness: Brightness.dark,
                          splashColor: LightColors.kLightWhite,
                          child: Text("Añadir incendio"),
                          onPressed: () {
                            addFire();
                          },
                          color: Colors.cyan,
                        )),
                  ],
                )
              ],
            ),
          ],
        )));
  }

  void _alertErrorGeneral(String txt) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(txt),
            actions: <Widget>[
              RaisedButton(
                child: Text(
                  "CERRAR",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _alertExitoGeneral(String txt) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text("Exito"),
            content: Text(txt),
            actions: <Widget>[
              RaisedButton(
                child: Text(
                  "CERRAR",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(contextModal).pop();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _changeSeveridad(int i) {
    setState(() {
      _severidad = i;
    });
  }

//dropdownCantones.dart
  List<DropdownMenuItem<String>> getOpcionesCantones() {
    List<DropdownMenuItem<String>> lista = new List();
    cantones.forEach((element) {
      if (element.codProvi == "5") {
        lista.add(DropdownMenuItem(
          child: Text(element.descripcion),
          value: element.descripcion,
        ));
      }
    });
    return lista;
  }

//dropdownDistrito
  List<DropdownMenuItem<String>> getOpcionesDistrito() {
    List<DropdownMenuItem<String>> lista = new List();

    String codCanton;

    cantones.forEach((element) {
      if (element.descripcion == _opcionSeleccionadaCanton) {
        codCanton = element.codigo;
      }
    });
    distritos.forEach((distrito) {
      if (distrito.codProvi == "5" && distrito.codCant == codCanton) {
        lista.add(DropdownMenuItem(
          child: Text(distrito.descripcion),
          value: distrito.descripcion,
        ));
      }
    });
    return lista;
  }

  Future chooseFileImage() async {
    await ImagePicker.pickImage(source: ImageSource.camera).then((image) {
      setState(() {
        _image = image;
        uploadFileImage();
      });
    });
  }

  Future chooseFileVideo() async {
    await ImagePicker.pickVideo(source: ImageSource.camera).then((video) {
      setState(() {
        _video = video;
        uploadFileVideo();
      });
    });
  }

  Future uploadFileImage() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('guanasfires/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded (Image)');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        uploadedFileURLImage = fileURL;
      });
    });
  }

  Future uploadFileVideo() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('guanasfires/${Path.basename(_video.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_video);
    await uploadTask.onComplete;
    print('File Uploaded (Video)');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        uploadedFileURLVideo = fileURL;
      });
    });
  }

  Future addFire() async {
    //fireService.addNewFire(null);
    print(currentLocation.latitude);
    print(currentLocation.longitude);

    if (currentLocation.latitude != 0) {
      if (_opcionSeleccionadaCanton != null) {
        if (_opcionSeleccionadaDistrito != null) {
          if (uploadedFileURLImage != null || uploadedFileURLVideo != null) {
            var now = new DateTime.now();

            Fire fire = new Fire(
                _opcionSeleccionadaCanton,
                _opcionSeleccionadaDistrito,
                _severidad,
                now.toIso8601String(),
                currentLocation.latitude,
                currentLocation.longitude,
                email,
                uploadedFileURLImage,
                uploadedFileURLVideo);
            print(fire.toJson());
            _alertExitoGeneral("Se ha agregado correctamente el incendio");
            fireService.addNewFire(fire);
          } else {
            _alertErrorGeneral(
                "Debe incluir una foto o una imagen, no lo puedes omitir");
          }
        } else {
          _alertErrorGeneral("Debes de seleccionar un distrito");
        }
      } else {
        _alertErrorGeneral("Debes de seleccionar un cantón");
      }
    } else {
      _alertErrorGeneral(
          "Debes habilitar el gps en tu dispositivo, de lo contrario no sabremos exactamente donde esta el incendio");
    }
  }
}

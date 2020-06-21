import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guanasfires/models/fire.dart';
import 'package:guanasfires/pages/map_add_fire.dart';
import 'package:guanasfires/pages/map_home.dart';
import 'package:guanasfires/services/auth_services/sign_in.dart';
import 'package:guanasfires/services/fireService.dart';
import 'package:guanasfires/theme/colors/light_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:progress_indicators/progress_indicators.dart';
import 'package:video_player/video_player.dart';

String uploadedFileURLImage;
String uploadedFileURLVideo;

class EditFire extends StatefulWidget {
  BuildContext contextModal;
  EditFire(BuildContext context) {
    contextModal = context;
  }
  @override
  _EditFireState createState() => _EditFireState(contextModal);
}

class _EditFireState extends State<EditFire> {
  BuildContext contextModal;

  FireService fireService = new FireService();

  VideoPlayerController _controller;

  bool state = false;

  File _image = null;
  File _video = null;

  String _opcionSeleccionadaCanton;
  String _opcionSeleccionadaDistrito;

  int _severidad = 1;

  _EditFireState(BuildContext context) {
    print(fireModalM.toJson());
    uploadedFileURLImage = fireModalM.urlImage;
    uploadedFileURLVideo = fireModalM.urlVideo;
    _opcionSeleccionadaCanton = fireModalM.canton;
    _opcionSeleccionadaDistrito = fireModalM.district;
    _severidad = fireModalM.severity;

    state = fireModalM.state;

    contextModal = context;
  }

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
                  leading: const Icon(Icons.access_time),
                  title: Text('Fecha con hora',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13.0)),
                  subtitle: Text(fireModalM.date,
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 9.0)),
                ),
                new ListTile(
                  leading: const Icon(Icons.photo),
                  title: Text('Imagen',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13.0)),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          child: uploadedFileURLImage != null
                              ? Image.network(
                                  uploadedFileURLImage,
                                  width: 90.0,
                                  height: 120.0,
                                )
                              : JumpingDotsProgressIndicator(
                                  fontSize: 13.0,
                                )),
                      Container(
                          child: uploadFileVideo() != null
                              ? VideoPlayerScreen()
                              : JumpingDotsProgressIndicator(
                                  fontSize: 13.0,
                                ))
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
                  leading: const Icon(Icons.info),
                  title: Text('Seleciona la severidad',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13.0)),
                  subtitle: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Radio(
                        value: false,
                        groupValue: state,
                        onChanged: _changeState,
                      ),
                      new Text(
                        'Apagado',
                        style: new TextStyle(fontSize: 9.0),
                      ),
                      new Radio(
                        value: true,
                        groupValue: state,
                        onChanged: _changeState,
                      ),
                      new Text(
                        'Activo',
                        style: new TextStyle(
                          fontSize: 9.0,
                        ),
                      ),
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
                          child: Text("Editar incendio"),
                          onPressed: () {
                            print("Holaaaaaaa");

                            Navigator.of(contextModal).pop();

                            Fluttertoast.showToast(
                                msg: "Se ha editado correctamente",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            //var now = new DateTime.now();
                            Fire fire = new Fire(
                                _opcionSeleccionadaCanton,
                                _opcionSeleccionadaDistrito,
                                _severidad,
                                "now.toIso8601String()",
                                currentLocation.latitude,
                                currentLocation.longitude,
                                fireModalM.email,
                                uploadedFileURLImage,
                                uploadedFileURLVideo,
                                state);

                            fireService.updateFire(fireModalM.key, fire);
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

  void _changeState(bool i) {
    setState(() {
      state = i;
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

  editFire() {
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
                uploadedFileURLVideo,
                state);

            _alertExitoGeneral("Se ha modificado correctamente el incendio");
            fireService.updateFire(fireModalM.key, fire);
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

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({Key key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Crear y almacenar el VideoPlayerController. El VideoPlayerController
    // ofrece distintos constructores diferentes para reproducir videos desde assets, archivos,
    // o internet.
    _controller = VideoPlayerController.network(
      uploadedFileURLVideo,
    );

    // Inicializa el controlador y almacena el Future para utilizarlo luego
    _initializeVideoPlayerFuture = _controller.initialize();

    // Usa el controlador para hacer un bucle en el vídeo
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // Asegúrate de despachar el VideoPlayerController para liberar los recursos
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: 90,
            height: 100,
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // Si el VideoPlayerController ha finalizado la inicialización, usa
                  // los datos que proporciona para limitar la relación de aspecto del VideoPlayer
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    // Usa el Widget VideoPlayer para mostrar el vídeo
                    child: VideoPlayer(_controller),
                  );
                } else {
                  // Si el VideoPlayerController todavía se está inicializando, muestra un
                  // spinner de carga
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          RaisedButton(
            colorBrightness: Brightness.dark,
            splashColor: LightColors.kLightWhite,
            child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
            onPressed: () {
// Envuelve la reproducción o pausa en una llamada a `setState`. Esto asegura
// que se muestra el icono correcto
              setState(() {
// Si el vídeo se está reproduciendo, pausalo.
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  // Si el vídeo está pausado, reprodúcelo
                  _controller.play();
                }
              });
            },
          )
        ],
      ),
    );
  }
}

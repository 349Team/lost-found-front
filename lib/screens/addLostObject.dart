import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:teste/data/lost_object_t1.dart';
import 'package:teste/services/api.dart';

class AddLostObject extends StatefulWidget {
  const AddLostObject({Key? key}) : super(key: key);

  @override
  _AddLostObjectState createState() => _AddLostObjectState();
}

class _AddLostObjectState extends State<AddLostObject> {
  var snackBarSuccess = const SnackBar(
    content: Text(
      'Objeto cadastrado com sucesso.',
      style: TextStyle(fontSize: 17),
    ),
    backgroundColor: Colors.blue,
  );

  var snackBarError = const SnackBar(
    content: Text(
      'Não foi possível fazer o cadastro.',
      style: TextStyle(fontSize: 17),
    ),
    backgroundColor: Colors.red,
  );
  bool _isSnackbarActive = false;
  final _form = GlobalKey<FormState>();
  String teste = "";
  XFile? pickedFile;

  var _newItem = Objeto(
    id: 0,
    image: '',
    status: 'FOUND',
    title: '',
    description: '',
    type: 'FOUND',
    location: '',
    owner: 0,
    discoverer: 0,
  );

  final List<String> _status = ['Achado', 'Perdido'];
  String _selectedStatus = 'Achado';

  bool _submitted = false;

  @override
  void dispose() {
    super.dispose();
  }

  Future pickImage(ImageSource source) async {
    try {
      pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile == null) {
        return;
      }
      setState(() {
        teste = pickedFile!.path;
      });
    } on PlatformException catch (e) {
      print('failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Nova publicação'),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              if (_form.currentState!.validate()) {
                _form.currentState!.save();
                SimpleResponse resultado =
                    await registerObject(_newItem, pickedFile);
                setState(() => _submitted = true);
                if (resultado == SimpleResponse.error) {
                  if (!_isSnackbarActive) {
                    _isSnackbarActive = true;
                    ScaffoldMessenger.of(context)
                        .showSnackBar(snackBarError)
                        .closed
                        .then(
                          (SnackBarClosedReason reason) =>
                              {_isSnackbarActive = false},
                        );
                  }
                } else {
                  await Future.delayed(const Duration(milliseconds: 50));
                  ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess);
                  Navigator.of(context).pop();
                }
              }
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        actions: <Widget>[
                          SizedBox(
                            width: double.infinity,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton.icon(
                                onPressed: () {
                                  pickImage(ImageSource.camera);
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(Icons.camera_alt),
                                label: const Text('Tire uma foto'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton.icon(
                                onPressed: () {
                                  pickImage(ImageSource.gallery);
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(Icons.upload_file),
                                label: const Text('Escolha da galeria'),
                              ),
                            ),
                          ),
                        ],
                        actionsAlignment: MainAxisAlignment.center,
                        actionsPadding: const EdgeInsets.all(8),
                      ),
                    ),
                    child: Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(
                        top: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: teste.isEmpty
                          ? const Icon(Icons.upload_file)
                          : FittedBox(
                              child: Image.network(
                                File(pickedFile!.path).path,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Titulo'),
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (title) {
                        if (title!.isEmpty) {
                          return 'Preencha o campo de titulo';
                        }
                        return null;
                      },
                      onChanged: (text) => setState(() {
                        _newItem.title = text;
                      }),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                items: _status
                    .map(
                      (e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
                onChanged: (status) => setState(
                  () {
                    _selectedStatus = status!;
                    _newItem.status = status;
                    if (status == 'Achado') {
                      _newItem.type = 'FOUND';
                      _newItem.status = 'FOUND';
                      _newItem.discoverer = api.id;
                    } else {
                      _newItem.type = 'LOST';
                      _newItem.status = 'LOST';
                      _newItem.owner = api.id;
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Localização'),
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (title) {
                  if (title!.isEmpty) {
                    return 'Descreva onde o objeto foi encontrado/perdido';
                  }
                  return null;
                },
                onChanged: (text) => setState(() {
                  _newItem.location = text;
                }),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Descrição'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (description) {
                  if (description!.isEmpty) {
                    return 'Preencha o campo de descrição';
                  }
                  if (description.length < 10) {
                    return 'Descreva melhor o objeto.';
                  }
                  return null;
                },
                onChanged: (text) => setState(() {
                  _newItem.description = text;
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<SimpleResponse> registerObject(Objeto objeto, XFile? file) async {
  SimpleResponse response = await api.registerNewObject(objeto, file);
  return response;
}

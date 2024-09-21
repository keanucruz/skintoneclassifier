import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart'; //sample ui from yt

class SkinToneDetector extends StatefulWidget {
  @override
  _SkinToneDetectorState createState() => _SkinToneDetectorState();
}

class _SkinToneDetectorState extends State<SkinToneDetector> {
  File? _image;
  final picker = ImagePicker();
  String? _skinTone;
  List<dynamic>? _dominantColors;
  double? _accuracy;
  String? _seasonCategory;
  Map<String, String>? _colorPalette;
  List<dynamic>? _productRecommendations;
  String? _error;
  bool _isLoading = false;
  var bgColor = Color(0xFFE9FAFE);

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _uploadImage();
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _uploadImage();
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadImage() async {
    if (_image == null) {
      print('No image to upload.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final request = http.MultipartRequest(
        'POST', Uri.parse('http://192.168.1.228:3009/process_image'));
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final responseData = json.decode(responseBody);
        setState(() {
          _dominantColors = responseData['dominant_colors'];
          _skinTone = responseData['skin_tone'];
          _accuracy = responseData['accuracy'];
          _seasonCategory = responseData['season_category'];
          _colorPalette =
              Map<String, String>.from(responseData['color_palette']);
          _productRecommendations = responseData['product_recommendations'];
          _error = null;
        });
      } else {
        setState(() {
          _error =
              'Failed to upload image: ${response.reasonPhrase}\n$responseBody';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'An error occurred: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text("Skin Tone Detector"),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _image == null
                      ? Text('No image selected.')
                      : Image.file(_image!, height: 200),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _pickImageFromCamera,
                    child: Text('Take a photo'),
                  ),
                  ElevatedButton(
                    onPressed: _pickImageFromGallery,
                    child: Text('Select from gallery'),
                  ),
                  if (_skinTone != null) ...[
                    Text('Skin Tone: $_skinTone'),
                    Text('Accuracy: ${_accuracy?.toStringAsFixed(2)}%'),
                    Text('Season Category: $_seasonCategory'),
                    SizedBox(height: 20),
                    if (_colorPalette != null) ...[
                      Text('Recommended Colors:'),
                      ..._colorPalette!.entries.map((entry) => Text(
                            '${entry.key}: ${entry.value}',
                            style: TextStyle(
                                color: Color(int.parse(
                                        entry.value.substring(1, 7),
                                        radix: 16) +
                                    0xFF000000)),
                          )),
                    ],
                    if (_productRecommendations != null) ...[
                      Text('Recommended Products:'),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _productRecommendations!.length,
                        itemBuilder: (context, index) {
                          final product = _productRecommendations![index];
                          return ListTile(
                            title: Text(product['name']),
                            onTap: () async {
                              final url = product['link'];
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                          );
                        },
                      )
                    ],
                  ],
                  if (_error != null) ...[
                    Text('Error: $_error'),
                  ]
                ],
              ),
      ),
    );
  }
}

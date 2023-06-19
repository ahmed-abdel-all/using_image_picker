import 'dart:io';
import 'dart:math';
import 'package:path/path.dart' show basename;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? imgPath;

  uploadImage(ImageSource imageSource) async {
    final imagePicker = await ImagePicker().pickImage(source: imageSource);
    try {
      if (imagePicker != null) {
        setState(() {
          imgPath = File(imagePicker.path);
          String imageName = basename(imagePicker.path);
          int random = Random().nextInt(20);

          print(imageName);

          print("$random ----> $imageName");
        });
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('NO img selected')));
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  // uploadImage(ImageSource imageSource) async {
  //   final pickedImg = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   try {
  //     if (pickedImg != null) {
  //       setState(() {
  //         imgPath = File(pickedImg.path);
  //       });
  //     } else {
  //       print("NO img selected");
  //     }
  //   } catch (e) {
  //     print("Error => $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: (imgPath == null)
            ? const Text("No img selected")
            : Image.file(imgPath!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await uploadImage(ImageSource.gallery);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

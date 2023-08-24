import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:clone_of_instagram/resources/auth_methods.dart';
import 'package:clone_of_instagram/utils/colors.dart';
import 'package:clone_of_instagram/utils/utils.dart';
import 'package:clone_of_instagram/widgets/text_fiels_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(), flex: 2),
              // svg image logo
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),

              const SizedBox(height: 64),

              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Windows_10_Default_Profile_Picture.svg/2048px-Windows_10_Default_Profile_Picture.svg.png',
                          ),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              // text field input username
              TextFieldInput(
                hintText: 'ユーザー名',
                textInputType: TextInputType.text,
                textEditingController: _usernameController,
              ),
              const SizedBox(height: 24),
              // text field input email
              TextFieldInput(
                hintText: 'Eメールアドレス',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              const SizedBox(height: 24),
              // text field input password
              TextFieldInput(
                hintText: 'パスワード',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPass: true,
              ),
              const SizedBox(height: 24),
              // text field input username
              TextFieldInput(
                hintText: 'プロフィール',
                textInputType: TextInputType.text,
                textEditingController: _bioController,
              ),

              const SizedBox(height: 24),
              // button login
              InkWell(
                onTap: () async {
                  String res = await AuthMethods().signUpUser(
                    email: _emailController.text,
                    password: _passwordController.text,
                    username: _usernameController.text,
                    bio: _bioController.text,
                    file: _image!,
                  );

                  print(res);
                },
                child: Container(
                  child: const Text('新規作成'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor,
                  ),
                ),
              ),

              const SizedBox(height: 12),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              // button Sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("アカウントをお持ちでないですか？"),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: Text(
                        "登録する",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

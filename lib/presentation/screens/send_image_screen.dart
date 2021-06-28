import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webant_test_app/presentation/blocs/send_image_bloc/send_image_bloc.dart';
import 'package:webant_test_app/presentation/blocs/send_image_bloc/send_image_event.dart';
import 'package:webant_test_app/presentation/blocs/send_image_bloc/send_image_state.dart';
import 'package:webant_test_app/utils/utils.dart';
import 'package:webant_test_app/presentation/widgets/widgets.dart';
class SendImageScreen extends StatefulWidget {
  int? index;
  Function(int)? onTabTapped;

  SendImageScreen({Key? key, this.index, this.onTabTapped}) : super(key: key);

  @override
  _SendImageScreenState createState() => _SendImageScreenState();
}

class _SendImageScreenState extends State<SendImageScreen> {
  File? _image;
  TextEditingController? _nameController;
  TextEditingController? _descriptionController;


  @override
  void initState() {
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  void _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<SendImageBloc, SendImageState>(
          listener: (context, state) {
            if (state is SendImageSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(context.localize!.publicationHasBeenModerated),
                ),
              );
              setState(() {
                widget.onTabTapped!(0);
                _nameController!.clear();
                _descriptionController!.clear();
                _image = null;
              });
            }
          },
          builder: (context, state) => Column(
            children: [
              CustomAppBar(
                leading: AppIcons.backArrow(),
                trailing: GestureDetector(
                  onTap: () {
                    if (_nameController!.text.isNotEmpty &&
                        _descriptionController!.text.isNotEmpty) {
                      context.read<SendImageBloc>().add(
                            SendImage(
                              name: _nameController!.text,
                              description: _descriptionController!.text,
                              file: _image,
                              newImage: true,
                              popularImage: true,
                            ),
                          );
                    }
                  },
                  child: Text(
                    context.localize!.add,
                    style: AppTypography.font15.copyWith(
                        color: AppColors.pinkCF497E,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 62.h, bottom: 63.h),
                  child: Container(
                    width: 375.w,
                    height: 251.h,
                    child: _image == null
                        ? Center(
                            child: GestureDetector(
                              onTap: _getFromGallery,
                              child: Icon(
                                Icons.add,
                                size: 100,
                              ),
                            ),
                          )
                        : Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _nameController,
                        hintText: context.localize!.name,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                      ),
                      CustomTextField(
                        controller: _descriptionController,
                        hintText: context.localize!.description,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        maxLines: 4,
                        height: 100.h,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

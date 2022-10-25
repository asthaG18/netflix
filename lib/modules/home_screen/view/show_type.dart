import 'package:flutter/material.dart';
import '../../../res/colors.dart';
import '../../../res/dimen.dart';
import '../../../utils/custom_widgets/custom_snackbar.dart';
import '../../../utils/custom_widgets/custom_text.dart';
import '../list/show_type_list.dart';
import '../list/show_type_list_model.dart';

class ShowType extends StatefulWidget {
  const ShowType({super.key});

  @override
  State<ShowType> createState() => _ShowTypeState();
}

class _ShowTypeState extends State<ShowType> {
  final List<ShowTypeListModel> _showTypeList = ShowTypeList.list;
  @override
  Widget build(BuildContext context) {
    return _buildShowType();
  }

  _buildShowType() {
    return SizedBox(
      height: AppDimen.size100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              CustomSnackbar.showSnackBar(
                  context: context,
                  message: '${_showTypeList[index].type} Clicked',
                  backgroundColor: AppColors.blue);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: AppDimen.size14),
              child: Stack(
                children: [
                  _buildShowTypeImage(index),
                  _buildShowTypeText(index),
                ],
              ),
            ),
          );
        },
        itemCount: _showTypeList.length,
      ),
    );
  }

  _buildShowTypeImage(int index) {
    return Container(
      height: AppDimen.size100,
      width: AppDimen.size200,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
              _showTypeList[index].image,
            ),
            fit: BoxFit.cover),
        color: AppColors.white,
        borderRadius: const BorderRadius.all(Radius.circular(AppDimen.size14)),
      ),
    );
  }

  _buildShowTypeText(int index) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      top: 0,
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.all(Radius.circular(AppDimen.size14)),
          color: Colors.white,
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              Colors.red.withOpacity(0.3),
              Colors.red.withOpacity(0.6),
            ],
          ),
        ),
        child: Center(
          child: CustomText(
            title: _showTypeList[index].type,
            fontSize: AppDimen.size25,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}

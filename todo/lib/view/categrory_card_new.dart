import 'package:flutter/material.dart';
import 'package:todo/view/add_category.dart';

class CategoryCardNew extends StatelessWidget {
  const CategoryCardNew({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4.0,
      borderOnForeground: false,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddCategory();
          }));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: 52.0,
              color: color,
            ),
            Container(
              height: 8.0,
            ),
            Text(
              'Add Category',
              style: TextStyle(color: color),
            ),
          ],
        ),
      ),
    );
  }
}

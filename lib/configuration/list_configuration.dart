import 'package:aturuang_project/configuration/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListGoals extends StatelessWidget {
  final String goals;
  final String collected;
  final String target;
  final String imagePath;
  final VoidCallback onPressed;

  ListGoals({
    required this.goals,
    required this.collected,
    required this.target,
    required this.onPressed,
    required this.imagePath,
  });

  String formatCurrency(int amount) {
    final NumberFormat formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0, // Jumlah digit di belakang koma
    );

    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: border,
          width: 2.0,
        ),
      ),
      child: ListTile(
        dense: true,
        leading: Container(
          width: 57,
          height: 39,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(imagePath),
            ),
          ),
        ),
        tileColor: primaryColor,
        title: Text(goals,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins-Bold',
              color: Colors.white,
            )),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
            ),
            Text(
                "Collected : ${formatCurrency(int.parse(collected)).toString()}",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w100,
                  fontFamily: 'Poppins-Reguler',
                  color: Colors.white,
                )),
            Text("Target : ${formatCurrency(int.parse(target)).toString()}",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w100,
                  fontFamily: 'Poppins-Reguler',
                  color: Colors.white,
                )),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_sharp, color: Colors.white),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

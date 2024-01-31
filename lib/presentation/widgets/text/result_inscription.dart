import 'package:flutter/material.dart';

buildResultInscription({
  required BuildContext context,
  required String title,
  required String result
}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyMedium,),
        Text(result, style: Theme.of(context).textTheme.bodyMedium,),

      ],
    ),
  );
}
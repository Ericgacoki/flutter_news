import 'package:flutter/material.dart';

// TODO: Ask GPT to change this from a function to a Stateful Class.
// Why -> Try to update the isChecked state of the chips hosted by this TopSheet

Future<T?> showTopSheet<T>(BuildContext context, Widget child,
    {bool barrierDismissible = true}) {
  return
    showGeneralDialog<T?>(
    context: context,
    barrierDismissible: barrierDismissible,
    transitionDuration: const Duration(milliseconds: 250),
    barrierLabel: MaterialLocalizations.of(context).dialogLabel,
    barrierColor: Colors.black.withOpacity(0.3),
    pageBuilder: (context, _, __) => child,
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)
            .drive(
                Tween<Offset>(begin: const Offset(0, -1.0), end: Offset.zero)),
        child: Column(
          children: [
            Material(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [child],
              ),
            )
          ],
        ),
      );
    },
  );
}

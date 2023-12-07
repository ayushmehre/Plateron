import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final int quantity;
  final VoidCallback onAddPressed;
  final VoidCallback onMinusPressed;

  const AddButton({
    super.key,
    required this.quantity,
    required this.onAddPressed,
    required this.onMinusPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (quantity == 0) {
      return GestureDetector(
        onTap: onAddPressed,
        child: Container(
            decoration: buildBoxDecoration(),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            child: Text(
              'Add',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.green),
            )),
      );
    } else {
      return Container(
          decoration: buildBoxDecoration(),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onMinusPressed,
                child: const Icon(Icons.remove, color: Colors.grey),
              ),
              const SizedBox(width: 4),
              Text(quantity.toString(),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.green,
                      )),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: onAddPressed,
                child: const Icon(Icons.add, color: Colors.green),
              ),
            ],
          ));
    }
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.green, width: 2),
    );
  }
}

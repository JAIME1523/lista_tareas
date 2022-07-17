import 'package:flutter/cupertino.dart';

class AlertDialogDelete extends StatelessWidget {
  const AlertDialogDelete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    
    CupertinoAlertDialog(
        title: const Text('Eliminar'),
        content: const Text("¿Seguro que deseas eliminar?"),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Eliminar'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      );
  }
}


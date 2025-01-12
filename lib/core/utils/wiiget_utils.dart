import 'package:flutter/material.dart';

import '../../configs/config.dart';

setIcon(String type) {
  switch (type) {
    case 'income':
      {
        return const Icon(
          Icons.call_made,
          color: Colors.white,
        );
      }
    case 'goal':
      {
        return const Icon(
          Icons.savings,
          color: Colors.white,
        );
      }
    case 'expense':
      {
        return const Icon(
          Icons.call_received,
          color: Colors.white,
        );
      }

    case 'debt':
      {
        return const Icon(
          Icons.monetization_on_rounded,
          color: Colors.white,
        );
      }
    default:
      {
        return const Icon(
          Icons.error,
          color: Colors.white,
        );
      }
  }
}

String setText(String type) {
  switch (type) {
    case 'income':
      {
        return "Receita";
      }

    case 'debt':
      {
        return "Dívida";
      }
    case 'goal':
      {
        return "Poupança";
      }
    case 'expense':
      {
        return "Despesa";
      }
    default:
      {
        return "Sem categoria";
      }
  }
}

setColor(String type) {
  switch (type) {
    case 'income':
      {
        return AppColors.primaryColor;
      }

    case 'goal':
      {
        return Colors.purple;
      }
    case 'expense':
      {
        return Colors.pinkAccent;
      }
    default:
      {
        return Colors.grey;
      }
  }
}

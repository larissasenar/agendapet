import 'package:flutter/material.dart';

class BotaoLaranja extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;

  const BotaoLaranja({required this.texto, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        //icon: const Icon(Icons.check, color: Colors.white),
        label: Text(
          texto,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFB8C00),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}

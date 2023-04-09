import 'package:contactbook_bsm/main.dart';
import 'package:flutter/material.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add New Contact'),
      ),
      body: Column(children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
              hintText: 'Enter a new contact name here....'),
        ),
        TextButton(
          onPressed: () {
            final contact = Contact(name: _controller.text);
            ContactBook().add(contact: contact);
            Navigator.pop(context);
          },
          child: const Text('Add Contact'),
        )
      ]),
    );
  }
}

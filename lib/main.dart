import 'package:contactbook_bsm/add_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dart:developer' as dev;

void main() async {
  runApp(
    MaterialApp(
      title: 'Firebase Practice',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      routes: {
        '/add_contact': (context) => const AddContactScreen(),
      },
    ),
  );
}

class Contact {
  final String id;
  final String name;
  Contact({
    required this.name,
  }) : id = const Uuid().v4();
}

class ContactBook extends ValueNotifier<List<Contact>> {
  ContactBook.sharedInstance() : super([]);
  static final ContactBook _shared = ContactBook.sharedInstance();
  factory ContactBook() => _shared;

  int get length => value.length;

  void add({required Contact contact}) {
    //we can do this it will work.
    // value.add(contact);
    // notifyListeners();

    //But this is more accourate and good.
    final contacts = value;
    contacts.add(contact);
    notifyListeners();
  }

  void remove({required Contact contact}) {
    // value.remove(contact);
    // notifyListeners();
    // same here
    final contacts = value;
    if (contacts.contains(contact)) {
      contacts.remove(contact);
      notifyListeners();
    }
  }

  Contact? contact({required int atIndex}) =>
      value.length > atIndex ? value[atIndex] : null;
  //if the contact length is more than atIndex (?)than return index (:)other vise retrun null
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    dev.log('Build');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home Screen'),
      ),
      body: ValueListenableBuilder(
        valueListenable: ContactBook(),
        builder: (contact, value, child) {
          final contacts = value as List<Contact>;
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return Dismissible(
                onDismissed: (direction) {
                  // we can do both of them
                  ContactBook().remove(contact: contact);
                  // contacts.remove(contact);
                },
                key: ValueKey(contact.id),
                child: Material(
                  color: Colors.white70,
                  elevation: 3.0,
                  child: ListTile(
                    title: Text(contact.name),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed('/add_contact');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

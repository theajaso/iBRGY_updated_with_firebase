import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PendingButton extends StatefulWidget {
  const PendingButton({Key? key}) : super(key: key);

  @override
  State<PendingButton> createState() => _PendingButtonState();
}

class _PendingButtonState extends State<PendingButton> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final allChecked = CheckBoxModal(documentType: 'Pending Appointment', pickupDate: '', details: '');
  final List<CheckBoxModal> checkBoxList = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

  Future<void> fetchDataFromFirestore() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Fetch the user's document
        DocumentSnapshot<Map<String, dynamic>> userDocument = await FirebaseFirestore
            .instance
            .collection('users')
            .doc(user.uid)
            .get();

        // Check if the user's document exists
        if (userDocument.exists) {
          // Access the "appointments" subcollection
          final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
              .instance
              .collection('users')
              .doc(user.uid)
              .collection('appointments')
              .get();

          final List<CheckBoxModal> data = snapshot.docs.map((doc) {
            return CheckBoxModal(
              documentType: doc['documentType'],
              pickupDate: doc['pickupDate'],
              details: doc.id, // Use the document ID as details
            );
          }).toList();

          setState(() {
            checkBoxList.addAll(data);
          });
        } else {
          print('User document does not exist.');
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
  onAllClicked(CheckBoxModal ckbItem) {
    final newValue = !ckbItem.value;
    setState(() {
      ckbItem.value = newValue;
      checkBoxList.forEach((element) {
        element.value = newValue;
      });
    });
  }

  onItemClicked(CheckBoxModal ckbItem) {
    final newValue = !ckbItem.value;
    setState(() {
      ckbItem.value = newValue;

      if (!newValue) {
        allChecked.value = false;
      } else {
        final allListChecked = checkBoxList.every((element) => element.value);
        allChecked.value = allListChecked;
      }
    });
  }

  Future<void> deleteDocument(String documentId) async {
    try {
      print('Deleting document with ID: $documentId');
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser?.uid)
          .collection('appointments')
          .doc(documentId)
          .delete();

      setState(() {
        checkBoxList.removeWhere((checkBox) => checkBox.details == documentId);
      });

      print('Document successfully deleted!');
    } catch (e) {
      print('Error deleting document: $e');
      // Handle the error, show a message to the user, or perform additional actions
    }
  }
  void showDetailsDialog(CheckBoxModal selectedCheckBox) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser?.uid)
          .collection('appointments')
          .doc(selectedCheckBox.details) // Use the document ID as details
          .get();

      if (documentSnapshot.exists) {
        // Document exists, display its content
        Map<String, dynamic> appointmentData = documentSnapshot.data()!;
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Appointment Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SingleChildScrollView(
                child: buildFormattedDetails(appointmentData),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffffeeb6), // Customize button color
                  ),
                  child: Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.black, // Customize button text color
                    ),
                  ),
                ),
              ],
              backgroundColor: Colors.white, // Customize dialog background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            );
          },
        );
      } else {
        // Document does not exist
        print('Document does not exist.');
      }
    } catch (e) {
      print('Error fetching document: $e');
    }
  }


  Widget buildFormattedDetails(Map<String, dynamic> data) {
    final List<String> fieldsToShow = ['fullName', 'documentType', 'requestDate', 'pickupDate'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: fieldsToShow
          .where((fieldName) => data.containsKey(fieldName))
          .map((fieldName) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Text(
                getFieldNameTitle(fieldName),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 8),
              Expanded( // Use Expanded to make the text adjustable
                child: Text(
                  '${data[fieldName]}',
                  style: const TextStyle(
                    fontSize: 16,
                    // You can customize the text style here
                  ),
                ),
              ),
            ],
          ),
        );
      })
          .toList(),
    );
  }


  Widget buildDetailRow(String fieldName, dynamic value) {
    final List<String> fieldOrder = ['fullName', 'documentType', 'requestDate', 'pickupDate'];

    // Check if fieldName is in the order list, otherwise, use 'Unknown' as default
    final displayFieldName = fieldOrder.indexOf(fieldName) != -1 ? fieldOrder.indexOf(fieldName) : fieldOrder.length - 1;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            getFieldNameTitle(fieldOrder[displayFieldName]),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(width: 8),
          Text(
            '$value',
            style: TextStyle(
              fontSize: 16,
              // You can customize the text style here
            ),
          ),
        ],
      ),
    );
  }

  String getFieldNameTitle(String fieldName) {
    switch (fieldName) {
      case 'fullName':
        return 'Full Name:';
      case 'documentType':
        return 'Document:';
      case 'requestDate':
        return 'Request Date:';
      case 'pickupDate':
        return 'Pickup Date:';
    // Add more cases as needed
      default:
        return 'Unknown:';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white70,
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 20,
              child:   Container(
                height: 120,
                width: 300,
                margin: const EdgeInsets.fromLTRB(30, 80, 30, 30),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xffffe89d),
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  children: [
                    Center(
                      child: Text(
                        'Pick-up your requested document/s at '
                            'the Barangay Hall. Kindly tick the '
                            'box once done. Thank you!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Ink(
                decoration: const ShapeDecoration(
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  onPressed: () {
                    List<String> documentsToDelete = checkBoxList
                        .where((checkBox) => checkBox.value)
                        .map((checkBox) => checkBox.details) // Use checkBox.details instead of checkBox.documentType
                        .toList();

                    for (String documentId in documentsToDelete) {
                      deleteDocument(documentId);
                    }
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.black54,
                    size: 30.0,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 240, // Adjust this value based on your UI design
              bottom: 75,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () => onAllClicked(allChecked),
                            leading: Checkbox(
                              activeColor: Colors.blueGrey,
                              value: allChecked.value,
                              onChanged: (value) => onAllClicked(allChecked),
                            ),
                            title: Text(
                              allChecked.documentType,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Divider(),
                          ...checkBoxList
                              .asMap()
                              .entries
                              .map(
                                (entry) => ListTile(
                              onTap: () => onItemClicked(entry.value),
                              leading: Checkbox(
                                activeColor: Colors.blueGrey,
                                value: entry.value.value,
                                onChanged: (value) => onItemClicked(entry.value),
                              ),
                              subtitle: Text(entry.value.pickupDate),
                              title: Text(
                                entry.value.documentType,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.line_weight_outlined),
                                onPressed: () {
                                  showDetailsDialog(entry.value);
                                },
                              ),
                            ),
                          )
                              .toList(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckBoxModal {
  String documentType;
  bool value;
  String pickupDate;
  String details;

  CheckBoxModal({
    required this.documentType,
    this.value = false,
    required this.pickupDate,
    required this.details,
  });
}
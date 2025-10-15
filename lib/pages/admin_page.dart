import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(title: const Text("لوحة الطلبات"),
        automaticallyImplyLeading: false,),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("orders")
              .where("createdAt", isNotEqualTo: null)
              .orderBy("createdAt", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final orders = snapshot.data?.docs ?? [];

            if (orders.isEmpty) {
              return const Center(child: Text("لا توجد طلبات حالياً"));
            }

            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
              try {
                final data = orders[index].data() as Map<String, dynamic>;
                final table = data['table'] ?? '?';
                final itemsList = data['items'] as List<dynamic>? ?? [];
                final items = itemsList.map((i) {
                  final name = i['name'] ?? 'غير معروف';
                  final number = i['number'] ?? i['quantity'] ?? 1;
                  return "$name x$number";
                }).join(", ");
                final createdAt = data['createdAt'] as Timestamp?;
                final timeText = createdAt != null
                    ? "${createdAt
                    .toDate()
                    .hour
                    .toString()
                    .padLeft(2, '0')}:${createdAt
                    .toDate()
                    .minute
                    .toString()
                    .padLeft(2, '0')}"
                    : "—";
      //
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text("طاولة $table"),
                    subtitle: Text(items),
                    trailing: Text(timeText),
                  ),
                );
              }catch (e){
                print("Error parsing order data: $e");
                return const SizedBox.shrink();
              }
              },
            );
          },
        ),
      ),
    );
  }
}

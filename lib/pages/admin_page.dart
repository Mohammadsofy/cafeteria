import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("لوحة الطلبات"),
      automaticallyImplyLeading: true,),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("orders")
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError){
          return Center(child: Text('حدث خطأ أثناء تحميل البيانات: ${snapshot.error}'));
          }
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
                final price = i['price'] ?? 0.0;
                return " ${price * number}  =  $name x$number  ";
              }).join("\n");
              final total = data['total'] ?? 0;
              final itemsText = items + "\n" + "المجموع: ${total.toString()} د";
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

              return Card(
                color: Colors.blue,
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Expanded(
                    child: Row(
                      children: [
                        const Icon(Icons.access_time, size: 16),
                        const SizedBox(width: 16),
                        Column(
                          children: [
                            Text(timeText, textAlign: TextAlign.left),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              tooltip: "حذف الطلب",
                              onPressed: () async {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text('تأكيد الحذف'),
                                    content: Text('هل أنت متأكد من حذف هذا الطلب؟'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.of(ctx).pop(false),
                                        child: Text('إلغاء'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.of(ctx).pop(true),
                                        child: Text('حذف', style: TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  ),
                                );
                                if (confirm == true) {
                                  await FirebaseFirestore.instance
                                      .collection('orders')
                                      .doc(orders[index].id)
                                      .delete();
                                }
                              },
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                    color: Colors.deepOrange,
                                    border: Border.all(
                                    color: Colors.deepOrange,

                                    width: 2,
                                  )
                                ),
                                child: Text("طاولة $table", textAlign: TextAlign.right),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              itemsText,
                              textAlign: TextAlign.right,
                              style: TextStyle(height: 2),)
                          ],
                        ),
                      ],
                    ),
                  ),
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
    );
  }
}

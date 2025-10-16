import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class MenuItem {
  final String name;
  final String imageUrl;
  final String group;
  final double price;
  final double count;


  MenuItem({required this.name, required this.imageUrl, required this.group, required this.price,required this.count});
}

class MenuPage extends StatefulWidget {
  final int tableNumber;
  const MenuPage({Key? key, required this.tableNumber}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final List<MenuItem> items = [

    MenuItem(name: "عصير برتقال", imageUrl: "images/OIP.jpg", group: "juices",price: 5,count:0),
    MenuItem(name: "عصير مانجا", imageUrl: "images/OIP.jpg", group: "juices",price: 5,count:0),
    MenuItem(name: "عصير تفاح", imageUrl: "images/OIP.jpg", group: "juices", price: 5,count:0),
    MenuItem(name: "عصير جوافة", imageUrl: "images/OIP.jpg", group: "juices", price: 5,count:0),

    MenuItem(name: "شاورما دجاج", imageUrl: "images/OIP.jpg", group: "sandwiches",price: 10,count:0),
    MenuItem(name: "شاورما لحم", imageUrl: "images/OIP.jpg", group: "sandwiches",price: 10,count:0),
    MenuItem(name: "فلافل", imageUrl: "images/OIP.jpg", group: "sandwiches",price: 10, count:0),
    MenuItem(name: "برجر", imageUrl: "images/OIP.jpg", group: "sandwiches",price: 10,count:0),

    MenuItem(name: "وجبة دجاج", imageUrl: "images/OIP.jpg", group: "meals",price: 15,count:0),
    MenuItem(name: "وجبة كفتة", imageUrl: "images/OIP.jpg", group: "meals",price: 15,count:0),
    MenuItem(name: "وجبة سمك", imageUrl: "images/OIP.jpg", group: "meals",price: 15,count:0),
    MenuItem(name: "وجبة كبسة", imageUrl: "images/OIP.jpg", group: "meals",price: 15,count:0),
  ];
  double get total {
    double sum = 0;
    for (var item in items) {
      final text = controllers[item.hashCode]?.text ?? '';
      final count = double.tryParse(text) ?? 0;
      sum += item.price * count;
    }
    return sum;
  }

  final Map<int, TextEditingController> controllers = {};

  final Map<String, GlobalKey> sectionKeys = {
    "juices": GlobalKey(),
    "sandwiches": GlobalKey(),
    "meals": GlobalKey(),
  };

  final ScrollController scrollController = ScrollController();

  void scrollToSection(String group) {
    final context = sectionKeys[group]?.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    controllers.values.forEach((c) => c.dispose());
    scrollController.dispose();
    super.dispose();
  }

  Future<void> submitOrder() async {
    double orderTotal =total;
    List<Map<String, dynamic>> orders = [];
    for (var item in items) {
      final value = controllers[item.hashCode]?.text ?? '';
        final qty=int.tryParse(value) ?? 0;
        if (qty > 0) {
          orders.add({
            'name': item.name,
            'image': item.imageUrl,
            'number': int.parse(value),
            'price': item.price,
            'total': item.price * qty,
          });
        }

    }

    if (orders.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('لم يتم اختيار أي صنف')),
      );
      return;
    }

    await FirebaseFirestore.instance.collection('orders').add({
      'table': widget.tableNumber,
      'items': orders,
      'status': 'قيد التحضير',
      'createdAt': FieldValue.serverTimestamp(),
      'total': double.parse(orderTotal.toStringAsFixed(2)),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم إرسال الطلب إلى المطبخ بنجاح ')),
    );

    controllers.values.forEach((c) => c.clear());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final juices = items.where((e) => e.group == 'juices').toList();
    final sandwiches = items.where((e) => e.group == 'sandwiches').toList();
    final meals = items.where((e) => e.group == 'meals').toList();

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('المنيو',style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.orange,
        automaticallyImplyLeading: true,),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => scrollToSection("juices"),
                    child: Text("العصائر"),
                  ),
                  ElevatedButton(
                    onPressed: () => scrollToSection("sandwiches"),
                    child: Text("الشاندويش"),
                  ),
                  ElevatedButton(
                    onPressed: () => scrollToSection("meals"),
                    child: Text("الوجبات"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SectionWidget(
                      key: sectionKeys['juices'],
                      title: "العصائر",
                      items: juices,
                      controllers: controllers,
                      onChanged: () {setState(() {});},
                    ),
                    SectionWidget(
                      key: sectionKeys['sandwiches'],
                      title: "الشاندويش",
                      items: sandwiches,
                      controllers: controllers,
                      onChanged: () {setState(() {});},
                    ),
                    SectionWidget(
                      key: sectionKeys['meals'],
                      title: "الوجبات",
                      items: meals,
                      controllers: controllers,
                      onChanged: () {setState(() {});},
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
                onPressed: submitOrder,
                child: Column(
                  children: [
                    Text("إرسال الطلب",style: TextStyle(fontSize: 20),),
                    Text("المجموع: ${total.toStringAsFixed(2)} دينار",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionWidget extends StatelessWidget {
  final String title;
  final List<MenuItem> items;
  final Map<int, TextEditingController> controllers;
  final VoidCallback onChanged;

  const SectionWidget({
    Key? key,
    required this.title,
    required this.items,
    required this.controllers,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ...items.asMap().entries.map((entry) {
            final item = entry.value;
            controllers[item.hashCode] ??= TextEditingController();

            return Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Image.network(item.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        children: [
                          Text(item.name, style: TextStyle(fontSize: 18)),
                          Text('السعر: ${item.price} دينار', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: TextField(
                        onChanged: (value)=> onChanged(),
                        controller: controllers[item.hashCode],
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        ],
                        decoration: InputDecoration(
                          hintText: 'عدد',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

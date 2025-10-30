
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


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
  const MenuPage({super.key, required this.tableNumber});

  @override
  State<MenuPage> createState() => _MenuPageState();
}
final image='images/na7ya.webp';
class _MenuPageState extends State<MenuPage> {

  final List<MenuItem> items = [
// Hot drinks (المشروبات الساخنة)
    MenuItem(name: "V60", imageUrl: image, group: "hot_drinks", price: 3.5, count: 0),
    MenuItem(name: "اسبريسو", imageUrl: image, group: "hot_drinks", price: 2.0, count: 0),
    MenuItem(name: "أمريكانو", imageUrl: image, group: "hot_drinks", price: 2.5, count: 0),
    MenuItem(name: "لاتيه", imageUrl: image, group: "hot_drinks", price: 3.0, count: 0),
    MenuItem(name: "كابتشينو", imageUrl: image, group: "hot_drinks", price: 3.0, count: 0),
    MenuItem(name: "فلات وايت", imageUrl: image, group: "hot_drinks", price: 3.0, count: 0),
    MenuItem(name: "موكا (دارك/وايت/آيرش)", imageUrl: image, group: "hot_drinks", price: 3.5, count: 0),
    MenuItem(name: "سبانيش لاتيه", imageUrl: image, group: "hot_drinks", price: 3.5, count: 0),
    MenuItem(name: "كاراميل ميكاتو", imageUrl: image, group: "hot_drinks", price: 3.5, count: 0),
    MenuItem(name: "اسبريسو أفوجاتو", imageUrl: image, group: "hot_drinks", price: 3.0, count: 0),
    MenuItem(name: "قهوة تركية", imageUrl: image, group: "hot_drinks", price: 2.0, count: 0),
    MenuItem(name: "شاي", imageUrl: image, group: "hot_drinks", price: 2.0, count: 0),
    MenuItem(name: "هوت شوكليت", imageUrl: image, group: "hot_drinks", price: 2.5, count: 0),

    // Cold coffee / iced (القهوة الباردة)
    MenuItem(name: "آيس سنغتشر", imageUrl: image, group: "cold_coffee", price: 3.5, count: 0),
    MenuItem(name: "آيس V60", imageUrl: image, group: "cold_coffee", price: 3.5, count: 0),
    MenuItem(name: "آيس أمريكانو", imageUrl: image, group: "cold_coffee", price: 2.5, count: 0),
    MenuItem(name: "آيس سبانيش لاتيه", imageUrl: image, group: "cold_coffee", price: 3.5, count: 0),
    MenuItem(name: "آيس موكا", imageUrl: image, group: "cold_coffee", price: 3.5, count: 0),
    MenuItem(name: "آيس كاراميل ميكاتو", imageUrl: image, group: "cold_coffee", price: 3.5, count: 0),

    // Refreshing drinks (المشروبات المنعشة)
    MenuItem(name: "آيس كركديه", imageUrl: image, group: "refreshing", price: 3.0, count: 0),
    MenuItem(name: "آيس تي (ناحية)", imageUrl: image, group: "refreshing", price: 3.0, count: 0),
    MenuItem(name: "موهيتو ناحية", imageUrl: image, group: "refreshing", price: 3.0, count: 0),

    // Natural drinks (المشروبات الطبيعية)
    MenuItem(name: "ناهية كوكتيل", imageUrl: image, group: "natural", price: 4.5, count: 0),
    MenuItem(name: "تانيجو", imageUrl: image, group: "natural", price: 4.0, count: 0),
    MenuItem(name: "لافاي", imageUrl: image, group: "natural", price: 4.0, count: 0),
    MenuItem(name: "أناناس ومانجو", imageUrl: image, group: "natural", price: 3.5, count: 0),

    // Frappe / فروابي
    MenuItem(name: "فرايبه", imageUrl: image, group: "frappe", price: 3.5, count: 0),
    MenuItem(name: "كراميل فرايبه", imageUrl: image, group: "frappe", price: 3.5, count: 0),
    MenuItem(name: "شوكلاتة فرايبه", imageUrl: image, group: "frappe", price: 3.5, count: 0),

// Pasta (الباستا)
    MenuItem(name: "اربياتا", imageUrl: image, group: "pasta", price: 5.0, count: 0),
    MenuItem(name: "بيستو", imageUrl: image, group: "pasta", price: 6.0, count: 0),
    MenuItem(name: "روزاتا", imageUrl: image, group: "pasta", price: 6.0, count: 0),
    MenuItem(name: "فوتوشيني دجاج", imageUrl: image, group: "pasta", price: 6.0, count: 0),
    MenuItem(name: "سباجتي لحمة", imageUrl: image, group: "pasta", price: 6.0, count: 0),
    MenuItem(name: "لازانيا لحمة", imageUrl: image, group: "pasta", price: 7.0, count: 0),

// Hookah / الأراجيل
    MenuItem(name: "ليمون ونعنع", imageUrl: image, group: "argile", price: 3.5, count: 0),
    MenuItem(name: "مكس فروت", imageUrl: image, group: "argile", price: 3.5, count: 0),
    MenuItem(name: "كاندي", imageUrl: image, group: "argile", price: 3.5, count: 0),
    MenuItem(name: "بطّيخ ونعنع", imageUrl: image, group: "argile", price: 3.5, count: 0),
    MenuItem(name: "علكة وقرفة", imageUrl: image, group: "argile", price: 3.5, count: 0),
    MenuItem(name: "تفاحتين نخلة", imageUrl: image, group: "argile", price: 4.0, count: 0),
    MenuItem(name: "تفاحتين مزايا", imageUrl: image, group: "argile", price: 3.5, count: 0),
    MenuItem(name: "تفاحتين بحريني", imageUrl: image, group: "argile", price: 3.5, count: 0),
    MenuItem(name: "تفاحتين الفاخر احمر", imageUrl: image, group: "argile", price: 4.0, count: 0),
    MenuItem(name: "أرجيلة ناحية", imageUrl: image, group: "argile", price: 4.0, count: 0),

// Desserts (الحلويات)
    MenuItem(name: "تراميسو", imageUrl: image, group: "desserts", price: 3.5, count: 0),
    MenuItem(name: "تشيز كيك", imageUrl: image, group: "desserts", price: 3.5, count: 0),
    MenuItem(name: "سان سبستيان", imageUrl: image, group: "desserts", price: 3.0, count: 0),
    MenuItem(name: "جرمان كيك", imageUrl: image, group: "desserts", price: 3.0, count: 0),

// Salads (السلطات)
    MenuItem(name: "سلطة سيزر", imageUrl: image, group: "salads", price: 3.5, count: 0),
    MenuItem(name: "سيزر دجاج", imageUrl: image, group: "salads", price: 4.5, count: 0),
    MenuItem(name: "سلطة يونانية", imageUrl: image, group: "salads", price: 3.5, count: 0),
    MenuItem(name: "سلطة الجرجير", imageUrl: image, group: "salads", price: 3.5, count: 0),

// Pizza (البيتزا)
    MenuItem(name: "التشكنو (تركي)", imageUrl: image, group: "pizza", price: 5.5, count: 0),
    MenuItem(name: "البيستو", imageUrl: image, group: "pizza", price: 6.0, count: 0),
    MenuItem(name: "زينجر بيتزا", imageUrl: image, group: "pizza", price: 7.0, count: 0),
    MenuItem(name: "بيتزا تركي ذرة", imageUrl: image, group: "pizza", price: 6.0, count: 0),
    MenuItem(name: "بيتزا لحمة", imageUrl: image, group: "pizza", price: 6.0, count: 0),
    MenuItem(name: "بيتزا جمبري", imageUrl: image, group: "pizza", price: 7.0, count: 0),
    MenuItem(name: "بيتزا دجاج باربكيو", imageUrl: image, group: "pizza", price: 6.0, count: 0),
    MenuItem(name: "مارغريتا", imageUrl: image, group: "pizza", price: 5.0, count: 0),

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
    "hot_drinks": GlobalKey(),
    "cold_coffee": GlobalKey(),
    "refreshing": GlobalKey(),
    "natural": GlobalKey(),
    "frappe": GlobalKey(),
    "pasta": GlobalKey(),
    "pizza": GlobalKey(),
    "argile": GlobalKey(),
    "desserts": GlobalKey(),
    "salads": GlobalKey(),
  };

  final ScrollController scrollController = ScrollController();

  void scrollToSection(String group) {
    final key = sectionKeys[group];
    if (key == null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = key.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }
  void updateTotal() {
    setState(() {});
  }



  @override
  void dispose() {
    for (var c in controllers.values) {
      c.dispose();
    }
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

    bool confirm = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('تأكيد الطلب'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...orders.map((o) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child:Row(
                        children: [
                          Text(o['name'], style: TextStyle(fontSize: 16)),
                          Text("×${o['number']}"),
                        ],
                      ), ),
                      Text(" الحبة ب ${o['price']}د"),
                    ],
                  ),
                )),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("المجموع الكلي:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("${orderTotal.toStringAsFixed(2)} دينار",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('إلغاء'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('تأكيد'),
            ),
          ],
        );
      },
    );


    if (confirm != true) return;

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

    for (var c in controllers.values) {
      c.clear();
    }
    setState(() {});
  }
  Future<void> _instagram() async {
    final url = Uri.parse("https://www.instagram.com/na7ieh/");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication))
    {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final hotDrinks = items.where((e) => e.group == 'hot_drinks').toList();
    final coldCoffee = items.where((e) => e.group == 'cold_coffee').toList();
    final refreshing = items.where((e) => e.group == 'refreshing').toList();
    final natural = items.where((e) => e.group == 'natural').toList();
    final frappe = items.where((e) => e.group == 'frappe').toList();
    final pasta = items.where((e) => e.group == 'pasta').toList();
    final pizza = items.where((e) => e.group == 'pizza').toList();
    final argile = items.where((e) => e.group == 'argile').toList();
    final desserts = items.where((e) => e.group == 'desserts').toList();
    final salads = items.where((e) => e.group == 'salads').toList();

    return WillPopScope(
      onWillPop: () async => false,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          body: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'images/caf.webp',
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, right: 30),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.phone,
                            color: Colors.green,
                            size: 30,
                          ),
                          onPressed: () async{
                            final Uri url = Uri(scheme: 'tel', path: '+962797332379');
                            if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                            } else {
                            print('Could not launch $url');
                            }

                          },
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child:ShaderMask(
                          shaderCallback: (bounds) =>LinearGradient(
                            colors: [
                              Color(0xFFfeda75),
                              Color(0xFFfa7e1e),
                              Color(0xFFd62976),
                              Color(0xFF962fbf),
                              Color(0xFF4f5bd5),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: IconButton(
                            onPressed: _instagram,
                            icon: FaIcon(FontAwesomeIcons.instagram),
                            iconSize: 40,
                            color: Colors.white,
                          ),
                          
                        ),
                      ),
                    ),
                  ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => scrollToSection("hot_drinks"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("المشروبات الساخنة"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => scrollToSection("cold_coffee"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("القهوة الباردة"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => scrollToSection("refreshing"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("المشروبات المنعشة"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => scrollToSection("natural"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("المشروبات الطبيعية"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => scrollToSection("frappe"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("الفرايبه"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => scrollToSection("pasta"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("الباستا"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => scrollToSection("pizza"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("البيتزا"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => scrollToSection("argile"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("الأراجيل"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => scrollToSection("desserts"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("الحلويات"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => scrollToSection("salads"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("السلطات"),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SectionWidget(key: sectionKeys['hot_drinks'], title: "المشروبات الساخنة", items: hotDrinks, controllers: controllers,onChanged: updateTotal),
                      SectionWidget(key: sectionKeys['cold_coffee'], title: "القهوة الباردة", items: coldCoffee, controllers: controllers,onChanged: updateTotal),
                      SectionWidget(key: sectionKeys['refreshing'], title: "المشروبات المنعشة", items: refreshing, controllers: controllers,onChanged: updateTotal),
                      SectionWidget(key: sectionKeys['natural'], title: "المشروبات الطبيعية", items: natural, controllers: controllers,onChanged: updateTotal),
                      SectionWidget(key: sectionKeys['frappe'], title: "الفرايبه", items: frappe, controllers: controllers ,onChanged: updateTotal),
                      SectionWidget(key: sectionKeys['pasta'], title: "الباستا", items: pasta, controllers: controllers,onChanged: updateTotal),
                      SectionWidget(key: sectionKeys['pizza'], title: "البيتزا", items: pizza, controllers: controllers,onChanged: updateTotal),
                      SectionWidget(key: sectionKeys['argile'], title: "الأراجيل", items: argile, controllers: controllers,onChanged: updateTotal),
                      SectionWidget(key: sectionKeys['desserts'], title: "الحلويات", items: desserts, controllers: controllers,onChanged: updateTotal),
                      SectionWidget(key: sectionKeys['salads'], title: "السلطات", items: salads, controllers: controllers,onChanged: updateTotal),

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
                      Text("المجموع: ${total.toStringAsFixed(2)} دينار",style:
                      const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionWidget extends StatefulWidget {
  final String title;
  final List<MenuItem> items;
  final Map<int, TextEditingController> controllers;
  final VoidCallback? onChanged;

  const SectionWidget({
    super.key,
    required this.title,
    required this.items,
    required this.controllers,
    this.onChanged,
  });

  @override
  _SectionWidgetState createState() => _SectionWidgetState();
}

class _SectionWidgetState extends State<SectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ListView.builder(
            shrinkWrap: true,
            physics:const NeverScrollableScrollPhysics(),
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              final item = widget.items[index];
              widget.controllers[item.hashCode] ??= TextEditingController();
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding:const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Image.asset(item.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name, style: TextStyle(fontSize: 18)),
                            Text('السعر: ${item.price} دينار', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        child: TextField(
                          controller: widget.controllers[item.hashCode],
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                          ],
                          decoration:const InputDecoration(hintText: 'عدد'),
                          onChanged: (_) => widget.onChanged?.call(),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

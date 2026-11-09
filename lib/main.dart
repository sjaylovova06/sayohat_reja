import 'package:flutter/material.dart';

void main() {
  runApp(const TravelPlannerApp());
}

class TravelPlannerApp extends StatelessWidget {
  const TravelPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sayohat Rejalashtiruvchi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DestinationSelectionScreen(),
    );
  }
}

// Sayohat modeli (Model klassi)
class Destination {
  final String name;
  final String country;
  final double price;
  final String image;
  final String description;
  final int defaultDays;

  Destination({
    required this.name,
    required this.country,
    required this.price,
    required this.image,
    required this.description,
    required this.defaultDays,
  });
}

// 1-QADAM: Manzilni tanlash ekrani
class DestinationSelectionScreen extends StatefulWidget {
  const DestinationSelectionScreen({super.key});

  @override
  State<DestinationSelectionScreen> createState() =>
      _DestinationSelectionScreenState();
}

class _DestinationSelectionScreenState
    extends State<DestinationSelectionScreen> {
  // Ishonchli va doimiy ishlaydigan rasm manzillari
  final List<Destination> destinations = [
    Destination(
      name: 'Samarqand',
      country: 'O\'zbekiston',
      price: 150,
      image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Registan_Samarkand_Uzbekistan.jpg/800px-Registan_Samarkand_Uzbekistan.jpg',
      description: 'Sharq gavhari, qadimiy Registon maydoni va osmono\'par minoralar shahri.',
      defaultDays: 3,
    ),
    Destination(
      name: 'Buxoro',
      country: 'O\'zbekiston',
      price: 120,
      image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Po-i-Kalyan_Complex_Bukhara.jpg/800px-Po-i-Kalyan_Complex_Bukhara.jpg',
      description: 'Ming yillik tarixga ega shahri azim, Minorai Kalon va ko\'hna qadamjolar.',
      defaultDays: 2,
    ),
    Destination(
      name: 'Xiva',
      country: 'O\'zbekiston',
      price: 130,
      image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Ichan_Kala%2C_Khiva%2C_Uzbekistan.jpg/800px-Ichan_Kala%2C_Khiva%2C_Uzbekistan.jpg',
      description:
          'Ochiq osmon ostidagi muzey, Ichan qal\'a va qadimiy me’morchilik.',
      defaultDays: 2,
    ),
    Destination(
      name: 'Dubai',
      country: 'BAA',
      price: 650,
      image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/Burj_Khalifa.jpg/800px-Burj_Khalifa.jpg',
      description: 'Kelajak shahri, Burj Xalifa, cho\'l safarilari va zamonaviy xaridlar.',
      defaultDays: 5,
    ),
  ];

  Destination? selectedDestination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sayohat Yo\'nalishini Tanlang'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Qayerga sayohat qilmoqchisiz?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'O\'zingizga yoqqan maskanni tanlang va sarguzashtni boshlang',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: destinations.length,
                itemBuilder: (context, index) {
                  final dest = destinations[index];
                  final isSelected = selectedDestination?.name == dest.name;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDestination = dest;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected
                              ? Colors.deepPurple
                              : Colors.transparent,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(13),
                            ),
                            child: Image.network(
                              dest.image,
                              height: 180,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      height: 180,
                                      color: Colors.grey.shade200,
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 180,
                                  color: Colors.grey.shade300,
                                  child: const Center(
                                    child: Icon(
                                      Icons.broken_image,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      dest.name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '\$${dest.price.toInt()} / kishi',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  dest.description,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: selectedDestination == null
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingDetailsScreen(
                              destination: selectedDestination!,
                            ),
                          ),
                        );
                      },
                child: const Text(
                  'Davom etish',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 2-QADAM: Sana va ishtirokchilarni tanlash ekrani
class BookingDetailsScreen extends StatefulWidget {
  final Destination destination;

  const BookingDetailsScreen({super.key, required this.destination});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  DateTime? startDate;
  DateTime? endDate;
  int participants = 1;

  @override
  void initState() {
    super.initState();
    // Standart holatda bugundan boshlab tavsiya etilgan kunlar oralig'ini belgilaymiz
    startDate = DateTime.now();
    endDate = DateTime.now().add(
      Duration(days: widget.destination.defaultDays),
    );
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: DateTimeRange(start: startDate!, end: endDate!),
    );
    if (picked != null) {
      setState(() {
        startDate = picked.start;
        endDate = picked.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final int totalDays = endDate!.difference(startDate!).inDays;
    final double totalPrice = widget.destination.price * participants;

    return Scaffold(
      appBar: AppBar(title: const Text('Sana va Ishtirokchilar')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.deepPurple,
                    size: 30,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tanlangan manzil:',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      Text(
                        widget.destination.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Sayohat sanasini belgilang:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () => _selectDateRange(context),
              icon: const Icon(Icons.calendar_today, color: Colors.deepPurple),
              label: Text(
                '${startDate!.day}.${startDate!.month}.${startDate!.year}  —  ${endDate!.day}.${endDate!.month}.${endDate!.year} ($totalDays kun)',
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Ishtirokchilar soni:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Sayohatchilar:', style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      IconButton(
                        onPressed: participants > 1
                            ? () => setState(() => participants--)
                            : null,
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: Colors.deepPurple,
                        ),
                      ),
                      Text(
                        '$participants kishi',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () => setState(() => participants++),
                        icon: const Icon(
                          Icons.add_circle_outline,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Taxminiy summa:',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Text(
                    '\$$totalPrice',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderSummaryScreen(
                        destination: widget.destination.name,
                        startDate: startDate!,
                        endDate: endDate!,
                        participants: participants,
                        totalPrice: totalPrice,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Buyurtmani Tasdiqlash',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 3-QADAM: Buyurtma ma'lumotlarini ko'rsatish ekrani
class OrderSummaryScreen extends StatelessWidget {
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final int participants;
  final double totalPrice;

  const OrderSummaryScreen({
    super.key,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.participants,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buyurtma Tafsilotlari'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(
                Icons.check_circle_rounded,
                color: Colors.green,
                size: 90,
              ),
            ),
            const SizedBox(height: 12),
            const Center(
              child: Text(
                'Sayohat muvaffaqiyatli band qilindi!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Center(
              child: Text(
                'Tez orada operatorlarimiz siz bilan bog\'lanishadi.',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildRow('Tanlangan manzil:', destination),
                    const Divider(height: 24),
                    _buildRow(
                      'Boshlanish sanasi:',
                      '${startDate.day}.${startDate.month}.${startDate.year}',
                    ),
                    const Divider(height: 24),
                    _buildRow(
                      'Tugash sanasi:',
                      '${endDate.day}.${endDate.month}.${endDate.year}',
                    ),
                    const Divider(height: 24),
                    _buildRow('Ishtirokchilar:', '$participants nafar'),
                    const Divider(height: 24),
                    _buildRow('Umumiy to\'lov:', '\$$totalPrice', isBold: true),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text(
                  'Bosh Sahifaga Qaytish',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: isBold ? Colors.deepPurple : Colors.black87,
          ),
        ),
      ],
    );
  }
}

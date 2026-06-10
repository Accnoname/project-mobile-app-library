import 'package:flutter/material.dart';
import 'package:library_management_app/widgets/stat_card.dart';

class LoanDetailSample extends StatelessWidget {
  const LoanDetailSample({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      appBar: AppBar(title: const Text('Chi tiết đơn mượn')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        children: [
          // Trạng thái đơn mượn
          const StatCard(
            title: 'Trạng thái: Đang mượn',
            value: 'Hạn trả: 20/06/2026',
            icon: Icons.timer_outlined,
            color: Colors.orange,
            subtitle: 'Còn 11 ngày',
          ),
          const SizedBox(height: 24),
          
          const Text('Thông tin người mượn', 
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const Card(
            child: ListTile(
              leading: Icon(Icons.person_outline),
              title: Text('Nguyễn Văn A'),
              subtitle: Text('Mã SV: SV123456'),
            ),
          ),
          const SizedBox(height: 24),
          
          const Text('Sách đã mượn', 
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(Icons.book),
                  title: Text('Sách mẫu số ${index + 1}'),
                  subtitle: const Text('Tác giả: Nhiều tác giả'),
                  trailing: Text('SL: 1', style: TextStyle(color: colorScheme.primary)),
                ),
              );
            },
          ),
          
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: colorScheme.primary,
            ),
            child: const Text('Xác nhận trả sách'),
          ),
        ],
      ),
    );
  }
}

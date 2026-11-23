import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_mobile_dev/controllers/makanan_controller.dart';
import 'package:uas_mobile_dev/routers.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final MakananController controller = Get.find<MakananController>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: controller.daftarMakanan.length,
      itemBuilder: (context, index) {
        final makanan = controller.daftarMakanan[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              controller.siapkanPesanan(makanan);
              Get.toNamed(Routes.detailMakanan, arguments: makanan);
            },
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          makanan.namaMakanan,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          makanan.deskripsi,
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${controller.formatRupiah(makanan.harga)} / makanan",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
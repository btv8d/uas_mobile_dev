import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_mobile_dev/controllers/makanan_controller.dart';
import 'package:uas_mobile_dev/models/makanan_model.dart';

class DetailMakananPage extends StatelessWidget {
  DetailMakananPage({super.key});

  final MakananController controller = Get.find<MakananController>();
  final MakananModel makanan = Get.arguments as MakananModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesan Makanan"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Info Wisata
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              makanan.namaMakanan,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              makanan.deskripsi,
                              style: const TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(makanan.deskripsi),
                  const SizedBox(height: 8),
                  Text(
                    "Harga Satuan: ${controller.formatRupiah(makanan.harga)}",
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Form Pemesan
            const Text("Data Pemesanan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              controller: controller.txtNamaPemesan,
              decoration: const InputDecoration(
                labelText: "Nama Lengkap Pemesan",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller.txtTanggal,
              decoration: const InputDecoration(
                labelText: "Tanggal Kunjungan",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),
            const SizedBox(height: 20),

            // Counter Jumlah Tiket
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Jumlah Tiket", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    IconButton(
                      onPressed: controller.kurangQty,
                      icon: const Icon(Icons.remove_circle, color: Colors.red, size: 30),
                    ),
                    Obx(
                      () => Text(
                        "${controller.jumlahMakanan.value}",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      onPressed: controller.tambahQty,
                      icon: const Icon(Icons.add_circle, color: Colors.blue, size: 30),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(height: 28),

            // Rincian Perhitungan PPN
            const Text("Rincian Pembayaran", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Obx(
              () => Card(
                color: Colors.grey[50],
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    children: [
                      _barisHarga(
                        "Subtotal (${controller.jumlahMakanan.value}x makanan)",
                        controller.formatRupiah(controller.subtotal),
                      ),
                      const SizedBox(height: 8),
                      _barisHarga(
                        "PPN (11%)",
                        controller.formatRupiah(controller.nominalPpn),
                      ),
                      const Divider(height: 20),
                      _barisHarga(
                        "Total Bayar",
                        controller.formatRupiah(controller.totalBayar),
                        isBold: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Tombol Konfirmasi
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => controller.checkoutMakanan(makanan),
                child: const Text("KONFIRMASI & BAYAR", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _barisHarga(String label, String nilai, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 16 : 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          nilai,
          style: TextStyle(
            fontSize: isBold ? 16 : 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: isBold ? Colors.blue : Colors.black87,
          ),
        ),
      ],
    );
  }
}
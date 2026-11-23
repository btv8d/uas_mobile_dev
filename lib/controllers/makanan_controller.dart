import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_mobile_dev/models/makanan_model.dart';
import 'package:uas_mobile_dev/models/transaksi_model.dart';

class MakananController extends GetxController {
  // Persentase PPN 11%
  final double tarifPpn = 0.11;

  // Data dummy lokal (aman saat offline)
  final List<MakananModel> daftarMakanan = [
    MakananModel(
      id: "MKN-01",
      namaMakanan: "Nasi Goreng Spesial",
      harga: 25000,
      deskripsi: "Nasi goreng bumbu rempah dengan telur mata sapi, ayam suwir, dan kerupuk.",
    ),
    MakananModel(
      id: "MKN-02",
      namaMakanan: "Ayam Bakar Madu",
      harga: 30000,
      deskripsi: "Ayam bakar olesan madu murni lengkap dengan sambal terasi dan lalapan.",
    ),
    MakananModel(
      id: "MKN-03",
      namaMakanan: "Sate Ayam  Madura",
      harga: 28000,
      deskripsi: "10 tusuk sate ayam daging pilihan dengan siraman bumbu kacang kental.",
    ),
    MakananModel(
      id: "MKN-04",
      namaMakanan: "Mie Ayam Bakso",
      harga: 20000,
      deskripsi: "Mie kenyal dengan topping ayam kecap, sawi hijau, dan 2 butir bakso sapi.",
    ),
    MakananModel(
      id: "MKN-04",
      namaMakanan: "Es Teh Manis Jumbo",
      harga: 8000,
      deskripsi: "Minuman teh melati segar dengan gula asli dan es batu kristal.",
    ),
  ];

  // State pemesanan aktif
  var jumlahMakanan = 1.obs;
  var hargaSatuan = 0.obs;
  final TextEditingController txtNamaPemesan = TextEditingController();
  final TextEditingController txtTanggal = TextEditingController();

  // Daftar riwayat pembelian
  var riwayatTransaksi = <TransaksiModel>[].obs;

  // Getter perhitungan otomatis (Reaktif)
  int get subtotal => hargaSatuan.value * jumlahMakanan.value;
  int get nominalPpn => (subtotal * tarifPpn).round();
  int get totalBayar => subtotal + nominalPpn;

  void siapkanPesanan(MakananModel makanan) {
    hargaSatuan.value = makanan.harga;
    jumlahMakanan.value = 1;
    txtNamaPemesan.clear();
    txtTanggal.text = "23 November 2026";
  }

  void tambahQty() {
    jumlahMakanan.value++;
  }

  void kurangQty() {
    if (jumlahMakanan.value > 1) {
      jumlahMakanan.value--;
    }
  }

  String formatRupiah(int angka) {
    final str = angka.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      final posisiDariBelakang = str.length - i;
      buffer.write(str[i]);
      if (posisiDariBelakang > 1 && posisiDariBelakang % 3 == 1) {
        buffer.write('.');
      }
    }
    return "Rp $buffer";
  }

  void checkoutMakanan(MakananModel makanan) {
    if (txtNamaPemesan.text.trim().isEmpty || txtTanggal.text.trim().isEmpty) {
      Get.snackbar(
        "Data Belum Lengkap",
        "Nama pemesan dan tanggal pembelian wajib diisi!",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final transaksiBaru = TransaksiModel(
      kodeBooking: "BK-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}",
      namaPemesan: txtNamaPemesan.text.trim(),
      namaMakanan: makanan.namaMakanan,
      jumlahMakanan: jumlahMakanan.value,
      subtotal: subtotal,
      ppn: nominalPpn,
      totalBayar: totalBayar,
      tanggalPembelian: txtTanggal.text.trim(),
    );

    riwayatTransaksi.insert(0, transaksiBaru);

    Get.back(); // Tutup halaman detail
    Get.snackbar(
      "Pemesanan Berhasil!",
      "Kode Booking: ${transaksiBaru.kodeBooking} (${formatRupiah(transaksiBaru.totalBayar)})",
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void onClose() {
    txtNamaPemesan.dispose();
    txtTanggal.dispose();
    super.onClose();
  }
}


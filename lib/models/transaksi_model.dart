class TransaksiModel {
  final String kodeBooking;
  final String namaPemesan;
  final String namaMakanan;
  final int jumlahMakanan;
  final int subtotal;
  final int ppn;
  final int totalBayar;
  final String tanggalPembelian;

  TransaksiModel({
    required this.kodeBooking,
    required this.namaPemesan,
    required this.namaMakanan,
    required this.jumlahMakanan,
    required this.subtotal,
    required this.ppn,
    required this.totalBayar,
    required this.tanggalPembelian,
  });
}
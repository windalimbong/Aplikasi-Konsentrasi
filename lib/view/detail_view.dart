import 'package:flutter/material.dart';
import 'package:my_aplikasi/model/penjualan.dart';

class DetailView extends StatefulWidget {
  final Penjualan data;
  const DetailView({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  var hargaAwal = 0;
  var harga = 0;
  var berapa = 1;

  @override
  void initState() {
    hargaAwal = int.tryParse(widget.data.harga)!;
    harga = hargaAwal * berapa;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            child: Image.network(
              widget.data.gambar,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          DetailText(data: widget.data.nama, style: style),
          DetailText(data: "Rp." + widget.data.harga, style: style),
          DetailText(
              data: "Sisa " +
                  (int.tryParse(widget.data.stok)! - berapa).toString(),
              style: style),
          DetailText(data: widget.data.deskripsi, style: style),
          // Text(data.),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                berapa++;
                harga = hargaAwal * berapa;
              });
            },
            child: const Text("Tambah"),
          ),
          Text(harga.toString()),
          ElevatedButton(
            onPressed: () {
              setState(() {
                // berapa = berapa - 1;
                berapa--;

                harga = hargaAwal * (berapa);
              });
            },
            child: const Text("Kurang"),
          ),
        ],
      ),
    );
  }
}

class DetailText extends StatelessWidget {
  const DetailText({
    Key? key,
    required this.data,
    required this.style,
  }) : super(key: key);

  final String data;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(data, style: style),
    );
  }
}

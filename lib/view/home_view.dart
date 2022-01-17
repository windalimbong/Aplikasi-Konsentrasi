import 'package:flutter/material.dart';
import 'package:my_aplikasi/api/penjualan.dart';
import 'package:my_aplikasi/model/penjualan.dart';

import 'detail_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ApiPenjualan().apiTransaksi();
          setState(() {});
        },
        child: FutureBuilder(
          future: ApiPenjualan().apiTransaksi(), // async work
          builder:
              (BuildContext context, AsyncSnapshot<List<Penjualan>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: Text('Loading....'));
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return GridView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (ctx, i) {
                      var data = snapshot.data![i];
                      return CardCostum(data: data);
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                  );
                }
            }
          },
        ),
      ),
    );
  }
}

class CardCostum extends StatelessWidget {
  const CardCostum({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Penjualan data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Route route = MaterialPageRoute(
            builder: (context) => DetailView(
                  data: data,
                ));
        Navigator.push(context, route);
      },
      child: Card(
        child: Column(
          children: [
            Image.network(
              data.gambar,
              height: 110,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              data.nama,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(data.deskripsi),
            const SizedBox(
              height: 2,
            ),
            Text("Rp." + data.harga),
          ],
        ),
      ),
    );
  }
}

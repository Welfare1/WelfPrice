import 'package:flutter/material.dart';
import 'package:welf_price/Model/coinModel.dart';
import 'package:welf_price/View/Components/item.dart';
import 'package:welf_price/View/Components/item2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:welf_price/View/Components/item3.dart';

class CryptList extends StatefulWidget {
  const CryptList({super.key});

  @override
  State<CryptList> createState() => _CryptListState();
}

class _CryptListState extends State<CryptList> {
  @override
  void initState() {
    getCoinMarket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: isRefreshing == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xffFBC700),
                ),
              )
            : coinMarket == null || coinMarket!.length == 0
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Center(
                      child: Text(
                        'Veuillez reéssayer dans quelques instant !.',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 3,
                              child: TextField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.teal,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.clear,
                                      color: Colors.teal,
                                    ),
                                    onPressed: () {},
                                  ),
                                  iconColor: Colors.teal,
                                  hintText: 'Rechercher',
                                  hintStyle: TextStyle(color: Colors.teal),
                                  labelStyle: TextStyle(color: Colors.teal),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors.teal),
                                  ),
                                  fillColor: Colors.grey.shade200,
                                  filled: true,
                                ),
                              ),
                            ),
                            Flexible(
                                flex: 1,
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.arrow_upward,
                                          color: Colors.white,
                                        )),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.arrow_downward,
                                          color: Colors.white,
                                        )),
                                  ],
                                )),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: coinMarket!.length,
                          itemBuilder: (context, index) {
                            return Item3(
                              item: coinMarket![index],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  bool isRefreshing = true;

  List? coinMarket = [];
  var coinMarketList;
  Future<List<CoinModel>?> getCoinMarket() async {
    const url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true';

    setState(() {
      isRefreshing = true;
    });
    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    setState(() {
      isRefreshing = false;
    });
    if (response.statusCode == 200) {
      var x = response.body;
      coinMarketList = coinModelFromJson(x);
      setState(() {
        coinMarket = coinMarketList;
      });
    } else {
      print(response.statusCode);
    }
  }
}

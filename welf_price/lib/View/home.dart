import 'package:welf_price/Model/coinModel.dart';
import 'package:welf_price/View/Components/item.dart';
import 'package:welf_price/View/Components/item2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    getCoinMarket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          height: myHeight,
          width: myWidth,
          // decoration: const BoxDecoration(
          //   gradient: LinearGradient(
          //       begin: Alignment.topLeft,
          //       end: Alignment.bottomRight,
          //       colors: [
          //         Color.fromARGB(255, 253, 225, 112),
          //         Color(0xffFBC700),
          //       ]),
          // ),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: const Text(
                  'Retrouvez un résumé de ce qui se passe en ce moment:',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                height: myHeight * 0.73,
                width: myWidth,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Colors.black87.withOpacity(0.3),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    )),
                child: Column(
                  children: [
                    SizedBox(
                      height: myHeight * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: myWidth * 0.08),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'TRADE',
                            style: TextStyle(fontSize: 20),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child: const Text(
                                  "Voir les trades",
                                  style: TextStyle(color: Colors.teal),
                                ),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: myHeight * 0.02,
                    ),
                    Container(
                      height: myHeight * 0.36,
                      child: isRefreshing == true
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xffFBC700),
                              ),
                            )
                          : coinMarket == null || coinMarket!.length == 0
                              ? Padding(
                                  padding: EdgeInsets.all(myHeight * 0.06),
                                  child: const Center(
                                    child: Text(
                                      'Veuillez reéssayer dans quelques instant !.',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: 4,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Item(
                                      item: coinMarket![index],
                                    );
                                  },
                                ),
                    ),
                    SizedBox(
                      height: myHeight * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: myWidth * 0.05),
                      child: const Row(
                        children: [
                          Text(
                            'Recommandation',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: myWidth * 0.03),
                        child: isRefreshing == true
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xffFBC700),
                                ),
                              )
                            : coinMarket == null || coinMarket!.length == 0
                                ? Padding(
                                    padding: EdgeInsets.all(myHeight * 0.06),
                                    child: const Center(
                                      child: Text(
                                        'Veuillez reéssayer dans quelques instant !.',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: coinMarket!.length,
                                    itemBuilder: (context, index) {
                                      return Item2(
                                        item: coinMarket![index],
                                      );
                                    },
                                  ),
                      ),
                    ),
                    SizedBox(
                      height: myHeight * 0.02,
                    ),
                  ],
                ),
              )
            ],
          ),
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

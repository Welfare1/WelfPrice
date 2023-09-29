import 'package:welf_price/View/selectCoin.dart';
import 'package:flutter/material.dart';

class Item3 extends StatelessWidget {
  var item;
  Item3({this.item, super.key});

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey)),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (contest) => SelectCoin(
                        selectItem: item,
                      )));
        },
        leading: Image.network(item.image, height: 50),
        title: Text(
          item.id,
          style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          item.symbol,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white54),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Text(
                item.priceChange24H.toString().contains('-')
                    ? "-\$" +
                        item.priceChange24H
                            .toStringAsFixed(2)
                            .toString()
                            .replaceAll('-', '')
                    : "\$" + item.priceChange24H.toStringAsFixed(2),
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey),
              ),
            ),
            const SizedBox(
              width: 1,
            ),
            Flexible(
              flex: 1,
              child: Text(
                item.marketCapChangePercentage24H.toStringAsFixed(2) + '%',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: item.marketCapChangePercentage24H >= 0
                        ? Colors.green
                        : Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

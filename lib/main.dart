import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}

/// Örnek Api response
Map<String, dynamic> testData = {
  "WheaterPred": {
    "location": {
      "Antalya": {"temp": 12, "wind": 8, "rain": "%12"},
      "hatay": {"temp": 21, "wind": 3, "rain": "%25"},
      "ankara": {"temp": 28, "wind": 10, "rain": "%52"},
      "istanbul": {"temp": 9, "wind": 3, "rain": "%34"},
      "izmir": {"temp": 30, "wind": 4, "rain": "%35"}
    },
  },
  "widgetType": 2,
  "height": 30.0,
  "width": 200.0,
  "color": [100, 224, 115, 0.5],
};

//Custom widget 1
class CustomWidget extends StatefulWidget {
  final double heigth;
  final double width;
  final Color color;
  final Widget child;
  const CustomWidget({
    Key? key,
    required this.heigth,
    required this.width,
    required this.color,
    required this.child,
  }) : super(key: key);

  @override
  State<CustomWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.width,
        height: widget.heigth,
        color: widget.color,
        child: widget.child,
      ),
    );
  }
}

class CustomWidget1 extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  final dynamic data;
  const CustomWidget1(
      {Key? key, this.padding, this.height = 60, this.width = 400, this.data})
      : super(key: key);

  @override
  State<CustomWidget1> createState() => _CustomWidget1State();
}

class _CustomWidget1State extends State<CustomWidget1> {
  @override
  Widget build(BuildContext context) {
    var veri = widget.data.keys as Iterable<String>;
    return ListView.builder(
      padding: widget.padding,
      itemCount: veri.length,
      itemBuilder: (context, index) {
        var datas = widget.data;
        var sehiler = datas.keys as Iterable<String>;
        var sehir = sehiler.toList();
        var city = sehir[index];
        return ListTile(
          tileColor: Colors.amberAccent,
        contentPadding: EdgeInsetsDirectional.all(5),
          shape: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),

          leading: Text(city),
          title: Row(
            children: [
              Column(
                children: [
                  const Text("Temperature"),
                  Text(datas[city]["temp"].toString()),
                ],
              ),
              SizedBox(width: 10,),
              Column(
                children: [
                  const Text("wind"),
                  Text(datas[city]["wind"].toString()),
                ],
              ),
              SizedBox(width: 10,),
              Column(
                children: [
                  const Text("Rain"),
                  Text(datas[city]["rain"].toString()),
                ],
              ),

            ],
          ),
        );

      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? dropInitial = "Antalya";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("custom widget"),
      ),
      body: Builder(builder: (context) {
        var listData = testData.values.toList();
        var widgetType = listData[1];
        var height = listData[2];
        var width = listData[3];
        var colorRaw = listData[4];
        var color = Color.fromRGBO(
            colorRaw[0], colorRaw[1], colorRaw[2], colorRaw[3].toDouble());
        var city = listData[0]["location"];
        var sehiler = city.keys as Iterable<String>;
        var sehirlist = sehiler.toList();
        if (widgetType == 1) {
          print(widgetType);
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomWidget(
                  heigth: height,
                  width: width,
                  color: color,
                  child: DropdownButton<String>(
                    icon: const Icon(Icons.arrow_downward_sharp),
                    value: dropInitial,
                    items: sehirlist.map((String menuitem) {
                      return DropdownMenuItem(
                          value: menuitem, child: Text(menuitem));
                    }).toList(),
                    onChanged: (newvalue) {
                      setState(() {
                        dropInitial = newvalue!;
                      });
                    },
                  )),
              SizedBox(
                child: Text(city[dropInitial]["temp"].toString()),
              ),
              SizedBox(
                child: Text(city[dropInitial]["wind"].toString()),
              ),
              SizedBox(
                child: Text(city[dropInitial]["rain"].toString()),
              ),
            ],
          );
        } else if (widgetType == 2) {
          return CustomWidget1(
            data: city,
          );
        } else {
          return const Center(
            child: Text("no data"),
          );
        }
      }),
    );
  }
}

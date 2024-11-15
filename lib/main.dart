import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Row(
            children: [
              SideMenu(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: FreightForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      color: Colors.grey.shade50, // Sidebar color updated
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(height: 40),
              Image.network(
                'https://static.vecteezy.com/system/resources/previews/003/589/149/non_2x/mix-icon-for-demo-vector.jpg',
                height: 80,
                width: 80,
              ),
              const SizedBox(height: 20),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BlankScreen()),
                  );
                },
              ),
              const Text('Booking'),
              const SizedBox(height: 40),
              IconButton(
                icon: const Icon(
                  Icons.request_quote,
                  color: Colors.blue,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BlankScreen()),
                  );
                },
              ),
              const Text(
                'Quotations',
                style: TextStyle(color: Colors.blue),
              ),
              const SizedBox(height: 40),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BlankScreen()),
                  );
                },
              ),
              const Text('Settings'),
              const SizedBox(height: 200),
              Image.network(
                'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                height: 60,
                width: 60,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FreightForm extends StatefulWidget {
  const FreightForm({super.key});

  @override
  _FreightFormState createState() => _FreightFormState();
}

class _FreightFormState extends State<FreightForm> {
  String selectedCommodity = "Wastepaper";
  String selectedContainerSize = "40 Dry";
  String length = "39.48 ft";
  String width = "7.70 ft";
  String height = "7.56 ft";
  String shipmentType = "FCL";

  void updateDimensions(String containerSize) {
    setState(() {
      selectedContainerSize = containerSize;
      if (containerSize == "40 Dry") {
        length = "39.48 ft";
        width = "7.70 ft";
        height = "7.56 ft";
      } else if (containerSize == "40 Dry High") {
        length = "40.00 ft";
        width = "8.00 ft";
        height = "8.50 ft";
      } else if (containerSize == "45 Dry High") {
        length = "45.00 ft";
        width = "8.50 ft";
        height = "9.00 ft";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Search the Best Freight Rates",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        const Row(
          children: [
            Expanded(child: CustomTextField(label: "Origin")),
            SizedBox(width: 20),
            Expanded(child: CustomTextField(label: "Destination")),
          ],
        ),
        const Row(
          children: [
            Expanded(
                child: CheckboxField(label: "Include nearby origin ports")),
            SizedBox(width: 20),
            Expanded(
                child:
                    CheckboxField(label: "Include nearby destination ports")),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Commodity",
                    border: OutlineInputBorder(),
                  ),
                  value: selectedCommodity,
                  items: ["Wastepaper", "Metal"]
                      .map((commodity) => DropdownMenuItem(
                          value: commodity, child: Text(commodity)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCommodity = value!;
                    });
                  },
                ),
              ),
            ),
            const Expanded(child: DateField(label: "Cut Off Date")),
          ],
        ),
        ShipmentType(
          shipmentType: shipmentType,
          onChange: (String value) {
            setState(() {
              shipmentType = value;
            });
          },
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Container Size",
                    border: OutlineInputBorder(),
                  ),
                  value: selectedContainerSize,
                  items: ["40 Dry", "40 Dry High", "45 Dry High"]
                      .map((size) => DropdownMenuItem(
                            value: size,
                            child: Text(size),
                          ))
                      .toList(),
                  onChanged: (value) {
                    updateDimensions(value!);
                  },
                ),
              ),
            ),
            const Expanded(child: CustomTextField(label: "No of Boxes")),
            const Expanded(child: CustomTextField(label: "Weight (Kg)")),
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Icon(
              Icons.error,
              color: Colors.grey,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'To obtain accurate rate for spot rate with guranted space and booking please ensure your container count and widget per container is accurate ',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ContainerDimensions(
          length: length,
          width: width,
          height: height,
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {},
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.search),
                SizedBox(width: 5),
                Text("Search"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;

  const CustomTextField({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class CheckboxField extends StatelessWidget {
  final String label;

  const CheckboxField({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: false, onChanged: (value) {}),
        Text(label),
      ],
    );
  }
}

class DateField extends StatelessWidget {
  final String label;

  const DateField({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ShipmentType extends StatelessWidget {
  final String shipmentType;
  final ValueChanged<String> onChange;

  const ShipmentType(
      {super.key, required this.shipmentType, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Shipment Type:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            SizedBox(
              height: 50,
              width: 200,
              child: ListTile(
                title: const Text("FCL"),
                leading: Radio(
                  activeColor: Colors.blue,
                  value: "FCL",
                  groupValue: shipmentType,
                  onChanged: (value) {
                    onChange(value!);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: ListTile(
                title: const Text("LCL"),
                leading: Radio(
                  activeColor: Colors.blue,
                  value: "LCL",
                  groupValue: shipmentType,
                  onChanged: (value) {
                    onChange(value!);
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ContainerDimensions extends StatelessWidget {
  final String length;
  final String width;
  final String height;

  const ContainerDimensions(
      {super.key,
      required this.length,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.grey.shade50, // Same background color as the sidebar
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Container Internal Dimensions:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Length: $length"),
                  Text("Width: $width"),
                  Text("Height: $height"),
                ],
              ),
              const SizedBox(width: 20),
              Container(
                height: 100,
                width: 200,
                color: Colors
                    .grey.shade300, // Same background color as the container
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BlankScreen extends StatelessWidget {
  const BlankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Blank Screen")),
      body: const Center(child: Text("This is a blank screen")),
    );
  }
}

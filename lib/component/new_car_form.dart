import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NewCarForm extends StatelessWidget {
  const NewCarForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          // TextButton(
          //     onPressed: () {
          //       for (; i <= cars.items.length - 1; i++) {
          //         List itembrand = [cars.items[i].brand];
          //         brand += itembrand;
          //       }
          //       print(brand);
          //     },
          //     child: Text("Testando"))

          SizedBox(
            height: 32,
            width: 310,
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                // label: Text("Marca"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              isExpanded: true,
              hint: const Text(
                "Marca",
                // style: TextStyle(fontSize: 14),
              ),
              onChanged: (choice) => choice.toString(),
              items: ["Fiat", "Toyota", "Jeep", "Ford"]
                  .map(
                    (e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    ),
                  )
                  .toList(),
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 32,
            width: 310,
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                // label: Text("Marca"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              isExpanded: true,
              hint: const Text(
                "Modelo",
                // style: TextStyle(fontSize: 14),
              ),
              onChanged: (choice) => choice.toString(),
              items: ["Fiat", "Toyota", "Jeep", "Ford"]
                  .map(
                    (e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    ),
                  )
                  .toList(),
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 32,
            width: 310,
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              isExpanded: true,
              hint: const Text(
                "Ano",
              ),
              onChanged: (choice) => choice.toString(),
              items: ["Fiat", "Toyota", "Jeep", "Ford"]
                  .map(
                    (e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    ),
                  )
                  .toList(),
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            // Mudar para container
            height: 32,
            width: 310,
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                // label: Text("Marca"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              isExpanded: true,
              hint: const Text(
                "Valor (R\$)",
                // style: TextStyle(fontSize: 14),
              ),
              onChanged: (choice) => choice.toString(),
              items: []
                  .map(
                    (e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

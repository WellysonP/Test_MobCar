import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/cars.dart';

class NewCarForm extends StatefulWidget {
  const NewCarForm({Key? key}) : super(key: key);

  @override
  State<NewCarForm> createState() => _NewCarFormState();
}

class _NewCarFormState extends State<NewCarForm> {
  @override
  Widget build(BuildContext context) {
    final modelControler = TextEditingController();
    final _formkey = GlobalKey<FormState>();
    final _formData = Map<String, Object>();
    final cars = Provider.of<Cars>(context);
    bool _isLoading = false;

    Future<void> _submitForm() async {
      final isValid = _formkey.currentState?.validate() ?? false;

      if (isValid != true) {
        return;
      }
      _formkey.currentState?.save();

      setState(() => _isLoading = true);

      try {
        await Provider.of<Cars>(context, listen: false).saveCar(_formData);
        Navigator.of(context).pop();
      } catch (erro) {
        print(erro);
        await showDialog<void>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("ERRO"),
            content: Text("Ocorreu um erro ao salvar o carro."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Reportar"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Sair"),
              )
            ],
          ),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }

    return Form(
      key: _formkey,
      child: Column(
        children: [
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
              onSaved: (brand) => _formData["brand"] = brand ?? "",
              items: cars.listCarBrand
                  .map(
                    (e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    ),
                  )
                  .toList(),
              validator: (_brand) {
                final brand = _brand ?? "";

                return null;
              },
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
              onSaved: (vehicles) => _formData["vehicles"] = vehicles ?? "",
              items: cars.listCarVehicles
                  .map(
                    (e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    ),
                  )
                  .toList(),
              validator: (_vehicles) {
                final vehicles = _vehicles ?? "";
                return null;
              },
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
              onSaved: (year) => _formData["year"] = year ?? "",
              items: cars.listCarYear
                  .map(
                    (e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    ),
                  )
                  .toList(),
              validator: (_year) {
                final year = _year ?? "";
                return null;
              },
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
              onSaved: (price) => _formData["price"] = price ?? "",
              items: [
                "10",
                "20",
                "30",
              ]
                  .map(
                    (e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    ),
                  )
                  .toList(),
              validator: (_price) {
                final price = _price ?? "";
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}

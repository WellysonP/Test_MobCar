import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobicar/Provider/brand_provider.dart';
import 'package:mobicar/models/brand_model.dart';
import 'package:mobicar/models/vehicle_model.dart';
import 'package:mobicar/services/brand_service.dart';
import 'package:mobicar/services/vehicle_service.dart';
import 'package:provider/provider.dart';

import '../Provider/cars.dart';
import '../Provider/vehicle_provider.dart';

class NewCarForm extends StatefulWidget {
  const NewCarForm({Key? key}) : super(key: key);

  @override
  State<NewCarForm> createState() => _NewCarFormState();
}

class _NewCarFormState extends State<NewCarForm> {
  late final Dio dio;
  late final BrandService brandService;
  late final VehicleService vehicleService;

  late final BrandProvider brandProvider;
  late final VehicleProvider vehicleProvider;

  BrandModel? selectedBrand;
  VehicleModel? selectedVehicle;

  @override
  void initState() {
    dio = Dio(BaseOptions(baseUrl: ""));
    brandService = BrandService(dio: dio);
    vehicleService = VehicleService(dio: dio);

    brandProvider = BrandProvider(brandService);
    vehicleProvider = VehicleProvider(vehicleService, brandProvider);

    brandProvider.getBrand();
    // vehicleProvider.getVehicle();

    super.initState();
  }

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
      child: Column(
        children: [
          SizedBox(
            height: 32,
            width: 310,
            child: AnimatedBuilder(
              animation: brandProvider,
              builder: (context, child) {
                if (brandProvider.brands.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final List<BrandModel> brands = brandProvider.brands;
                  return DropdownButtonFormField<BrandModel>(
                    key: _formkey,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    isExpanded: true,
                    hint: const Text(
                      "Marca",
                      // style: TextStyle(fontSize: 14),
                    ),
                    items: brands
                        .map(
                          (brand) => DropdownMenuItem(
                            child: Text(brand.name),
                            value: brand,
                          ),
                        )
                        .toList(),
                    onChanged: (value) async {
                      brandProvider.setSelectedBrand(value!);

                      setState(() {});
                      // modificar posteriormente paras sair do setState e ficar apenas com provider

                      await vehicleProvider.getVehicle();
                      brandProvider.setSelectedBrand(value);
                    },
                    value: brandProvider.selectedBrand,
                    validator: (_brand) {
                      final brand = _brand ?? "";

                      return null;
                    },
                  );
                }
              },
            ),
          ),
          SizedBox(height: 16),
          brandProvider.selectedBrand?.id == null
              ? SizedBox(
                  height: 32,
                  width: 310,
                )
              : SizedBox(
                  height: 32,
                  width: 310,
                  child: AnimatedBuilder(
                    animation: vehicleProvider,
                    builder: (context, child) {
                      if (vehicleProvider.vehicles.isEmpty) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        final List<VehicleModel> vehicles =
                            vehicleProvider.vehicles;
                        return DropdownButtonFormField<VehicleModel>(
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          isExpanded: true,
                          hint: const Text(
                            "Marca",
                          ),
                          items: vehicles
                              .map(
                                (vehicle) => DropdownMenuItem(
                                  child: Text(vehicle.name),
                                  value: vehicle,
                                ),
                              )
                              .toList(),
                          onChanged: (value) =>
                              vehicleProvider.setSelectedVehicle(value!),
                          value: vehicleProvider.selectedVehicle,
                          validator: (_vehicle) {
                            final vehicle = _vehicle ?? "";

                            return null;
                          },
                        );
                      }
                    },
                  ),
                ),
          Text("inserir Ano"),
          SizedBox(height: 16),
          Text("Inserir Valor"),
        ],
      ),
    );
  }
}

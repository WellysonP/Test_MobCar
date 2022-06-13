import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobicar/Provider/brand_provider.dart';
import 'package:mobicar/models/brand_model.dart';
import 'package:mobicar/models/car_data_model.dart';
import 'package:mobicar/models/vehicle_model.dart';
import 'package:mobicar/services/brand_service.dart';
import 'package:mobicar/services/price_service.dart';
import 'package:mobicar/services/vehicle_service.dart';
import 'package:provider/provider.dart';

import '../Provider/cars.dart';
import '../Provider/price_provider.dart';
import '../Provider/vehicle_provider.dart';
import '../Provider/year_provider.dart';
import '../models/year_model.dart';
import '../services/year_service.dart';

class NewCarForm extends StatefulWidget with ChangeNotifier {
  // const NewCarForm({Key? key}) : super(key: key);
  void submit() {
    print("consegui esse carai");
  }

  @override
  State<NewCarForm> createState() => _NewCarFormState();
}

class _NewCarFormState extends State<NewCarForm> {
  late final Dio dio;
  late final BrandService brandService;
  late final VehicleService vehicleService;
  late final YearService yearService;
  late final PriceService priceService;

  late final BrandProvider brandProvider;
  late final VehicleProvider vehicleProvider;
  late final YearProvider yearProvider;
  late final PriceProvider priceProvider;

  BrandModel? selectedBrand;
  VehicleModel? selectedVehicle;
  YearModel? selectedYear;
  CarDataModel? selectedCarData;

  @override
  void initState() {
    dio = Dio(BaseOptions(baseUrl: ""));
    brandService = BrandService(dio: dio);
    vehicleService = VehicleService(dio: dio);
    yearService = YearService(dio: dio);
    priceService = PriceService(dio: dio);

    brandProvider = BrandProvider(brandService);
    vehicleProvider = VehicleProvider(vehicleService, brandProvider);
    yearProvider = YearProvider(yearService, brandProvider, vehicleProvider);
    priceProvider = PriceProvider(
        priceService, brandProvider, vehicleProvider, yearProvider);

    brandProvider.getBrand();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    final _formData = Map<String, Object>();
    final cars = Provider.of<Cars>(context);
    bool _isLoading = false;

    Future<void> submitForm() async {
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
                          onChanged: (value) async {
                            vehicleProvider.setSelectedVehicle(value!);

                            setState(() {});
                            // modificar posteriormente paras sair do setState e ficar apenas com provider

                            await yearProvider.getYear();
                            vehicleProvider.setSelectedVehicle(value);
                          },
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
          SizedBox(height: 16),
          vehicleProvider.selectedVehicle?.id == null
              ? SizedBox(
                  height: 32,
                  width: 310,
                )
              : SizedBox(
                  height: 32,
                  width: 310,
                  child: AnimatedBuilder(
                    animation: yearProvider,
                    builder: (context, child) {
                      if (yearProvider.years.isEmpty) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        final List<YearModel> years = yearProvider.years;
                        return DropdownButtonFormField<YearModel>(
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          isExpanded: true,
                          hint: const Text(
                            "Ano",
                          ),
                          items: years
                              .map(
                                (year) => DropdownMenuItem(
                                  child: Text(year.name),
                                  value: year,
                                ),
                              )
                              .toList(),
                          onChanged: (value) async {
                            yearProvider.setSelectedYear(value!);
                            setState(() {});
                            // modificar posteriormente paras sair do setState e ficar apenas com provider

                            await priceProvider.getPrice();
                            yearProvider.setSelectedYear(value);
                            print(
                                "via yearProvider : ${yearProvider.selectedYear?.id}");
                          },
                          value: yearProvider.selectedYear,
                          validator: (_vehicle) {
                            final vehicle = _vehicle ?? "";

                            return null;
                          },
                        );
                      }
                    },
                  ),
                ),
          SizedBox(height: 16),
          yearProvider.selectedYear?.id == null
              ? SizedBox(
                  height: 32,
                  width: 310,
                )
              : SizedBox(
                  height: 32,
                  width: 310,
                  child: AnimatedBuilder(
                    animation: priceProvider,
                    builder: (context, child) {
                      if (priceProvider.prices.isEmpty) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        final List<CarDataModel> prices = priceProvider.prices;
                        return DropdownButtonFormField<CarDataModel>(
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          isExpanded: true,
                          hint: const Text(
                            "Valor",
                          ),
                          items: prices
                              .map(
                                (price) => DropdownMenuItem(
                                  child: Text(price.price),
                                  value: price,
                                ),
                              )
                              .toList(),
                          onChanged: (value) async {
                            priceProvider.setSelectedPrice(value!);
                            setState(() {});
                            // modificar posteriormente paras sair do setState e ficar apenas com provider

                            // await priceProvider.getPrice();
                            priceProvider.setSelectedPrice(value);
                          },
                          value: priceProvider.selectedPrice,
                          validator: (_price) {
                            final price = _price ?? "";

                            return null;
                          },
                        );
                      }
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

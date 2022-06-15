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
import '../models/car_model.dart';
import '../models/year_model.dart';
import '../services/year_service.dart';

class NewCarForm extends StatefulWidget with ChangeNotifier {
  // const NewCarForm({Key? key}) : super(key: key);
  final formkey = GlobalKey<FormState>();
  final formData = Map<String, Object>();

  void submit(context) async {
    final cars = Provider.of<Cars>(context, listen: false);
    bool isLoading = false;

    final isValid = formkey.currentState?.validate() ?? false;

    if (isValid != true) {
      return;
    }
    formkey.currentState?.save();

    isLoading = true;
    notifyListeners();

    try {
      await cars.saveCar(formData);
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
      isLoading = false;
      notifyListeners();
    }
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
  void didChangeDependencies() {
    final _submit = Provider.of<NewCarForm>(context);
    if (_submit.formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final car = arg as Car;
        _submit.formData["id"] = car.id;
        _submit.formData["brand"] = car.brand;
        _submit.formData["vehicles"] = car.vehicles;
        _submit.formData["year"] = car.year;
        _submit.formData["price"] = car.price;
        _submit.formData["imageUrl"] = car.imageUrl;
      }
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // var _selectedItem = priceProvider.selectedPrice;
    final _submit = Provider.of<NewCarForm>(context);

    final _formkey = _submit.formkey;
    final _formData = _submit.formData;

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
                    onSaved: (brand) =>
                        _formData["brand"] = brand!.name.toString(),
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
                      if (brand.toString().isEmpty) {
                        return "Item obrigatório";
                      }

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
                            "Modelo",
                          ),
                          items: vehicles
                              .map(
                                (vehicle) => DropdownMenuItem(
                                  value: vehicle,
                                  child: Text(vehicle.name),
                                ),
                              )
                              .toList(),
                          onSaved: (vehicles) =>
                              _formData["vehicles"] = vehicles!.name.toString(),
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
                            if (vehicle.toString().isEmpty) {
                              return "Item obrigatório";
                            }

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
                          onSaved: (year) =>
                              _formData["year"] = year!.name.toString(),
                          onChanged: (value) async {
                            yearProvider.setSelectedYear(value!);
                            setState(() {});
                            // modificar posteriormente paras sair do setState e ficar apenas com provider

                            await priceProvider.getPrice();
                            yearProvider.setSelectedYear(value);
                          },
                          value: yearProvider.selectedYear,
                          validator: (_year) {
                            final year = _year ?? "";
                            if (year.toString().isEmpty) {
                              return "Item obrigatório";
                            }

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
                                  value: price,
                                  child: Text(price.price),
                                ),
                              )
                              .toList(),
                          value: priceProvider.selectedPrice,
                          onSaved: (price) =>
                              _formData["price"] = price!.price.toString(),
                          onChanged: (value) {},
                          validator: (_price) {
                            final price = _price ?? "";
                            if (price.toString().isEmpty) {
                              return "Item obrigatório";
                            }

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

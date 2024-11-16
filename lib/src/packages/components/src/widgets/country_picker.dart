/*
import 'package:core/core.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rxdart/rxdart.dart';

class CountryCodePicker extends StatelessWidget {
  final Country selectedCountry;
  final void Function(Country country)? onSelectedCountryChanged;
  final bool hasIcon;
  final bool isValid;

  const CountryCodePicker({required this.selectedCountry, this.onSelectedCountryChanged, this.isValid = false, super.key}) : hasIcon = false;

  const CountryCodePicker.icon({required this.selectedCountry, this.onSelectedCountryChanged, this.isValid = false, super.key}) : hasIcon = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        onSelectedCountryChanged?.let((it) async {
          var country = await CountryCodePickerSheet.show(
            context,
            selectedCountryCode: selectedCountry.countryCode,
          );
          country?.let((country) => onSelectedCountryChanged?.call(country));
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasIcon) ...[
              CircleAvatar( 
                radius: 12,
                backgroundImage: AssetImage(
                  CountryPickerHelper.getFlagImageAssetPath(selectedCountry.isoCode),
                  package: "country_picker",
                ),
              ),
              const Gap(8),
            ],
            Flexible(
                child: CommonText.medium(
              "+${selectedCountry.phoneDetail.code}",
              size: 16,
              color: isValid ? context.colorScheme.secondary : null,
            )),
            const Gap(8),
            SvgImageFromAsset(AppIcons.arrowDown, color: isValid ? context.colorScheme.secondary : null),
            const Gap(8),
            Flexible(
              child: SizedBox(
                width: 1,
                height: 24,
                child: VerticalDivider(
                  endIndent: 2,
                  width: 1,
                  color: context.colorScheme.onSecondary,
                ),
              ),
            ),
            const Gap(8),
          ],
        ),
      ),
    );
  }
}

class CountryCodePickerSheet extends StatefulWidget {
  final String selectedCountryCode;

  const CountryCodePickerSheet({this.selectedCountryCode = "1", super.key});

  static Future<Country?> show(BuildContext context, {String selectedCountryCode = "1"}) async {
    var result = await showModalBottomSheet<Country>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.colorScheme.onPrimary.withOpacity(0.2),
      elevation: 0,
      builder: (context) => CountryCodePickerSheet(selectedCountryCode: selectedCountryCode),
    );
    return result;
  }

  @override
  CountryCodePickerSheetState createState() => CountryCodePickerSheetState();
}

class CountryCodePickerSheetState extends State<CountryCodePickerSheet> {
  late Country _selectedCountry;
  late PublishSubject<String> _searchTextSubject;
  late PublishSubject<Iterable<Country>> _countryListSubject;
  late TextEditingController _searchController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() => _countryListSubject.add(countryList)));
    _searchTextSubject = PublishSubject<String>()..stream.distinct().debounceTime(const Duration(milliseconds: 600)).listen(onSearch);
    _countryListSubject = PublishSubject<Iterable<Country>>()..add([]);
    _selectedCountry = countryList.where((element) => element.phoneDetail.code == widget.selectedCountryCode).first;
    _searchController = TextEditingController();
    super.initState();
  }

  void onSearch(String searchText) {
    if (searchText.isEmpty) {
      _countryListSubject.add(countryList);
    } else {
      _countryListSubject.add(
        countryList
            .where((element) => element.name.toLowerCase().contains(searchText) || element.phoneDetail.code.toLowerCase().contains(searchText)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: 0.5,
      initialChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: context.colorScheme.onPrimary,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Column(
            children: [
              Container(
                height: 4,
                width: 64,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: context.colorScheme.onBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: CommonTextField(
                  controller: _searchController,
                  textInputAction: TextInputAction.search,
                  keyboardType: TextInputType.text,
                  onChange: (value) => _searchTextSubject.add(value.toLowerCase().trim()),
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search, size: 20),
                    onPressed: () => FocusScope.of(context).unfocus(),
                    splashRadius: 24,
                  ),
                  hintText: "searchHere",
                ),
              ),
              Flexible(
                child: StreamBuilder<Iterable<Country>>(
                  stream: _countryListSubject,
                  builder: (context, snapshot) {
                    return Scrollbar(
                      controller: scrollController,
                      child: ListView.builder(
                        controller: scrollController,
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                        itemBuilder: (context, index) {
                          var country = snapshot.data!.elementAt(index);
                          return ListTile(
                            selectedTileColor: context.theme.primaryColor.withOpacity(0.1),
                            hoverColor: context.theme.primaryColor.withOpacity(0.05),
                            selected: country.phoneDetail.code == _selectedCountry.phoneDetail.code,
                            title: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  clipBehavior: Clip.hardEdge,
                                  child: Image.asset(
                                    CountryPickerHelper.getFlagImageAssetPath(country.isoCode),
                                    height: 20.0,
                                    width: 28.0,
                                    fit: BoxFit.cover,
                                    package: "country_picker",
                                  ),
                                ),
                                const Gap(8),
                                Expanded(
                                  flex: 1,
                                  child: FittedBox(
                                    alignment: AlignmentDirectional.centerStart,
                                    fit: BoxFit.scaleDown,
                                    child: CommonText.medium("+${country.phoneDetail.code}", size: 16),
                                  ),
                                ),
                                const Gap(8),
                                Expanded(flex: 4, child: CommonText.medium(country.name, size: 16)),
                              ],
                            ),
                            onTap: () {
                              Navigator.of(context).pop(country);
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
*/

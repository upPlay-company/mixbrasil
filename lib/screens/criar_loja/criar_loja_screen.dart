import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mix_brasil/common/error_box.dart';
import 'package:mix_brasil/model/criar_loja/criar_loja.dart';
import 'package:mix_brasil/screens/base/base_screen.dart';
import 'package:mix_brasil/screens/criar_loja/components/category_field.dart';
import 'package:mix_brasil/screens/criar_loja/components/image_capa_field.dart';
import 'package:mix_brasil/screens/criar_loja/components/image_ofertas_field.dart';
import 'package:mix_brasil/screens/criar_loja/components/image_story_field.dart';
import 'package:mix_brasil/screens/mylojas/my_lojas_screen.dart';
import 'package:mix_brasil/stores/create_loja_store.dart';
import 'package:mobx/mobx.dart';
import 'components/cep_lojas_field.dart';
import 'components/image_cupons_field.dart';

class CriarLojaScreen extends StatefulWidget {

  CriarLojaScreen({this.adLojas});

  final AdLojas adLojas;

  @override
  _CriarLojaScreenState createState() => _CriarLojaScreenState(adLojas);
}

class _CriarLojaScreenState extends State<CriarLojaScreen> {

  _CriarLojaScreenState(AdLojas adLojas)
      : editing = adLojas != null,
        createLojaStore = CreateLojaStore(adLojas: adLojas ?? AdLojas());

  final CreateLojaStore createLojaStore;

  bool editing;

  @override
  void initState() {
    super.initState();

    when((_) => createLojaStore.saveAd, () {
      if (editing)
        Navigator.of(context).pop(true);
      else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BaseScreen(),
          ),
        );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MyLojasScreen(),
          ),
        );
      }
    });
  }

  final labelStyle =
  TextStyle(fontWeight: FontWeight.w800, color: Colors.grey, fontSize: 18);

  final contentPadding = const EdgeInsets.fromLTRB(16, 10, 12, 10);

  static final _UsNumberTextInputFormatter _numberTextInputFormatter = new _UsNumberTextInputFormatter();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/Fundo mix 90.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            editing ? 'EDITANDO LOJA' : 'CRIE SUA LOJA',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Card(
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 8,
                child: Observer(
                  builder: (_) {
                    if (createLojaStore.loading)
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(
                              'Salvando Loja',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).primaryColor),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                  Theme.of(context).primaryColor),
                            )
                          ],
                        ),
                      );
                    else
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ImagesCapaField(createLojaStore),
                          ImagesOfertasField(createLojaStore),
                          ImagesStoryField(createLojaStore),
                          ImagesCuponsField(createLojaStore),
                          Observer(builder: (_) {
                            return TextFormField(
                              initialValue: editing ? createLojaStore.name : '',
                              onChanged: createLojaStore.SetName,
                              decoration: InputDecoration(
                                  labelText: 'Nome da loja *',
                                  labelStyle: labelStyle,
                                  contentPadding: contentPadding,
                                  errorText: createLojaStore.nameError),
                            );
                          }),
                          Observer(
                            builder: (_) {
                              return TextFormField(
                                initialValue: createLojaStore.promocao,
                                onChanged: createLojaStore.SetPromocao,
                                decoration: InputDecoration(
                                  labelText: 'Promoção da loja*',
                                  labelStyle: labelStyle,
                                  contentPadding: contentPadding,
                                  errorText: createLojaStore.promocaoError,
                                ),
                                maxLines: 1,
                              );
                            },
                          ),
                          CategoryField(createLojaStore),
                          CepLojasField(createLojaStore),
                          Observer(
                            builder: (_) {
                              return TextFormField(
                                initialValue: createLojaStore.priceText,
                                onChanged: createLojaStore.setPrice,
                                decoration: InputDecoration(
                                    labelText: 'Preço padrão*',
                                    labelStyle: labelStyle,
                                    contentPadding: contentPadding,
                                    prefixText: 'R\$',
                                    errorText: createLojaStore.priceError),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  RealInputFormatter(centavos: true)
                                ],
                              );
                            },
                          ),
                          Observer(
                            builder: (_) {
                              return TextFormField(
                                initialValue: createLojaStore.vagaEmprego,
                                onChanged: createLojaStore.SetVagaEmprego,
                                decoration: InputDecoration(
                                  labelText: 'Vaga de emprego *',
                                  labelStyle: labelStyle,
                                  contentPadding: contentPadding,
                                  errorText: createLojaStore.promocaoError,
                                ),
                                maxLines: null,
                              );
                            },
                          ),
                          Observer(
                            builder: (_) {
                              return TextFormField(
                                initialValue: createLojaStore.whats,
                                onChanged: createLojaStore.setWhats,
                                decoration: InputDecoration(
                                    labelText: 'WhatsApp*',
                                    labelStyle: labelStyle,
                                    contentPadding: contentPadding,
                                    errorText: createLojaStore.priceError),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(15),
                                  // ignore: deprecated_member_use
                                  WhitelistingTextInputFormatter.digitsOnly,
                                  _numberTextInputFormatter,
                                ],
                              );
                            },
                          ),
                          Observer(builder: (_) {
                            return ErrorBox(
                              message: createLojaStore.error,
                            );
                          }),
                          SizedBox(
                            height: 10,
                          ),
                          Observer(
                            builder: (_) {
                              return SizedBox(
                                height: 50,
                                child: GestureDetector(
                                  onTap: createLojaStore.invalidSendPressed,
                                  // ignore: deprecated_member_use
                                  child: RaisedButton(
                                    onPressed: createLojaStore.sendPressed,
                                    child: Text(
                                      'Enviar',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                          fontFamily: 'Principal'),
                                    ),
                                    textColor: Colors.white,
                                    color: Theme.of(context).secondaryHeaderColor,
                                    disabledColor: Theme.of(context).secondaryHeaderColor.withAlpha(100),
                                    elevation: 0,
                                    materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _UsNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue
      ) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 1) {
      newText.write('(');
      if (newValue.selection.end >= 1)
        selectionIndex++;
    }
    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 2) + ') ');
      if (newValue.selection.end >= 2)
        selectionIndex += 2;
    }
    if (newTextLength >= 7) {
      newText.write(newValue.text.substring(2, usedSubstringIndex = 7) + '-');
      if (newValue.selection.end >= 7)
        selectionIndex++;
    }
    if (newTextLength >= 11) {
      newText.write(newValue.text.substring(7, usedSubstringIndex = 11) + ' ');
      if (newValue.selection.end >= 15)
        selectionIndex++;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

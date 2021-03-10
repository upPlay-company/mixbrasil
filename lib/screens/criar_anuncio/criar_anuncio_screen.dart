import 'dart:ui';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mix_brasil/common/error_box.dart';
import 'package:mix_brasil/model/anuncio/ad.dart';
import 'package:mix_brasil/screens/base/base_screen.dart';
import 'package:mix_brasil/screens/myads/myads_screen.dart';
import 'package:mix_brasil/stores/create_store.dart';
import 'package:mix_brasil/stores/user_manager_store.dart';
import 'package:mobx/mobx.dart';
import 'package:mix_brasil/screens/login/login_screen.dart';
import 'components/category_desapego_field.dart';
import 'components/cep_field.dart';
import 'components/images_field.dart';

class CriarAnuncioScreen extends StatefulWidget {
  CriarAnuncioScreen({this.ad});

  final Ad ad;

  @override
  _CriarAnuncioScreenState createState() => _CriarAnuncioScreenState(ad);
}

class _CriarAnuncioScreenState extends State<CriarAnuncioScreen> {
  _CriarAnuncioScreenState(Ad ad)
      : editing = ad != null,
        createStore = CreateStore(ad: ad ?? Ad());

  final CreateStore createStore;

  bool editing;

  @override
  void initState() {
    super.initState();

    when((_) => createStore.saveAd, () {
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
            builder: (_) => MyAdsScreen(),
          ),
        );
      }
    });
  }

  final labelStyle =
      TextStyle(fontWeight: FontWeight.w800, color: Colors.grey, fontSize: 18);

  final contentPadding = const EdgeInsets.fromLTRB(16, 10, 12, 10);

  @override
  Widget build(BuildContext context) {
    final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
    if (userManagerStore.isLoggedIn)
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
                editing ? 'EDITANDO ANÚNCIO' : 'CRIE SEU DESAPEGO',
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
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 8,
                  child: Observer(
                    builder: (_) {
                      if (createStore.loading)
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                'Salvando Anúncio',
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
                            ImagesField(createStore),
                            Observer(builder: (_) {
                              return TextFormField(
                                initialValue: editing ? createStore.title : '',
                                onChanged: createStore.setTitle,
                                decoration: InputDecoration(
                                    hintText: 'Ex: Celular Sansumg A50',
                                    labelText: 'Título *',
                                    labelStyle: labelStyle,
                                    contentPadding: contentPadding,
                                    errorText: createStore.titleError),
                              );
                            }),
                            Observer(
                              builder: (_) {
                                return TextFormField(
                                  initialValue: createStore.description,
                                  onChanged: createStore.setDescription,
                                  decoration: InputDecoration(
                                    hintText: 'Ex: Celular Sansumg A50, com todo os acessórios...',
                                    labelText: 'Descrição *',
                                    labelStyle: labelStyle,
                                    contentPadding: contentPadding,
                                    errorText: createStore.descriptionError,
                                  ),
                                  maxLines: null,
                                );
                              },
                            ),
                            CategoryDesapegoField(createStore),
                            CepField(createStore),
                            Observer(
                              builder: (_) {
                                return TextFormField(
                                  initialValue: createStore.priceText,
                                  onChanged: createStore.setPrice,
                                  decoration: InputDecoration(
                                      hintText: 'Ex: 100,00',
                                      labelText: 'Preço *',
                                      labelStyle: labelStyle,
                                      contentPadding: contentPadding,
                                      prefixText: 'R\$',
                                      errorText: createStore.priceError),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    RealInputFormatter(centavos: true)
                                  ],
                                );
                              },
                            ),
                            Observer(builder: (_) {
                              return ErrorBox(
                                message: createStore.error,
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
                                    onTap: createStore.invalidSendPressed,
                                    // ignore: deprecated_member_use
                                    child: RaisedButton(
                                      onPressed: createStore.sendPressed,
                                      child: Text(
                                        'Enviar',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
                                            fontFamily: 'Principal'),
                                      ),
                                      textColor: Colors.white,
                                      color: Theme.of(context).primaryColor,
                                      disabledColor: Theme.of(context)
                                          .primaryColor
                                          .withAlpha(100),
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
          ));
    else
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
              'CRIE SEU DESAPEGO',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
            automaticallyImplyLeading: false,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Icon(
                      Icons.login,
                      size: 70.0,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      "Faça o login para criar seu desapego!",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 32.0,
                    ),
                    SizedBox(
                      height: 54.0,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        child: Text(
                          "Entrar",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                        },
                        disabledColor:
                            Theme.of(context).primaryColor.withAlpha(100),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/base');
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: Text(
                        'Voltar',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Principal'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }
}

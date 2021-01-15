import 'package:flutter/material.dart';
import 'package:mix_brasil/model/lojas/destaque.dart';
import 'package:mix_brasil/model/lojas/loja_destaque_manager.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:mix_brasil/screens/home/components/lojas_destaques_screen.dart';
import 'package:provider/provider.dart';

class SectionDestaques extends StatelessWidget {
  final DestaqueLoja lojasDestaque;

  SectionDestaques(this.lojasDestaque);

  @override
  Widget build(BuildContext context) {
    final userManager = context.watch<UserManager>();


    //Declarações de funções

    Widget _sectionDestaque(){
      return InkWell(
          onTap: () {
            if (lojasDestaque.id != null) {
              final product = context
                  .read<LojasDestaqueManager>()
                  .findProductByID(lojasDestaque.id);
              if (product != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => LojasDestaqueScreen(lojasDestaque)),
                );
              }
            }
          },
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              height: 120,
              child: Card(
                color: Colors.cyan[50],
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: SizedBox(
                        width: 130,
                        height: 90,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.network(
                            lojasDestaque.img.first,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            lojasDestaque.name,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            lojasDestaque.descricao,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[700]),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                'A partir de',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black),
                              ),
                              Text(
                                ' R\$${lojasDestaque.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )));
    }

   bool _checkEqualCity(){
      if(userManager.user.address.state != lojasDestaque.state)
        userManager.user.address.state = null;
      lojasDestaque.state = null;
      return true;
    }
    //fim Da declaração

    if (userManager.isLoggedIn &&
        userManager.user.address.state == lojasDestaque.state)
      return _sectionDestaque();
      // TODO: LISTAR MENSAGEM SE NÃO TIVE LOJAS NO ESTADO DO USER
    else if(!userManager.isLoggedIn || userManager.user == null)
      return _sectionDestaque();
    else if (userManager.isLoggedIn && _checkEqualCity())
      _checkEqualCity();
      /*return Text("Não a loja na sua cidade");*/
    else
      return Container(child: Text('não a lojas!!!'),);
    // TODO: CORRIGIR ERRO QUANDO O ESTADO DO USUARIO É NULL -> Resolvido
  }
}

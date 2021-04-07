import 'package:appservicable/src/models/productCategoryModel.dart';
import 'package:appservicable/src/models/tipoProductoModel.dart';
import 'package:appservicable/src/settings/colorz.dart';
import 'package:appservicable/src/settings/responsiveSize.dart';
import 'package:appservicable/src/viewmodels/promosViewModel.dart';
import 'package:appservicable/src/widgets/functionsCommoms.dart';
import 'package:appservicable/src/widgets/getImageInternetWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductosTipos extends StatefulWidget {
  @override
  _ProductosTiposState createState() => _ProductosTiposState();
}

class _ProductosTiposState extends State<ProductosTipos> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<TipoProducto> tipoProd =
        Provider.of<PromosViewModel>(context, listen: false)
            .tiposProductosSelected;
    ScreenUtil.init(context,
        width: SizesCustom.width,
        height: SizesCustom.height,
        allowFontScaling: true);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colorz.appBarBlue,
        automaticallyImplyLeading: true,
        title: Container(
            height: w(45),
            child: Image.asset("assets/images/logos/logoblanco_sinfondo.png")),
      ),
      floatingActionButton: Container(
        width: w(100),
        height: w(100),
        child: FloatingActionButton(
            isExtended: true,
            child: Center(
                child: Text(
              '¡Pídelo aquí!',
              style: TextStyle(fontSize: f(22)),
              textAlign: TextAlign.center,
            )),
            backgroundColor: Colorz.appBarBlue,
            onPressed: () {
              final dateTime= DateTime.now();
              int horaActual= dateTime.hour;
              (horaActual>=18)?
               Navigator.pushNamed(context, 'formularioQuieroComprar'):
               urlWhatsapp();
            }),
      ),
      body: Stack(children: <Widget>[
        CachedNetworkImage(
          fit: BoxFit.fill,
          width: w(480),
          height: h(900),
          imageUrl: tipoProd.first.urlbackground,
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: Container(
                width: w(100),
                height: w(100),
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                )),
          ),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: w(80)),
              _productSelected(),
              SizedBox(height: w(40)),
              _crearColumnas(context),
              SizedBox(
                height: w(20),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _crearColumnas(BuildContext context) {
    return Consumer<PromosViewModel>(builder: (context, model, _) {
      var size = MediaQuery.of(context).size;
      final double itemHeight = (size.height - h(360)) / 2;
      final double itemWidth = (size.width / 2) - w(5);
      final tiposproducto = model.tiposProductosSelected;
      var _aspecRadio = itemWidth / itemHeight;
      if (tiposproducto != null) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w(20)),
            child: Container(
              child: new GridView.builder(
                  itemCount: tiposproducto.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: (_aspecRadio), crossAxisCount: 2),
                  itemBuilder: (context, int i) {
                    return InkWell(
                      onTap: () {
                        (tiposproducto[i].descripcion == "''" ||
                                tiposproducto[i].descripcion == "")
                            ? Offstage()
                            : showDialogSlide(context, tiposproducto[i]);
                      },
                      child: Column(
                        children: [
                          Container(
                            child: new Card(
                                color: Colorz.slideDialog,
                                elevation: 5,
                                child: new Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: w(0)),
                                        getImageInternetWidget(
                                            tiposproducto[i].urlImage),
                                        Container(
                                            width: w(200),
                                            height: w(50),
                                            child: Text(
                                              tiposproducto[i].nombre.replaceAll('.','\n'),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: f(20)),
                                              textAlign: TextAlign.center,
                                            )),
                                        Container(
                                            height: w(4),
                                            width: double.infinity,
                                            color: Colors.white),
                                        InkWell(
                                          onTap: () {
                                            model.goPlanesProductos(
                                                tiposproducto[i], context);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              (tiposproducto[i]
                                                              .precio
                                                              .toString() ==
                                                          "''" ||
                                                      tiposproducto[i]
                                                              .precio
                                                              .toString() ==
                                                          "")
                                                  ? Offstage()
                                                  : Text(
                                                      'S/${tiposproducto[i].precio.toString()}.00',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: f(20)),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                              (tiposproducto[i]
                                                              .precio
                                                              .toString() !=
                                                          "''" &&
                                                      tiposproducto[i]
                                                              .precio
                                                              .toString() !=
                                                          "")
                                                  ? Offstage():Icon(Icons.keyboard_arrow_down,
                                                  size: w(30)),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: w(15)),
                                      ],
                                    ))),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }

  Widget _productSelected() {
    return Consumer<PromosViewModel>(builder: (context, model, _) {
      ProductCategory producto = model.productSelected;
      var size = MediaQuery.of(context).size;
      return Container(
        width: w(size.width / 1.62),
        child: new Card(
            color: Colorz.slideDialog,
            elevation: 5,
            child: new Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: w(15)),
                    getImageInternetWidget(producto.urlImage),
                    Center(
                      child: Container(
                          width: w(180),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                producto.nombre,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: f(20),
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ))),
                    ),
                    SizedBox(height: w(15)),
                  ],
                ))),
      );
    });
  }
}

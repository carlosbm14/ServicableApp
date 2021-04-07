import 'package:appservicable/src/models/productCategoryModel.dart';
import 'package:appservicable/src/settings/colorz.dart';
import 'package:appservicable/src/settings/responsiveSize.dart';
import 'package:appservicable/src/viewmodels/promosViewModel.dart';
import 'package:appservicable/src/widgets/functionsCommoms.dart';
import 'package:appservicable/src/widgets/getImageInternetWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductosMain extends StatefulWidget {
  @override
  _ProductosMainState createState() => _ProductosMainState();
}

class _ProductosMainState extends State<ProductosMain> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

        child: Center(child: Text('¡Pídelo aquí!', style: TextStyle(fontSize: f(22)), textAlign: TextAlign.center,)),
        backgroundColor: Colorz.appBarBlue,
        onPressed: () {
          final dateTime= DateTime.now();
          int horaActual= dateTime.hour;
          (horaActual>=18)?
          Navigator.pushNamed(context, 'formularioQuieroComprar'):
          urlWhatsapp();
        }
      ),
                      ),
      body: Stack(children: <Widget>[
        Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.center,
              image:
                  AssetImage("assets/images/backgrounds/productosCategory.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: w(40)),
                Text('Selecciona TU PLAN AQUÍ',
                    style: TextStyle(
                        fontSize: f(22), fontWeight: FontWeight.bold)),
                Container(width: w(320), height: w(2), color: Colors.black),
                SizedBox(height: w(20)),
                _crearColumnas(context),
                SizedBox(
                  height: w(20),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _crearColumnas(BuildContext context) {
    return Consumer<PromosViewModel>(builder: (context, model, _) {
      var size = MediaQuery.of(context).size;
      final double itemHeight = (size.height - h(320)) / 2;
      final double itemWidth = (size.width / 2) - w(5);
      final List<ProductCategory> producto = model.imagenesProductosCategory;
      var _aspecRadio = itemWidth / itemHeight;
      if (producto != null) {
        return Expanded(
          child: Container(
            child: new GridView.builder(
                itemCount: producto.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: (_aspecRadio), crossAxisCount: 2),
                itemBuilder: (context, int i) {
                  return InkWell(
                    onTap: (){
                      if(producto[i].nombre=='Planes Corporativos'){
                         final dateTime= DateTime.now();
                         int horaActual= dateTime.hour;
                          (horaActual>=18)?
                          Navigator.pushNamed(context, 'formularioQuieroComprar'):
                          urlWhatsapp();
                      }else{
                        model.goProductosTipos(producto[i], context);
                      }
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: w(15)),
                                      getImageInternetWidget(producto[i].urlImage),
                                      Center(
                                        child: Container(
                                            width: w(200),
                                            height: w(50),
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  producto[i].nombre,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: f(20),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ))),
                                      ),
                                      Container(height: w(4), width: double.infinity, color: Colors.white),
                                      Icon(Icons.keyboard_arrow_down, size: w(30)),
                                      SizedBox(height: w(15)),
                                    ],
                                  ))),
                        ),
                        SizedBox(height: w(60))
                      ],
                    ),
                  );
                }),
          ),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }

}

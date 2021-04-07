import 'package:appservicable/src/models/estadoCuentaModel.dart';
import 'package:appservicable/src/models/productosEstadoCuentaModel.dart';
import 'package:appservicable/src/settings/responsiveSize.dart';
import 'package:appservicable/src/viewmodels/estadoCuentaViewModel.dart';
import 'package:appservicable/src/viewmodels/parrillaHomeViewModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:appservicable/src/viewmodels/promosViewModel.dart';
import 'package:appservicable/src/models/backgroundModel.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  double sumaDeudaTotal=0;
  @override
  Widget build(BuildContext context) {

 var promos= Provider.of<PromosViewModel>(context, listen:false).imagenesBackgrounds;
         Background foto;
         if(promos.length>0){
            foto =  promos.where((i) => i.nombre=='estado_cuenta').first;
         }
         else{
           Provider.of<PromosViewModel>(context, listen:false).obtenerBackgrounds();
            foto=  null;
         }

    ScreenUtil.init(context,
        width: SizesCustom.width,
        height: SizesCustom.height,
        allowFontScaling: true);
        double totalDeuda=0;
    List<EstadoCuenta> estados =
        Provider.of<EstadoCuentaViewModel>(context, listen: false).estadoCuentaList;
        for (var item in estados) {
           totalDeuda= totalDeuda + item.sumanDebitos;
        }
    final _screenPantalla = MediaQuery.of(context).size;
    final _screeH = _screenPantalla.height;
    return Scaffold(
      //floatingActionButton: _createButton(_screeH, _screeW),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/backgrounds/login.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: CachedNetworkImage(
            fit: BoxFit.fill,
        imageUrl: (foto==null)?'':foto.urlImage,
        progressIndicatorBuilder: (context, url, downloadProgress) => 
                Center(
                  child: Container(
                    width: w(100),
                    height: w(100),
                    child: CircularProgressIndicator(value: downloadProgress.progress,)),
                ),
        errorWidget: (context, url, error) {
          
          return Container(
            color: Colors.black.withOpacity(0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Icon(Icons.portable_wifi_off, size: w(120), color: Colors.white),
                 Text('No posee conexión a Internet...', style: TextStyle(color: Colors.white, fontSize: f(25)),)
               ],
             ),
          );
        }
     )

          ),
             Column(
              children: <Widget>[
                _avatarHome(_screeH),
                SizedBox(
                  height: _screeH * 0.25,
                ),
                Container(
                  height: w(330),
                  child: ListView(
                      padding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: _screeH * 0.015,
                      ),
                      shrinkWrap: true,
                      children: _listViewWidget(
                        context,
                        Provider.of<EstadoCuentaViewModel>(context,
                                listen: false)
                            .listProductosEstadoCuenta,
                      )),
                ),
                Container(
                    padding: EdgeInsets.symmetric(
                      vertical: _screeH * 0.00,
                      horizontal: _screeH * 0.015,
                    ),
                    alignment: Alignment.centerRight,
                    child: ListTile(
                      leading: Icon(Icons.monetization_on, size: w(30)),
                      title: Text('Monto a Pagar',
                          style: TextStyle(
                              fontSize: f(20),
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900])),
                      trailing: Text('S/. $totalDeuda\0',
                          style: TextStyle(
                            fontSize: f(20),
                            fontWeight: FontWeight.bold,
                          )),
                    ))
              ],
            ),
        
          Positioned(
          top: w(40),
          right: w(0),
          child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, size: w(40), color: Colors.white),),
        )
        ],
        
      ),
    );
  }

  List<Widget> _listViewWidget(
    BuildContext context,
    List<ProductosEstadoCuenta> list,
  ) {
    List<Widget> listWidgets = [];
    for (var i = 0; i < ((list==null)?0:list.length); i++) {
      final widget = _widgetListaProductos(list[i], context);

      listWidgets..add(widget)..add(Divider(height: 1, color: Colors.black38));
    }

    return listWidgets;
  }

  Widget _widgetListaProductos(
    ProductosEstadoCuenta item,
    BuildContext context,
  ) {
    return _listTitle(item, context);
  }
  Widget _avatarHome(_screeH) {
    return Column(
      children: [
        SizedBox(
              height: w(41),
            ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            
            SizedBox(
              width: w(90.0),
            ),
            Consumer<ParrillaHomeViewModel>(builder: (context, model, _) {
                  return
                  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: w(330),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        model.nombresUser.toString().toUpperCase(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: f(23)
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height:w(2),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              
                              Image(
                                width: _screeH * 0.035,
                                height: w(30),
                                image:
                                    AssetImage("assets/images/logos/location.png"),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: w(5),
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  model.distritoUser,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: f(20),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );}),
          ],
        ),
      ],
    );
  }

  _listTitle(ProductosEstadoCuenta item, BuildContext context) {
  
    
    return ListTile(
      leading: (item.idProducto == 6)
          ? Icon(Icons.cast_connected, size: w(30))
          : (item.idProducto == 9)
              ? Icon(Icons.wifi, size: w(30))
              : (item.idProducto == 12)
                  ? Icon(Icons.tv, size: w(30))
                  : (item.idProducto == 17)
                      ? Icon(Icons.screen_lock_landscape, size: w(30))
                      : (item.idProducto == 18)
                          ? Icon(Icons.live_tv, size: w(30))
                          : (item.idProducto == 19)
                              ? Icon(Icons.camera_alt, size: w(30))
                              : (item.idProducto == 27)
                                  ? Icon(Icons.wifi_tethering, size: w(30)):
                                  (item.idProducto == 28)
                                  ? Icon(Icons.tv, size: w(30))
                                  : Icon(Icons.tv, size: w(30)),
      title: Text(item.nombreProducto, style: TextStyle(fontSize: f(20))),
      trailing:
          Text('S/. ${item.debitos.toString()}', style: TextStyle(fontSize: f(20))),
    );
  }
}

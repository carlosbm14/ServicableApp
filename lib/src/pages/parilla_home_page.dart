import 'package:appservicable/src/models/backgroundModel.dart';
import 'package:appservicable/src/models/productosEstadoCuentaModel.dart';
import 'package:appservicable/src/models/programacionModel.dart';
import 'package:appservicable/src/models/promoModel.dart';
import 'package:appservicable/src/models/referenciaPagoModel.dart';
import 'package:appservicable/src/services/dbLocal.dart';
import 'package:appservicable/src/settings/responsiveSize.dart';
import 'package:appservicable/src/viewmodels/checkConnection.dart';
import 'package:appservicable/src/viewmodels/estadoCuentaViewModel.dart';
import 'package:appservicable/src/viewmodels/parrillaHomeViewModel.dart';
import 'package:appservicable/src/viewmodels/programacionViewModel.dart';
import 'package:appservicable/src/viewmodels/promosViewModel.dart';
import 'package:appservicable/src/widgets/functionsCommoms.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ParrillaHome extends StatefulWidget {
  @override
  _ParrillaHomeState createState() => _ParrillaHomeState();
}

class _ParrillaHomeState extends State<ParrillaHome> {
  bool _cargando = false;
  @override
  void initState() {
    checkLists(context);
    final vm= Provider.of<ParrillaHomeViewModel>(context, listen:false);
     vm.nombresUser= prefs.nombres;
     vm.distritoUser= prefs.distrito;

    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vms=Provider.of<PromosViewModel>(context, listen: false);
    final progravm= Provider.of<ProgramacionViewModel>(context, listen: false);
      vms.obtenerBackgrounds();
      vms.obtenerpromos();
      vms.obtenerCarruselImages();
      vms.obtenerDistritos();
      vms.obtenerServiciosSolicitudServicios();
      vms.obtenerPlanesAumentodemegas();
      vms.obtenerCategoriaProductos();//principal
      vms.obtenerTiposProductos();//tipos
      vms.planesProductos();//descripcion
      progravm.obtenerprogramacion();
     // vms.obtenerDepartamentos();
     // vms.obtenerProductosSolicitudServicios();
     // vms.obtenerProductosAumentodeMegas();
    ScreenUtil.init(context,
        width: SizesCustom.width,
        height: SizesCustom.height,
        allowFontScaling: true);
    return Consumer<PromosViewModel>(builder: (context, model, _) {
      var promos= model.imagenesBackgrounds;
         Background foto;
         if(promos.length>0){
            foto =  promos.where((i) => i.nombre=='parrilla_home').first;
         }
         else{
           Provider.of<PromosViewModel>(context, listen:false).obtenerBackgrounds();
            foto=  null;
         }
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Stack(children: <Widget>[
        
       Container(
            constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/backgrounds/login.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: 
          (foto==null)?Offstage():
          CachedNetworkImage(
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
            
          );
        }
     )

          ),

         Padding(
            padding: EdgeInsets.symmetric(horizontal: w(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: SizedBox(),
                ),
                _crearColumnas(context),
                SizedBox(
                  height: w(20),
                ),
              ],
            ),
          ),
        
        Positioned(
          top: w(50),
          left: w(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BIENVENIDO:',
                style: TextStyle(
                    fontSize: f(22),
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Consumer<ParrillaHomeViewModel>(builder: (context, model, _) {
                  return Center(
                    child: Container(
                      width: w(300),
                      child: Text(
                        model.nombresUser.toString().toUpperCase(),
                        maxLines: 2,
                        style: TextStyle(fontSize: f(22), color: Colors.white),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  );}),
                  Align(
                    alignment: Alignment.topCenter,
                    child: 
                         InkWell(
                           
                        onTap: () {
                          Provider.of<ParrillaHomeViewModel>(context,
                                  listen: false)
                              .cerrarSesion(context);
                        },
                                                    child: Icon(
                            Icons.exit_to_app,
                            size: w(50),
                            color: Colors.yellow,
                        ),
                         )),
                  
                ],
              )
            ],
          ),
        )
      ]),
    );
    });
  }

  Widget _crearColumnas(BuildContext context) {
    final vm = Provider.of<ParrillaHomeViewModel>(context, listen: false);
    bool client = prefs.isClient;
    return Table(
      children: [
        TableRow(children: [
          _crearBotonRedondeado(Colors.purple[200], context, 'remoto.png',
              () async {
            final response = await avance(context);
            if (response) {
              vm.buttonPressed((client) ? 1 : 0, context);
            }
          }),
          _crearBotonRedondeado(Colors.green[200], context, 'enrutador.png',
              () async {
            final response = await avance(context);
            if (response) {
              vm.buttonPressed((client) ? 2 : 1, context);
            }
          }),
        ]),
        TableRow(children: [
          _crearBotonRedondeado(Colors.orange[200], context, 'tecnico.png',
              () async {
            final response = await avance(context);
            if (response) {
              vm.buttonPressed((client) ? 3 : 2, context);
            }
          }),
          _crearBotonRedondeado(Colors.blue[200], context, 'cuenta.png',
              () async {
            if (client) {
              final response = await avance(context);
              if (response) {
                vm.buttonPressed(0, context);
              }
            } else {
              Toast.show(
                "Debe ser cliente de Servicable para tener acceso al estado de cuenta.",
                context,
                duration: Toast.LENGTH_LONG,
                gravity: Toast.BOTTOM,
                textColor: Colors.white,
                backgroundColor: Colors.black.withOpacity(0.85),
              );
            }
          }),
        ]),
        TableRow(children: [
          _crearBotonRedondeado(Colors.tealAccent, context, 'whatsappx.png',
              () {
            urlWhatsapp();
          }),
          _crearBotonRedondeado(Colors.pink[200], context, 'contacto.png',
              () async {
            final response = await avance(context);
            if (response) {
              vm.buttonPressed((client) ? 4 : 3, context);
            }
          }),
        ]),
      ],
    );
  }

  Widget _crearBotonRedondeado(
      Color color, BuildContext context, String img, VoidCallback function) {
    return InkWell(
      onTap: function,
      child: Container(
        height: w(155),
        margin: EdgeInsets.all(w(7)),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(w(40.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('assets/images/iconos/$img'),
              fit: BoxFit.fill,
              width: w(90),
              height: w(90),
            ),
          ],
        ),
      ),
    );
  }

  void checkLists(BuildContext context) async {
    final vmPromo = Provider.of<PromosViewModel>(context, listen: false);
    final vmPrograma = Provider.of<ProgramacionViewModel>(context, listen: false);
    List<Promo> promoss = vmPromo.imagenesPromo;

    List<Programacion> imagenesCanales = vmPrograma.imagenesCanales;
    if (promoss.length == 0 || imagenesCanales.length == 0) {
      await vmPromo.obtenerpromos();
      await vmPrograma.obtenerprogramacion();
      await vmPromo.obtenerBackgrounds();
      await vmPromo.obtenerCarruselImages();
      await vmPromo.obtenerDistritos();
      await vmPromo.obtenerServiciosSolicitudServicios();
      await vmPromo.obtenerCategoriaProductos();//principal
      await vmPromo.obtenerTiposProductos();//tipos
      await vmPromo.planesProductos();//descripcion
     // await vmPromo.obtenerDepartamentos();
     // await vmPromo.obtenerProductosSolicitudServicios();
      await vmPromo.obtenerPlanesAumentodemegas();
    }
    final vm = Provider.of<EstadoCuentaViewModel>(context, listen: false);
    if (prefs.isClient && vm.listProductosEstadoCuenta==null){
      List<ReferenciaPago> refPago= vm.refPago;
      if(refPago.length==0){
        refPago= await DBLocalProvider.db.getReferenciasPago();
      }
      await vm.obtenerEstadoCuenta(
          282, 'mmarcano@servicable.com.pe', refPago);
    }
  }

  Future<bool> avance(BuildContext context) async {
    final vmPromo = Provider.of<PromosViewModel>(context, listen: false);
    final vmPrograma =
        Provider.of<ProgramacionViewModel>(context, listen: false);
    List<Promo> promoss = vmPromo.imagenesPromo;
    List<Programacion> imagenesCanales = vmPrograma.imagenesCanales;

    if (_cargando) {
      
      return false;
    }

    _cargando = true;
    bool retorno = false;
    _alertLoading(context);
    final isOnline = await CheckConecction().isOnline(context);

    if (isOnline) {
      if (promoss.length == 0 || imagenesCanales.length == 0) {
        await vmPromo.obtenerpromos();
        await vmPrograma.obtenerprogramacion();
      }
       final vm = Provider.of<EstadoCuentaViewModel>(context, listen: false);
      List<ProductosEstadoCuenta> listProd= vm.listProductosEstadoCuenta;
      if (prefs.isClient && (listProd==null)) {
        List<ReferenciaPago> refPago= vm.refPago;
      if(refPago.length==0){
        refPago= await DBLocalProvider.db.getReferenciasPago();
      }
        await vm.obtenerEstadoCuenta(
            321, 'jmiranda707luis@gmail.com', refPago); 
      }
      Navigator.pop(context);
      retorno = true;
      _cargando = false;
      
    } else {
      Navigator.pop(context);
      _cargando = false;
      retorno = false;
    }

    return retorno;
  }

  void _alertLoading(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: Text('', style: TextStyle(fontSize: f(20))),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(width: w(10)),
                Text(
                  'Cargando Data...',
                  style: TextStyle(fontSize: f(20)),
                ),
                //FlutterLogo(size:100.0),
              ],
            ),
            actions: <Widget>[
             
            ],
          );
        });
  }

}

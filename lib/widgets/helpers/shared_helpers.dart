
class Utils{

///
///  Método para formatear una fecha recibe [DateTime]
/// y el formato es: dia/mes/anio 21/10/2023 
///
static String dateFormatter( DateTime datetime ){

    final String date = datetime.toString().split(' ')[0];//.replaceAll('-','/');
    final dia  = date.split('-')[2];
    final mes  = date.split('-')[1];
    final anio = date.split('-')[0];

  return '$dia/$mes/$anio';
}

}


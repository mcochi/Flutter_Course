import 'package:flutter/material.dart';


class InputPage extends StatefulWidget {
  InputPage({Key key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String _nombre = '';
  String _email = '';
  String _password = '';
  String _fecha = '';
  String _opcionSeleccionada = 'Volar';
  TextEditingController _inputFieldDateController = new TextEditingController();
  List<String> _poderes = ["Volar","Rayos X","Fuerza"];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inputs de texto'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),
        children: <Widget>[
          _crearInput(),
          Divider(),
          _crearEmail(),
          Divider(),
          _crearPassword(),
          Divider(),
          _crearFecha(context),
          Divider(),
          _crearDropdown(),
          Divider(),
          _crearPersona(),

                  ],
                ),
              );
            }
          
  Widget _crearInput() {
    return TextField(
      //autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        counter: Text('Letras ${_nombre.length}'),
        hintText: 'Nombre de la persona',
        labelText: 'Nombre',
        helperText: 'Sólo es el nombre',
        suffixIcon: Icon(Icons.accessibility),
        icon: Icon(Icons.account_circle),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ), 
      ),
      onChanged: (valor) {
        setState(() {
          _nombre = valor;
        //print(valor);
        });
      },

    );
  }

  Widget _crearPersona() {
    return ListTile(
      title: Text('Nombre es: $_nombre'),
      subtitle: Text('Email: $_email'),
      trailing: Text('$_opcionSeleccionada')
    );
  }

  Widget _crearEmail() {
      return TextField(
      keyboardType: TextInputType.emailAddress,
      //autofocus: true,
      //textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        //counter: Text('Letras ${_nombre.length}'),
        hintText: 'Email',
        labelText: 'Email',
        //helperText: 'Sólo es el nombre',
        suffixIcon: Icon(Icons.alternate_email),
        icon: Icon(Icons.email),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ), 
      ),
      onChanged: (valor) {
        setState(() {
          _email = valor;
        //print(valor);
        });
      },

    );
  }

  Widget _crearPassword() {
    return TextField(
      obscureText: true,
      //autofocus: true,
      //textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        //counter: Text('Letras ${_nombre.length}'),
        hintText: 'Password',
        labelText: 'Password',
        //helperText: 'Sólo es el nombre',
        suffixIcon: Icon(Icons.lock_open),
        icon: Icon(Icons.lock),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ), 
      ),
      onChanged: (valor) {
        setState(() {
          _password = valor;
        //print(valor);
        });
      },

    );
  }

  Widget _crearFecha(BuildContext context){
    return TextField(
      controller: _inputFieldDateController,
      enableInteractiveSelection: false,
      //obscureText: true,
      //autofocus: true,
      //textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        //counter: Text('Letras ${_nombre.length}'),
        hintText: 'Fecha de Nacimiento',
        labelText: 'Fecha de Nacimiento',
        //helperText: 'Sólo es el nombre',
        suffixIcon: Icon(Icons.calendar_today),
        icon: Icon(Icons.calendar_view_day),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ), 
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());// Hace que se quite el foco de ese elemento para que pueda desplegarse el datapicker
        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context, 
      initialDate: new DateTime.now(), 
      firstDate: new DateTime(2018), 
      lastDate: new DateTime(2025),
      locale: Locale('es','ES'));

      if (picked != null) {
    setState(() {
      _fecha = picked.toString();
      _inputFieldDateController.text = _fecha;
    });
  }
  }
  List<DropdownMenuItem<String>> getOpcionesDropdrown() {
    List<DropdownMenuItem<String>> lista = new List();
    _poderes.forEach((poder) {
      lista.add(DropdownMenuItem(
        child: Text(poder),
        value: poder
        )
        );
        });
      return lista;
  }
  Widget _crearDropdown() {
    return Row(
      children: <Widget>[
        Icon(Icons.select_all),
        SizedBox(width: 30.0,),
        Expanded(
            child: DropdownButton(
            value: _opcionSeleccionada,
            items: getOpcionesDropdrown(),
            onChanged: (opt) {
              //print(opt);
              setState(() {
              _opcionSeleccionada = opt;
              });
            },
          ),
        ),
      ],
    );
  }
}
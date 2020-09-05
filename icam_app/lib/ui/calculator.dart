import 'package:flutter/material.dart';
import 'package:icam_app/localization/localization_constants.dart';
import 'package:flutter/services.dart';
import 'package:icam_app/theme.dart';
import 'package:icam_app/services/icam_service.dart';
import 'package:icam_app/classes/widgets.dart';


class CalculatorPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(getTranslated(context, "calculator"))
        ),
        body: GestureDetector(
            onTap: () {
              //  hide the soft keyboard clicking anywhere on the screen.
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Stack(
              children: <Widget> [
                ListView(
                  padding: const EdgeInsets.fromLTRB(
                    8.0,
                    kToolbarHeight - 30.0,
                    8.0,
                    16.0,
                  ),
                  children: <Widget> [
                    FormContainer()
                  ],
                ),
              ],
            )
        )
    );
  }
}


class FormContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Text(
                getTranslated(context, "icampff_calculator"),
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
                textAlign: TextAlign.justify,
              )
          ),
          IcamValues(),
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Container(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          Text(
                            getTranslated(context, "insert_params") ,
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Divider(
                            color: Colors.black38,
                            height: 20,
                          )
                        ],
                      )

                  ),
                  IcamForm(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


class IcamForm extends StatefulWidget {
  @override
  _IcamFormState createState() => _IcamFormState();
}


class _IcamFormState extends State<IcamForm> {

  final _formKey = GlobalKey<FormState>();

  // editing controllers
  var _dissolvedOxygenController = TextEditingController();
  var _nitrateController = TextEditingController();
  var _totalSuspendedSolidsController = TextEditingController();
  var _thermotolerantColiformsController = TextEditingController();
  var _pHController = TextEditingController();
  var _chrolophyllAController = TextEditingController();
  var _biochemicalOxygenDemandController = TextEditingController();
  var _phosphatesController = TextEditingController();

  // focus controllers
  final FocusNode _dissolvedOxygenFocus = FocusNode();
  final FocusNode _nitrateFocus = FocusNode();
  final FocusNode _totalSuspendedSolidsFocus = FocusNode();
  final FocusNode _thermotolerantColiformsFocus = FocusNode();
  final FocusNode _pHFocus = FocusNode();
  final FocusNode _chrolophyllAFocus = FocusNode();
  final FocusNode _biochemicalOxygenDemandFocus = FocusNode();
  final FocusNode _phosphatesFocus = FocusNode();

  var _icampff;

  void _getIcampff(params) async {
    final _icamData = await getIcampff(params);

    print("_icamData: $_icamData");

    setState(() {
      _icampff = _icamData["value"];
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          _buildTextFormField(context, _dissolvedOxygenController, _dissolvedOxygenFocus,
              _nitrateFocus, "dissolved_oxygen", Icons.filter_1, autofocus:true
          ),
          _buildTextFormField(context, _nitrateController, _nitrateFocus,
              _totalSuspendedSolidsFocus, "nitrate", Icons.filter_2
          ),
          _buildTextFormField(context, _totalSuspendedSolidsController, _totalSuspendedSolidsFocus,
              _thermotolerantColiformsFocus, "total_suspended_solids", Icons.filter_3
          ),
          _buildTextFormField(context, _thermotolerantColiformsController, _thermotolerantColiformsFocus,
              _pHFocus, "thermotolerant_coliforms", Icons.filter_4
          ),
          _buildTextFormField(context, _pHController, _pHFocus,
              _chrolophyllAFocus, "ph", Icons.filter_5
          ),
          _buildTextFormField(context, _chrolophyllAController, _chrolophyllAFocus,
              _biochemicalOxygenDemandFocus, "chrolophyll_a", Icons.filter_6
          ),
          _buildTextFormField(context, _biochemicalOxygenDemandController, _biochemicalOxygenDemandFocus,
              _phosphatesFocus, "biochemical_oxygen_demand", Icons.filter_7
          ),
          _buildTextFormField(context, _phosphatesController, _phosphatesFocus,
              null, "phosphates", Icons.filter_8
          ),

          SizedBox(height: 40.0),

          // icampff result
          Container(
            padding: EdgeInsets.all(12.0),
            color: Colors.black12,
            child: Row(
              children: [
                Text(
                  "ICAMpff: ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                  ),
                ),
                Spacer(),

                _icampff != null
                    ? Text(
                  "$_icampff",
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                )
                    : Text(""),

                const SizedBox(width: 20.0),
              ],
            ),
          ),

          SizedBox(height: 20.0),

          // RaisedButton
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: RaisedButton(
              padding: const EdgeInsets.all(10.0),
              elevation: 0,
//              shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(15.0)),
              color: myTheme.primaryColor,
              child: Text(
                getTranslated(context, "get_icampff"),
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {

                  // get values from form
                  Map<String, String> paramsToJson() => {
                    'dissolvedOxygen': _dissolvedOxygenController.text,
                    'nitrate': _nitrateController.text,
                    'totalSuspendedSolids': _totalSuspendedSolidsController.text,
                    'thermotolerantColiforms': _thermotolerantColiformsController.text,
                    'pH': _pHController.text,
                    'chrolophyllA': _chrolophyllAController.text,
                    'biochemicalOxygenDemand': _biochemicalOxygenDemandController.text,
                    'phosphates': _phosphatesController.text
                  };

                  _getIcampff(paramsToJson());

                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text(getTranslated(context, "processing_params")))
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

}

_buildTextFormField(context, controller, focus, nextfocus, label, icon, {autofocus=false}){

  var unit = "";

  switch(label){
    case "dissolved_oxygen":
      unit = "mg/L";
      break;
    case "nitrate":
      unit = "µg/L";
      break;
    case "total_suspended_solids":
      unit = "mg/L";
      break;
    case "thermotolerant_coliforms":
      unit = "NMP/100ml";
      break;
    case "ph":
      unit = "";
      break;
    case "chrolophyll_a":
      unit = "";
      break;
    case "biochemical_oxygen_demand":
      unit = "mg/L";
      break;
    case "phosphates":
      unit = "µg/L";
      break;
  }

  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.number,
    autofocus: autofocus,
    textInputAction: TextInputAction.next,
    focusNode: focus,
    onFieldSubmitted: (term) {
      _fieldFocusChange(context, focus, nextfocus);
    },
    decoration: InputDecoration(
      contentPadding: new EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
      labelText: getTranslated(context, label),
      labelStyle: TextStyle(fontSize: 14, color: Colors.black),
      hintText: unit,
      hintStyle: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
      errorStyle: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: Colors.red[700]
      ),
      icon: Icon(icon),
      fillColor: Colors.white,
      suffix: IconButton(
        onPressed: () => controller.clear(),
        icon: Icon(Icons.clear),
        color: myTheme.primaryColor,
      ),
    ),
    validator: (String value){
      if (value.isEmpty) {
        return getTranslated(context, "enter_value");
      }

      if(value == null) {
        return null;
      }
      final n = num.tryParse(value);
      String error = value + getTranslated(context, "not_valid_number");
      if(n == null) {
        return error;
      }
      return null;
    },
  );
}

//  handle the action and next focus
_fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
  currentFocus.unfocus();

  if(nextFocus != null) {
    FocusScope.of(context).requestFocus(nextFocus);
  }
}

class IcamValues extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(15),
        child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    getTranslated(context, "icam_values"),
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              SingleChildScrollView(
                padding: EdgeInsets.all(0),
                child: ListBody(
                  children: <Widget>[
                    DialogItem(
                      icon: Icons.brightness_1,
                      color: Colors.black54,
                      text: getTranslated(context, "unavailable"),
                    ),
                    DialogItem(
                      icon: Icons.brightness_1,
                      color: Colors.redAccent[700],
                      text: getTranslated(context, "poor"),
                    ),
                    DialogItem(
                      icon: Icons.brightness_1,
                      color: Colors.orange,
                      text: getTranslated(context, "inadequate"),
                    ),
                    DialogItem(
                      icon: Icons.brightness_1,
                      color: Colors.yellow[600],
                      text: getTranslated(context, "acceptable"),
                    ),
                    DialogItem(
                      icon: Icons.brightness_1,
                      color: Colors.green,
                      text: getTranslated(context, "adequate"),
                    ),
                    DialogItem(
                      icon: Icons.brightness_1,
                      color: myTheme.primaryColor,
                      text: getTranslated(context, "optimal"),
                    ),
                  ],
                ),
              )
            ]
        )

    );
  }

}
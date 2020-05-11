import 'package:flutter/material.dart';
import 'package:flutter_forms/form_model.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _newEmployee = EmployeeFormModel();

  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();

  bool _subimittedOnce = false;

  void _submit() {
    setState(() {
      _subimittedOnce = true;
    });
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(_newEmployee);
      Navigator.of(context).pop();
    }
  }

  Future<void> _showDOBPicker() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1, 1),
        lastDate: DateTime.now());

    if (selectedDate == null) return;

    // Write the date into the field
    // TODO: Format the date
    _dateController.text = selectedDate.toString();

    // Save date into _newEmployee object
    _newEmployee.dateOfBirth = selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Employee"),
      ),
      body: SingleChildScrollView(child: _buildFormBody(), physics: BouncingScrollPhysics()),
    );
  }

  Widget _buildFormBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            autovalidate: _subimittedOnce,
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildNameField(),
                SizedBox(
                  height: 20.0,
                ),
                _buildSalaryField(),
                SizedBox(
                  height: 20.0,
                ),
                _buildDOBField(),
                SizedBox(
                  height: 20.0,
                ),
                _buildGenderField(),
                SizedBox(
                  height: 40.0,
                ),
                _buildSubmitButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      validator: (value) {
        // Do the validation
        return value.isEmpty ? "Please enter a name" : null;
      },
      onSaved: (value) => _newEmployee.name = value,
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "ex: Adnan",
      ),
    );
  }

  Widget _buildSalaryField() {
    return TextFormField(
      validator: (value) {
        // Do the validation
        return value.isEmpty ? "Please enter a salary" : null;
      },
      onSaved: (value) => _newEmployee.salary = double.tryParse(value),
      decoration: InputDecoration(
        labelText: "Salary",
        hintText: "ex: 9000",
        suffixIcon: Icon(Icons.attach_money),
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildDOBField() {
    return TextFormField(
      controller: _dateController,
      validator: (value) {
        // Do the validation
        return value.isEmpty ? "Please enter a date" : null;
      },
      decoration: InputDecoration(
        labelText: "Date of Birth",
        suffixIcon: Icon(Icons.calendar_today),
      ),
      readOnly: true,
      onTap: _showDOBPicker,
    );
  }

  Widget _buildGenderField() {
    return DropdownButtonFormField<Gender>(
      decoration: InputDecoration(
        labelText: "Gender",
      ),
      items: [
        DropdownMenuItem(child: Text("Male"), value: Gender.MALE,),
        DropdownMenuItem(child: Text("Female"), value: Gender.FEMALE,),
      ],
      onChanged: (gender) => _newEmployee.gender = gender,
      validator: (value) {
        return value == null ? "Please select a gender" : null;
      },
    );
  }

  Widget _buildSubmitButton() {
    return RaisedButton(
      child: Text("Submit"),
      onPressed: _submit,
    );
  }
}


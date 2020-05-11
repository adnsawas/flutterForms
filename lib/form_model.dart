enum Gender { MALE, FEMALE }

class EmployeeFormModel {
  String name;
  double salary;
  DateTime dateOfBirth;
  Gender gender;

  @override
  String toString() {
    final genderText = gender == Gender.MALE ? "Male" : "Female";
    return "Name: $name, Salary: $salary, DOB: ${dateOfBirth.toString()}, Gender: $genderText";
  }
}
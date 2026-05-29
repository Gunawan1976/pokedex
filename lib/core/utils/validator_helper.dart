class ValidatorHelper {
  static String? validateBasicInput(String value, {int maxLength=0}){
    if(value.isEmpty){
      return 'Mohon isi bagian ini';
    }else{
      if(maxLength != 0){
        if(value.length > maxLength){
          return 'Tidak boleh melebihi $maxLength karakter';
        }else{
          return null;
        }
      }else{
        return null;
      }
    }
  }

  static String? validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Masukan email yang valid';
    } else {
      return null;
    }
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty || value.trim().isEmpty){
      return 'Masukkan nama yang valid';
    } else {
      String pattern = r'\d|[^\s\w]';
      RegExp regex = RegExp(pattern);
      if (regex.hasMatch(value)) {
        return 'Masukkan nama yang valid';
      } else {
        return null;
      }
    }
  }

  static String? validatePhoneNumber(String value) {
    String pattern = r'^(?:0|\+?62)?([2-9]\d{8,12})$';
    RegExp regex =  RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Masukkan nomor telpon yang valid';
    } else {
      return null;
    }
  }

  static String? validatePassword(String value) {
    String pattern = r'.{3,}';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Masukkan password yang sesuai!';
    } else {
      return null;
    }
  }

  static String? validatePasswordRegister(String value) {
    String pattern = r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Password minimal harus 8 karakter dengan huruf besar, huruf kecil dan angka';
    } else {
      return null;
    }
  }

  static String? validatePasswordRepeat(String value, String firstPass){
    String? temp = validatePassword(value);
    if(temp == null){
      if(value == firstPass){
        return null;  
      }else{
        return 'Password tidak sama!';
      }
    }else{
      return temp;
    }
  }
    
  static String? validateNumeric(String value){
    String patternIsDigit = r'^([1-9]\d*(\,)\d*|0?(\,|)\d*[1-9]\d*|[1-9]\d*)$';
    RegExp regexDigit = RegExp(patternIsDigit);

    if(regexDigit.hasMatch(value)){
      return null;
    }else{
      return 'Mohon masukkan nomor saja';
    }
  }
}


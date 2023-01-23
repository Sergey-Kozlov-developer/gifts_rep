/* ВОЗМОЖНЫЕ ОШИБКИ ВВОДА */

enum RegistrationEmailError { empty, invalid }

enum RegistrationPasswordError { empty, tooShort, wrongSymbol }

enum RegistrationPasswordConfirmationError { empty, different }

enum RegistrationNameError { empty }

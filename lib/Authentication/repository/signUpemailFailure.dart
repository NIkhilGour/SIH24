
class SignUpWithEmailandPasswordFailure {
  final String message;
  const SignUpWithEmailandPasswordFailure([this.message = "An Error Occured"]);


  factory SignUpWithEmailandPasswordFailure.code(String code){
     switch(code){
      case 'Weak Password':
         return const SignUpWithEmailandPasswordFailure('Please enter a strong password ');
      case 'Invalid email':
          return const SignUpWithEmailandPasswordFailure('Please enter a valid email ');
      case 'Email already used':
          return const SignUpWithEmailandPasswordFailure('Emaily already extist ');
      case 'Operation not allowed':
          return const SignUpWithEmailandPasswordFailure('Operation not allowed please contact us  ');
      case 'User Disable':
          return const SignUpWithEmailandPasswordFailure('This user is disabled please go for help ');
      default:
         return const SignUpWithEmailandPasswordFailure();
     }
  }
}

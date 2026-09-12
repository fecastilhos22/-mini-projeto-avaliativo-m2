class UserModel {
  // Atributos privados (encapsulamento) — o "_" antes do nome torna privado
  final int _id;
  final String _firstName;
  final String _lastName;
  final String _token;

  // Construtor — inicializa o objeto quando ele é criado
  UserModel({
    required int id,
    required String firstName,
    required String lastName,
    required String token,
  })  : _id = id,
        _firstName = firstName,
        _lastName = lastName,
        _token = token;

  // Getters — forma de acessar os atributos privados de fora da classe
  int get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get token => _token;

  String get fullName => '$_firstName $_lastName';

  // Factory constructor: cria um UserModel a partir do Map (JSON) que vem da API
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      token: json['accessToken'],
    );
  }

  // Polimorfismo: sobrescrevendo (@override) o método toString da classe Object
  @override
  String toString() => 'UserModel($_firstName $_lastName)';
}
class Cat {
  final String imageUrl;

  Cat({required this.imageUrl});

  factory Cat.fromCode(int code) {
    return Cat(imageUrl: 'https://http.cat/$code');
  }
}

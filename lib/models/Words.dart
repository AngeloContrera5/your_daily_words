class Words {
  int? idWord;
  String? wordsEng;
  String? wordsEsp;

  Words(idWord, wordsEng, wordsEsp) {
    this.idWord = idWord;
    this.wordsEng = wordsEng;
    this.wordsEsp = wordsEsp;
  }

  Words.fromJson(Map<String, dynamic> json) {
    idWord = json['id_word'];
    wordsEng = json['words_eng'];
    wordsEsp = json['words_esp'];
  }

  /*  Words.fromJson(dynamic json) {
    Words(json['id_word'], json['words_eng'], json['words_esp']);
  } */

  /*  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_word'] = this.idWord;
    data['words_eng'] = this.wordsEng;
    data['words_esp'] = this.wordsEsp;
    return data;
  } */

  /*  String toModelString() {
    return '{"id_word":"${idWord.toString()}"},' +
        '"words_eng":"${wordsEng.toString()}",' +
        '"words_esp":"${wordsEsp.toString()}",' +
        '}';
  } */
}

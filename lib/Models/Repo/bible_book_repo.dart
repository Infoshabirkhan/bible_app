




//https://www.rkeplin.com/the-holy-bible-open-source-rest-api/
// bible api
import 'package:bible_app/Models/models/bible_books.dart';

class BibleBookRepo{


  static Future<List<BibleBooksModel>>getBooks() async {

    List<BibleBooksModel> list = [];
     for(var item in bookList){
      BibleBooksModel model = BibleBooksModel.fromJson(item);

       list.add(model);
    }

     await Future.delayed(Duration(seconds: 1));
    return list;
  }




  static List bookList = [
  {
  "id": 1,
  "name": "Genesis",
  "testament": "OT",
    "bible_chapters" : 50,
  "genre": {
  "id": 1,
  "name": "Law"
  }
  },
  {
  "id": 2,
  "name": "Exodus",
    "bible_chapters" : 40,

  "testament": "OT",
  "genre": {
  "id": 1,
  "name": "Law"
  }
  },
  {
  "id": 3,
  "name": "Leviticus",
    "bible_chapters" : 27,

    "testament": "OT",
  "genre": {
  "id": 1,
  "name": "Law"
  }
  },
  {
  "id": 4,
  "name": "Numbers",
    "bible_chapters" : 36,
  "testament": "OT",
  "genre": {
  "id": 1,
  "name": "Law"
  }
  },
  {
  "id": 5,
  "name": "Deuteronomy",
    "bible_chapters" : 34,
  "testament": "OT",
  "genre": {
  "id": 1,
  "name": "Law"
  }
  },
  {
  "id": 6,
  "name": "Joshua",
    "bible_chapters" : 24,
  "testament": "OT",
  "genre": {
  "id": 2,
  "name": "History"
  }
  },
  {
  "id": 7,
  "name": "Judges",

    "bible_chapters" : 21,
  "testament": "OT",
  "genre": {
  "id": 2,
  "name": "History"
  }
  },
  {
  "id": 8,
  "name": "Ruth",
    "bible_chapters" : 4,
  "testament": "OT",
  "genre": {
  "id": 2,
  "name": "History"
  }
  },
  {
  "id": 9,
  "name": "1 Samuel",
    "bible_chapters" : 31,
  "testament": "OT",
  "genre": {
  "id": 2,
  "name": "History"
  }
  },
  {
  "id": 10,
  "name": "2 Samuel",
    "bible_chapters" : 24,
  "testament": "OT",
  "genre": {
  "id": 2,
  "name": "History"
  }
  },
  {
  "id": 11,
  "name": "1 Kings",
    "bible_chapters" : 22,
  "testament": "OT",
  "genre": {
  "id": 2,
  "name": "History"
  }
  },
  {
  "id": 12,
  "name": "2 Kings",
    "bible_chapters" : 25,
  "testament": "OT",
  "genre": {
  "id": 2,
  "name": "History"
  }
  },
  {
  "id": 13,
  "name": "1 Chronicles",
    "bible_chapters" : 29,
  "testament": "OT",
  "genre": {
  "id": 2,
  "name": "History"
  }
  },
  {
  "id": 14,
  "name": "2 Chronicles",
    "bible_chapters" : 36,
  "testament": "OT",
  "genre": {
  "id": 2,
  "name": "History"
  }
  },
  {
  "id": 15,
  "name": "Ezra",
    "bible_chapters" : 10,
  "testament": "OT",
  "genre": {
  "id": 2,
  "name": "History"
  }
  },
  {
  "id": 16,
  "name": "Nehemiah",
    "bible_chapters" : 13,
  "testament": "OT",
  "genre": {
  "id": 2,
  "name": "History"
  }
  },
  {
  "id": 17,
  "name": "Esther",
    "bible_chapters" : 10,
  "testament": "OT",
  "genre": {
  "id": 2,
  "name": "History"
  }
  },
  {
  "id": 18,
  "name": "Job",
    "bible_chapters" : 42,
  "testament": "OT",
  "genre": {
  "id": 3,
  "name": "Wisdom"
  }
  },
  {
  "id": 19,
  "name": "Psalms",
    "bible_chapters" : 150,
  "testament": "OT",
  "genre": {
  "id": 3,
  "name": "Wisdom"
  }
  },
  {
  "id": 20,
  "name": "Proverbs",
    "bible_chapters" : 31,
  "testament": "OT",
  "genre": {
  "id": 3,
  "name": "Wisdom"
  }
  },
  {
  "id": 21,
  "name": "Ecclesiastes",
    "bible_chapters" : 12,
  "testament": "OT",
  "genre": {
  "id": 3,
  "name": "Wisdom"
  }
  },
  {
  "id": 22,
  "name": "Song of Solomon",
    "bible_chapters" : 8,
  "testament": "OT",
  "genre": {
  "id": 3,
  "name": "Wisdom"
  }
  },
  {
  "id": 23,
  "name": "Isaiah",
    "bible_chapters" : 66,
  "testament": "OT",
  "genre": {
  "id": 4,
  "name": "Prophets"
  }
  },
  {
  "id": 24,
  "name": "Jeremiah",
    "bible_chapters" : 52,
  "testament": "OT",
  "genre": {
  "id": 4,
  "name": "Prophets"
  }
  },
  {
  "id": 25,
  "name": "Lamentations",
    "bible_chapters" : 5,
  "testament": "OT",
  "genre": {
  "id": 4,
  "name": "Prophets"
  }
  },
  {
  "id": 26,
  "name": "Ezekiel",
    "bible_chapters" : 48,
  "testament": "OT",
  "genre": {
  "id": 4,
  "name": "Prophets"
  }
  },
  {
  "id": 27,
  "name": "Daniel",
    "bible_chapters" : 12,
  "testament": "OT",
  "genre": {
  "id": 4,
  "name": "Prophets"
  }
  },
  {
  "id": 28,
  "name": "Hosea",
    "bible_chapters" : 14,
  "testament": "OT",
  "genre": {
  "id": 4,
  "name": "Prophets"
  }
  },
  {
  "id": 29,
  "name": "Joel",
    "bible_chapters" : 3,
  "testament": "OT",
  "genre": {
  "id": 4,
  "name": "Prophets"
  }
  },
  {
  "id": 30,
  "name": "Amos",
    "bible_chapters" : 9,
  "testament": "OT",
  "genre": {
  "id": 4,
  "name": "Prophets"
  }
  },
  {
  "id": 31,
  "name": "Obadiah",
    "bible_chapters" : 1,
  "testament": "OT",
  "genre": {
  "id": 4,
  "name": "Prophets"
  }
  },
  {
  "id": 32,
  "name": "Jonah",
    "bible_chapters" : 4,
  "testament": "OT",
  "genre": {
  "id": 4,
  "name": "Prophets"
  }
  },
  {
  "id": 33,
  "name": "Micah",
    "bible_chapters" : 7,
  "testament": "OT",
  "genre": {
  "id": 4,
  "name": "Prophets"
  }
  },
  {
  "id": 34,
  "name": "Nahum",
    "bible_chapters" : 3,
  "testament": "OT",
  "genre": {
  "id": 4,
  "name": "Prophets"
  }
  },
  {
  "id": 35,
  "name": "Habakkuk",
    "bible_chapters" : 3,
  "testament": "OT",
  "genre": {
  "id": 4,
  "name": "Prophets"
  }
  },
  {
  "id": 36,
  "name": "Zephaniah",
    "bible_chapters" : 3,
  "testament": "OT",
  "genre": {
  "id": 4,
  "name": "Prophets"
  }
  },
  {
  "id": 37,
  "name": "Haggai",
    "bible_chapters" : 2,
  "testament": "OT",
  "genre": {
  "id": 4,
  "name": "Prophets"
  }
  },
  {
  "id": 38,
  "name": "Zechariah",
    "bible_chapters" : 14,
  "testament": "OT",
  "genre": {
  "id": 4,
  "name": "Prophets"
  }
  },
  {
  "id": 39,
  "name": "Malachi",
    "bible_chapters" : 4,
  "testament": "OT",
  "genre": {
  "id": 4,
  "name": "Prophets"
  }
  },
  {
  "id": 40,
  "name": "Matthew",
    "bible_chapters" : 28,
  "testament": "NT",
  "genre": {
  "id": 5,
  "name": "Gospels"
  }
  },
  {
  "id": 41,
  "name": "Mark",
    "bible_chapters" : 16,
  "testament": "NT",
  "genre": {
  "id": 5,
  "name": "Gospels"
  }
  },
  {
  "id": 42,
  "name": "Luke",
    "bible_chapters" : 24,
  "testament": "NT",
  "genre": {
  "id": 5,
  "name": "Gospels"
  }
  },
  {
  "id": 43,
  "name": "John",
    "bible_chapters" : 21,
  "testament": "NT",
  "genre": {
  "id": 5,
  "name": "Gospels"
  }
  },
  {
  "id": 44,
  "name": "Acts",
    "bible_chapters" : 28,
  "testament": "NT",
  "genre": {
  "id": 6,
  "name": "Acts"
  }
  },
  {
  "id": 45,
  "name": "Romans",
    "bible_chapters" : 16,
  "testament": "NT",
  "genre": {
  "id": 7,
  "name": "Epistles"
  }
  },
  {
  "id": 46,
  "name": "1 Corinthians",
    "bible_chapters" : 16,
  "testament": "NT",
  "genre": {
  "id": 7,
  "name": "Epistles"
  }
  },
  {
  "id": 47,
  "name": "2 Corinthians",
    "bible_chapters" : 13,
  "testament": "NT",
  "genre": {
  "id": 7,
  "name": "Epistles"
  }
  },
  {
  "id": 48,
  "name": "Galatians",
    "bible_chapters" : 6,
  "testament": "NT",
  "genre": {
  "id": 7,
  "name": "Epistles"
  }
  },
  {
  "id": 49,
  "name": "Ephesians",
    "bible_chapters" : 6,
  "testament": "NT",
  "genre": {
  "id": 7,
  "name": "Epistles"
  }
  },
  {
  "id": 50,
  "name": "Philippians",
    "bible_chapters" : 4,
  "testament": "NT",
  "genre": {
  "id": 7,
  "name": "Epistles"
  }
  },
  {
  "id": 51,
  "name": "Colossians",
    "bible_chapters" : 4 ,
  "testament": "NT",
  "genre": {
  "id": 7,
  "name": "Epistles"
  }
  },
  {
  "id": 52,
  "name": "1 Thessalonians",
    "bible_chapters" : 5,
  "testament": "NT",
  "genre": {
  "id": 7,
  "name": "Epistles"
  }
  },
  {
  "id": 53,
  "name": "2 Thessalonians",
    "bible_chapters" : 3,
  "testament": "NT",
  "genre": {
  "id": 7,
  "name": "Epistles"
  }
  },
  {
  "id": 54,
  "name": "1 Timothy",
    "bible_chapters" : 6,
  "testament": "NT",
  "genre": {
  "id": 7,
  "name": "Epistles"
  }
  },
  {
  "id": 55,
  "name": "2 Timothy",
    "bible_chapters" : 4,
  "testament": "NT",
  "genre": {
  "id": 7,
  "name": "Epistles"
  }
  },
  {
  "id": 56,
  "name": "Titus",
    "bible_chapters" : 3,
  "testament": "NT",
  "genre": {
  "id": 7,
  "name": "Epistles"
  }
  },
  {
  "id": 57,
  "name": "Philemon",
    "bible_chapters" : 1,
  "testament": "NT",
  "genre": {
  "id": 7,
  "name": "Epistles"
  }
  },
  {
  "id": 58,
  "name": "Hebrews",
    "bible_chapters" : 13,
  "testament": "NT",
  "genre": {
  "id": 7,
  "name": "Epistles"
  }
  },
  {
  "id": 59,
  "name": "James",
    "bible_chapters" : 5,
  "testament": "NT",
  "genre": {
  "id": 7,
  "name": "Epistles"
  }
  },
  {
  "id": 60,
  "name": "1 Peter",
    "bible_chapters" : 5,
  "testament": "NT",
  "genre": {
  "id": 7,
  "name": "Epistles"
  }
  },
  {
  "id": 61,
  "name": "2 Peter",
    "bible_chapters" : 3,
  "testament": "NT",
  "genre": {
  "id": 7,
  "name": "Epistles"
  }
  },
  {
  "id": 62,
  "name": "1 John",
    "bible_chapters" : 5,
  "testament": "NT",
  "genre": {
  "id": 7,
  "name": "Epistles"
  }
  },
  {
  "id": 63,
  "name": "2 John",
    "bible_chapters" : 1,
  "testament": "NT",
  "genre": {
  "id": 7,
  "name": "Epistles"
  }
  },
  {
  "id": 64,
  "name": "3 John",
    "bible_chapters" :1,
  "testament": "NT",
  "genre": {
  "id": 7,
  "name": "Epistles"
  }
  },
  {
  "id": 65,
  "name": "Jude",
    "bible_chapters" : 1,
  "testament": "NT",
  "genre": {
  "id": 7,
  "name": "Epistles"
  }
  },
  {
  "id": 66,
  "name": "Revelation",
    "bible_chapters" : 22,
  "testament": "NT",
  "genre": {
  "id": 8,
  "name": "Apocalyptic"
  }
  }
  ];


}
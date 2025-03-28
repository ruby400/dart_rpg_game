import 'dart:io';

import 'package:dart_rpg_game/dart_rpg_game.dart' as dart_rpg_game;

void main() {
  // 1. 파일로부터 데이터 읽어오기
  // 1-1. characters.txt. 에서 체력, 공격, 방어력 읽어오기
  final characterFile = File('assets/characters.txt');
  // 문자열 vs 바이트 => 사람이 해석하기 불편한 형태
  final characterFileString = characterFile.readAsStringSync();
  // "50,10,5"
  // 콤마단위로 문자열을 분리하기
  List<String> charStats = characterFileString.split(",");
  print(charStats);
  // [50, 10, 5]

  Character char = Character(
    "유저",
    int.parse(charStats[0]),
    int.parse(charStats[1]),
    int.parse(charStats[2]),
  );

  print(
    "캐릭터 이름 : ${char.name} 체력 : ${char.hp} 공격력 : ${char.attackPower} 방어력 : ${char.def}",
  );

  // 1-2 monsters.txt 에서 이름, 체력, 공격력 최대값 읽어오기
  final monsterFile = File('assets/monsters.txt');
  String monsterString = monsterFile.readAsStringSync();
  print(monsterString);
  // Batman,30,20
  // Spiderman,20,30
  // Superman,30,10

  // 몬스터 가공하기 1 : 줄별로 분리하기
  List<String> monsterLines = monsterString.split('\n');
  print(monsterLines);
  // [Batman,30,20, Spiderman,20,30, Superman,30,10]

  List<Monster> monsters = [];
  print("몬스터 리스트 갯수 : ${monsters.length}");

  // 몬스터 가공하기 2 : 각 줄별로 이름, 체력, 공격력 최대값 분리하기
  // for문 (변수 선언 ; 조건문 ; 중괄호 끝나고 실행할 코드){}
  for (var i = 0; i < monsterLines.length; i++) {
    String line = monsterLines[i];
    print(line);

    // 몬스터이름, 몬스터 체력, 최대공격력 형태로 되어있는 line 각각 분리하기
    // => 콤마단위로 분리
    List<String> monsterInfos = line.split(',');
    print(monsterInfos);
    // [Superman, 30, 10]
    Monster monster = Monster(
      monsterInfos[0],
      int.parse(monsterInfos[1]),
      int.parse(monsterInfos[2]),
    );

    monsters.add(monster);
    print("$i 번째 몬스터 : ${monster.name} ${monster.hp} ${monster.maxAttack}");
  }
  print("몬스터 리스트 갯수 : ${monsters.length}");
  //2. 사용자로부터 캐릭터 이름 입력받기 기능
  //특수문자나 숫자가 포함되지 않아야함
  //3. 게임 종료 후 결과를 파일에 저장
}

/// 게임을 정의하기 위한 클래스 : Game
class Game {
  // 초기화되지 않은(값이 들어가지 않은) 속성들이 값을 할당해줄수있는
  // 특별한 함수 만들어주기 => '생성자'
  Game(this.character, this.monsters);

  // 속성
  /// 캐릭터 (Character)
  Character character;

  /// 몬스터 리스트 (List<Monster>)
  List<Monster> monsters;

  /// 물리친 몬스터 개수 (int)
  int monsterCount = 0;

  // 메서드
  // 게임을 시작하는 메서드(staertGame())
  // 전투를 진행하는 메서드(battle())
  // 랜덤으로 몬스터를 불러오는 메서드(getRandomMonster())
}

/// 캐릭터를 정의하기 위한 클래스 : Character
class Character {
  Character(this.name, this.hp, this.attackPower, this.def);

  // 속성
  /// 이름 (String)
  String name;

  /// 체력 (int)
  int hp;

  /// 공격력(int)
  int attackPower;

  /// 방어력 (int)
  int def;

  // 메서드
  // 공격 메서드 (attackMonster(Monster monster)
  // 방어 메서드 (defend())
  // 상태를 출력하는 메서드 (showStatus())
}

/// 몬스터를 정의하기 위한 클래스 : Monster
class Monster {
  Monster(this.name, this.hp, this.maxAttack);

  // 속성
  /// 이름(String)
  String name;

  /// 체력 (int)
  int hp;

  /// 랜덤으로 지정할 공격력 범위 최대값 (int)
  int maxAttack;
  // 방어력(int) = 0
  int def = 0;

  //메서드
  // 공격 메서드 (attackCharacter(Character character))
  // 상태를 출력하는 메서드 (showStatus())
}

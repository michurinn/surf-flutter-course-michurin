// Тексаотвые константы
class AppStrings {
  static const sight1workTime = "Закрыто до 20:00";
  static const sight2workTime = "Открыто до 1:00";
  static const sight3workTime = "Открытие 21.12.2023";

  static const listOfInterestingPlases = "Список интересных мест";

  static const newPlaceAdded = "Добавлено новое место";

  static const sight0subscr = "Место в Петергофе, маршрут для прогулки";
  static const sight1subscr = "Форт неадлеко от Кронштадта";
  static const sight2subscr = "Замок в г.Выборг";

  static const nature = "Природа";
  static const excursions = "Экскурсии";
  static const hotel = "Отель";
  static const restraunt = "Ресторан";
  static const uniquePlace = "Особое место";
  static const park = "Парк";
  static const museum = "Музей";
  static const cafe = "Кафе";

  static const wouldLikeToVisit = "Хочу посетить";
  static const justVisited = "Посетил";

  static const favoritePlaces = "Избранное";

  static const buildRoute = "Построить маршрут";
  static const addToCalendar = "Запланировать";
  static const inFavorite = "В избранное";

  static const distance = "Расстояние";
  static const categories = "Категории";
  static const clearIt = "Очистить";

  static const settings = "Настройки";
  static const darkTheme = "Тёмная тема";
  static const showTutorial = "Смотреть туториал";

  static const bottomLabel1 = "List of Places";
  static const bottomLabel2 = "Map";
  static const bottomLabel3 = "Favorite places";
  static const bottomLabel4 = "Settings";

  static const cancel = "Отмена";
  static const newPlace = "Новое место";
  static const category = "Категория";
  static const name = "Название";
  static const width = "Широта";
  static const height = "Долгота";
  static const putOnMap = "Указать на карте";
  static const description = "Описание";
  static const inputText = "Введите текст";
  static const create = "Создать";
  static const save = "Сохранить";
  static const doesntChosen = "Не выбрано";

  static const onStart = "На старт";
  static const skip = "Пропустить";
  static const delete = "Удалить";
  static const search = "Поиск";
  static const youFound = "Вы искали";
  static const clearHistore = "Очистить историю";
  static const nothingFinded = "Ничего не найдено";
  static const tryToChangeSearchParams = "Попробуйте изменить параметры поиска";
}

// Возможные категории
enum SightType {
  cafe(
    AppStrings.cafe,
    'assets/icons/cafe.svg',
  ),
  museum(
    AppStrings.museum,
    'assets/icons/museum.svg',
  ),
  park(
    AppStrings.park,
    'assets/icons/park.svg',
  ),
  superPlace(
    AppStrings.uniquePlace,
    'assets/icons/unique_place.svg',
  ),
  restraunt(
    AppStrings.restraunt,
    'assets/icons/restraunt.svg',
  ),
  hotel(
    AppStrings.hotel,
    'assets/icons/hotel.svg',
  );

  const SightType(this.type, this.icon);
  final String type;
  final String icon;
}

// Возможные категории
enum OnboardingTexts {
  screen1(
    'Добро пожаловать в Путеводитель',
    'Ищи новые локации и сохраняй самые любимые. ',
  ),
  screen2(
    'Построй маршрут и отправляйся в путь',
    'Достигай цели максимально быстро и комфортно.',
  ),
  screen3(
    'Добавляй места, которые нашёл сам',
    'Делись самыми интересными и помоги нам стать лучше!',
  );

  const OnboardingTexts(this.title, this.subTitle);
  final String title;
  final String subTitle;
}
